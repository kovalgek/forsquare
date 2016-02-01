//
//  VenueViewController.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "PhotosViewController.h"
#import "ServiceRegistry.h"
#import "VenueService.h"
#import "VenueCache.h"
#import "Venue.h"
#import "PhotoGroup.h"
#import "PhotoItem.h"
#import "Photo.h"
#import "PhotoItemCell.h"
#import "MBProgressHUD.h"
#import "Helper.h"

@interface PhotosViewController() <VenueServiceDelegate>
@property (nonatomic, strong) Venue *venue;
@property (strong, nonatomic) MBProgressHUD *loader;
@end

@implementation PhotosViewController

- (void)loadView
{
    [super loadView];
    
    self.loader = [[MBProgressHUD alloc] initWithView:self.view];
    self.loader.animationType = MBProgressHUDAnimationZoomIn;
    self.loader.labelText = @"Requesting photos...";
    [self.view addSubview:self.loader];
    [self.loader show:YES];
    
    self.venue = [((VenueCache *)SREG.serviceLayer.venueService.abstractCache) venueByID:self.venueID];
    
    SREG.serviceLayer.venueService.delegate = self;
    [SREG.serviceLayer.venueService requestDetailedInfoForVenue:self.venue];
}


- (void)didReceiveVenue:(Venue *)venue
{
    [self.loader hide:YES];
    [self.tableView reloadData];
}

- (void)requestingVenueDetailedInfoFailedWithError:(NSError *)error
{
    [self.loader hide:YES];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:[NSString stringWithFormat: @"Network error domain:%@ code:%ld",error.domain, (long)[error code]]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okButton];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    PhotoGroup *photoGroup = [[self.venue.photos sortedGroup] objectAtIndex:section];
    return photoGroup.nameAttribute;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.venue.photos.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    PhotoGroup *photoGroup = [[self.venue.photos sortedGroup] objectAtIndex:section];
    return photoGroup.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoGroup *photoGroup = [[self.venue.photos sortedGroup] objectAtIndex:indexPath.section];
    PhotoItem *photoItem = [[photoGroup sortedByCrationAtPhotoItems] objectAtIndex:indexPath.row];
    
    float ratio = photoItem.widthAttribute.floatValue / photoItem.heightAttribute.floatValue;
    return self.view.frame.size.width / ratio;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    
    PhotoItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PhotoItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    PhotoGroup *photoGroup = [[self.venue.photos sortedGroup] objectAtIndex:indexPath.section];
    PhotoItem *photoItem = [[photoGroup sortedByCrationAtPhotoItems] objectAtIndex:indexPath.row];
    
    cell.picture.image = nil;
    
    if(photoItem.imageAttribute)
    {
        cell.picture.image = [UIImage imageWithData:photoItem.imageAttribute];
    }
    else
    {
        if(photoItem.prefixAttribute && photoItem.suffixAttribute)
        {
            if(!photoItem.imageIsDownloadingAttribute.boolValue)
            {
                photoItem.imageIsDownloadingAttribute = @YES;
                [cell.activityView startAnimating];
                
                [self downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@original%@",photoItem.prefixAttribute,photoItem.suffixAttribute]] completionBlock:^(BOOL succeeded, UIImage *image)
                 {
                     if (succeeded)
                     {
                         photoItem.imageIsDownloadingAttribute = @NO;
                         
                         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^() {
                             
                             
                             float ratio = photoItem.widthAttribute.floatValue / photoItem.heightAttribute.floatValue;
                             float height = self.view.frame.size.width / ratio;
                             
                             UIImage *newImage = [Helper imageWithImage:image scaledToSize:CGSizeMake(self.view.frame.size.width, height)];
                             
                             photoItem.imageAttribute = UIImageJPEGRepresentation(newImage, 1.0f);
                             
                             dispatch_async(dispatch_get_main_queue(), ^(){
                                 
                                 PhotoItemCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                                 if (updateCell)
                                 {
                                     cell.picture.image = newImage;
                                     [cell.activityView stopAnimating];
                                 }
                             });
                         });
                     }
                     else
                     {
                         [cell.activityView stopAnimating];
                     }
                 }];
            }
            else
            {
                [cell.activityView startAnimating];
            }
        }
    }
    
    return cell;
}

- (void)downloadImageWithURL:(NSURL *)url
             completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSLog(@"url=%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (!error)
         {
             UIImage *image = [[UIImage alloc] initWithData:data];
             completionBlock(YES,image);
         }
         else
         {
             completionBlock(NO,nil);
         }
     }];
}


@end
