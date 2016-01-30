//
//  VenueService.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractEntityService.h"
#import "VenueServiceDelegate.h"

enum
{
    VenueServiceErrorSearchCode,
    VenueServiceErrorVenueDetailedInfoFetchCode
};

@class Venue;

@interface VenueService : AbstractEntityService
@property (nonatomic, weak) id<VenueServiceDelegate> delegate;

- (void)requestVenues;
- (void)searchingForVenuesFailedWithError:(NSError *)error;
- (void)receivedVenuesJSON:(NSString *)objectNotation;

- (void)requestDetailedInfoForVenue:(Venue *)venue;
- (void)requestDetailedInfoForVenueFailedWithError:(NSError *)error;
- (void)receivedDetailedInfoForVenueJSON:(NSString *)objectNotation;
@end
