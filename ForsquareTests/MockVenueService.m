//
//  MockVenueService.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockVenueService.h"

@implementation MockVenueService

- (void)searchingForVenuesFailedWithError:(NSError *)error
{
    self.venueSearchFailureErrorCode = [error code];
}

- (void)receivedVenuesJSON:(NSString *)objectNotation
{
    self.venueSearchString = objectNotation;
}

- (void)requestDetailedInfoForVenueFailedWithError:(NSError *)error
{
    self.venueDetailedFailureErrorCode = [error code];
}

- (void)receivedDetailedInfoForVenueJSON:(NSString *)objectNotation
{
    self.venueByIDString = objectNotation;
}

@end
