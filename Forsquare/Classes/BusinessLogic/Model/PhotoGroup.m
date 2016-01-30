//
//  PhotoGroup.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "PhotoGroup.h"
#import "Photo.h"
#import "PhotoItem.h"

@implementation PhotoGroup

- (NSArray *)sortedByCrationAtPhotoItems
{
    return [self.items sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createdAtAttribute" ascending:NO]]];
}

+ (EKManagedObjectMapping *)objectMapping
{
    return [EKManagedObjectMapping mappingForEntityName:NSStringFromClass([PhotoGroup class])
                                              withBlock:^(EKManagedObjectMapping *mapping) {
                                                  [mapping mapPropertiesFromDictionary:@{@"type" : @"typeAttribute",
                                                                                         @"name" : @"nameAttribute"}];
                                                  [mapping hasMany:[PhotoItem class] forKeyPath:@"items"];
                                              }];
}


@end
