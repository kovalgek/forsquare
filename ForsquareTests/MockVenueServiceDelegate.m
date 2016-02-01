//
//  MockVenueServiceDelegate.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockVenueServiceDelegate.h"

@implementation MockVenueServiceDelegate

- (void)requestingVenuesFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveVenues:(NSArray *)venues
{
    self.receivedVenues = venues;
}

- (void)requestingVenueDetailedInfoFailedWithError:(NSError *)error
{
    self.fetchError = error;
}

- (void)didReceiveVenue:(Venue *)venue
{
    
}

@end
