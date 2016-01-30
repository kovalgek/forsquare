//
//  MockVenueParser.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueParser.h"

@class Venue;

@interface MockVenueParser : VenueParser
@property (copy, nonatomic) NSString *JSON;
@property (copy, nonatomic) NSArray *arrayToReturn;
@property (copy, nonatomic) NSError *errorToSet;
@property (strong, nonatomic) Venue *venueToFill;
@end
