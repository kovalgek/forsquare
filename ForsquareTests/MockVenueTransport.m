//
//  MockVenueTransport.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockVenueTransport.h"

@implementation MockVenueTransport

- (void)requestVenues
{
    self.wasAskedToRequestVenues = YES;
}

- (void)requestDetailedInfoForVenueID:(NSString *)venueID
{
    self.wasAskedToRequestVenuesDetailedInfo = YES;
}

@end
