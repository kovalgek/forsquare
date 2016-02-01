//
//  VenueCache.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractCache.h"
#import "Venue.h"

@interface VenueCache : AbstractCache
- (NSArray *)venues;
- (Venue *)venueByID:(NSString *)venueID;
@end
