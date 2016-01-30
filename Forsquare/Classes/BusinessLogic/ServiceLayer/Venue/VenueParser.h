//
//  VenueParser.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractParser.h"

enum
{
    VenueParserInvalidJSONError,
    VenueParserMissingDataError
};

@class Venue;

@interface VenueParser : AbstractParser

- (NSArray *)venuesFromJSON: (NSString *)objectNotation
                      error: (NSError **)error;

- (void)fillInDetailedInfoForVenue:(Venue *)venue
                          fromJSON:(NSString *)objectNotation;

@end
