//
//  Venue.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "Venue.h"

@implementation Venue

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([Venue class])
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  mapping.primaryKey = @"idAttribute";
                                                  [mapping mapPropertiesFromDictionary:@{@"id" : @"idAttribute",
                                                                                         @"name" : @"nameAttribute"}];
                                                  [mapping hasOne:[Location class] forKeyPath:@"location"];
                                                  [mapping hasOne:[Photo class] forKeyPath:@"photos"];
                                              }];
}

@end
