//
//  PhotoGroup.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <EasyMapping/EasyMapping.h>

@class Photo, PhotoItem;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoGroup : NSManagedObject <EKMappingProtocol>

- (NSArray *)sortedByCrationAtPhotoItems;
+ (EKManagedObjectMapping *)objectMapping;

@end

NS_ASSUME_NONNULL_END

#import "PhotoGroup+CoreDataProperties.h"
