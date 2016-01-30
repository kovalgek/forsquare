//
//  PhotoItem.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([PhotoItem class])
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping mapPropertiesFromDictionary:@{@"id"        : @"idAttribute",
                                                                                         @"createdAt" : @"createdAtAttribute",
                                                                                         @"prefix"    : @"prefixAttribute",
                                                                                         @"suffix"    : @"suffixAttribute",
                                                                                         @"width"     : @"widthAttribute",
                                                                                         @"height"    : @"heightAttribute",}];
                                              }];
}


@end
