//
//  VenuesViewController.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenuesViewController.h"
#import "PhotosViewController.h"
#import "VenueCell.h"
#import "ServiceRegistry.h"
#import "VenueCache.h"
#import "UIColor+Extensions.h"
#import "MBProgressHUD.h"
#import "GeoService.h"

@interface VenuesViewController() <VenueServiceDelegate, GeoServiceProtocol>
@property (nonatomic, strong) NSArray *venues;
@property (strong, nonatomic) MBProgressHUD *loader;
@end

@implementation VenuesViewController

- (void) loadView
{
    [super loadView];
    
    self.title = @"FORSQUARE API";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.loader = [[MBProgressHUD alloc] initWithView:self.view];
    self.loader.animationType = MBProgressHUDAnimationZoomIn;
    [self.view addSubview:self.loader];
    
    self.venues = [((VenueCache *)SREG.serviceLayer.venueService.abstractCache) venues];
    [self.tableView reloadData];
    
    SREG.serviceLayer.venueService.delegate = self;
    SREG.serviceLayer.geoService.delegate = self;
    [SREG.serviceLayer.geoService requestWhenInUseAuthorization];
}

- (void)didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        self.loader.labelText = @"Update Location...";
        [self.loader show:YES];
        [SREG.serviceLayer.geoService startUpdatingLocation];
    }
}

- (void)didUpdateLocation:(CLLocation *)location
{
    self.loader.labelText = @"Requesting venues...";
    [SREG.serviceLayer.venueService requestVenues];
}

- (void)didFailLocation
{
    self.loader.labelText = @"Requesting venues...";
    [SREG.serviceLayer.venueService requestVenues];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[VenueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Venue *venue = [self.venues objectAtIndex:indexPath.row];
    [cell fillWithEntity:venue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (void)didReceiveVenues:(NSArray *)venues
{
    [self.loader hide:YES];
    self.venues = [((VenueCache *)SREG.serviceLayer.venueService.abstractCache) venues];
    [self.tableView reloadData];
}

- (void)requestingVenuesFailedWithError:(NSError *)error
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPhotos"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Venue *venue = self.venues[indexPath.row];
        PhotosViewController *controller = (PhotosViewController *)[segue destinationViewController];
        controller.venueID = venue.idAttribute;
    }
    else if ([[segue identifier] isEqualToString:@"showMap"])
    {
        
    }
}


@end
