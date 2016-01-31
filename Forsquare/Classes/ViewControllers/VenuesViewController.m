//
//  VenuesViewController.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenuesViewController.h"
#import "ServiceRegistry.h"

@interface VenuesViewController() <VenueServiceDelegate>

@end

@implementation VenuesViewController

- (void) loadView
{
    [super loadView];
    
    SREG.serviceLayer.venueService.delegate = self;
    [SREG.serviceLayer.venueService requestVenues];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)didReceiveVenues:(NSArray *)venues
{
    
}

- (void)requestingVenuesFailedWithError:(NSError *)error
{
    
}

-(void)requestingVenueDetailedInfoFailedWithError:(NSError *)error
{
    
}

@end
