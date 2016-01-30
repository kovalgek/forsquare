//
//  Photo.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "Photo.h"
#import "Venue.h"
#import "PhotoGroup.h"

@implementation Photo

- (NSArray *)sortedGroup
{
    return [self.groups sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"nameAttribute" ascending:YES]]];
}

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([Photo class])
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping mapPropertiesFromDictionary:@{@"count" : @"countAttribute"}];
                                                  [mapping hasMany:[PhotoGroup class] forKeyPath:@"groups"];
                                              }];
}

@end
