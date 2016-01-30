//
//  MockVenueParser.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MockVenueParser.h"

@implementation MockVenueParser

- (NSArray *)venuesFromJSON:(NSString *)objectNotation
                      error:(NSError *__autoreleasing *)error
{
    self.JSON = objectNotation;
    if (error)
    {
        *error = _errorToSet;
    }
    return _arrayToReturn;
}

- (void)fillInDetailedInfoForVenue:(Venue *)venue
                          fromJSON:(NSString *)objectNotation
{
    self.venueToFill = venue;
    self.JSON = objectNotation;
}

@end
