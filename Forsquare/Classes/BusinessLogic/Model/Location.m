//
//  Location.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "Location.h"
#import "Venue.h"

@implementation Location

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([Location class])
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping mapPropertiesFromDictionary:@{@"address" : @"addressAttribute",
                                                                                         @"lat"     : @"latAttribute",
                                                                                         @"lng"     : @"lngAttribute"}];
                                              }];
}

@end
