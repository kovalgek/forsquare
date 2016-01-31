//
//  VenueService.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractEntityService.h"
#import "VenueServiceDelegate.h"
#import "VenueTransportDelegate.h"

enum
{
    VenueServiceErrorSearchCode,
    VenueServiceErrorVenueDetailedInfoFetchCode
};

@class Venue;

@interface VenueService : AbstractEntityService <VenueTransportDelegate>

@property (nonatomic, weak) id<VenueServiceDelegate> delegate;

- (void)requestVenues;
- (void)requestDetailedInfoForVenue:(Venue *)venue;

@end
