//
//  VenueTransport.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractTransport.h"

@interface VenueTransport : AbstractTransport

- (void)requestVenues;

- (void)requestDetailedInfoForVenueID:(NSString *)venueID;

@end
