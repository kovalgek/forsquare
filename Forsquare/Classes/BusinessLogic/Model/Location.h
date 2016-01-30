//
//  Location.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <EasyMapping/EasyMapping.h>

@class Venue;

NS_ASSUME_NONNULL_BEGIN

@interface Location : NSManagedObject <EKMappingProtocol>

+ (EKManagedObjectMapping *)objectMapping;

@end

NS_ASSUME_NONNULL_END

#import "Location+CoreDataProperties.h"
