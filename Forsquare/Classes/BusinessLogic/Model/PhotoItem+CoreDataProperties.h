//
//  PhotoItem+CoreDataProperties.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoItem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idAttribute;
@property (nullable, nonatomic, retain) NSNumber *createdAtAttribute;
@property (nullable, nonatomic, retain) NSString *prefixAttribute;
@property (nullable, nonatomic, retain) NSString *suffixAttribute;
@property (nullable, nonatomic, retain) NSNumber *widthAttribute;
@property (nullable, nonatomic, retain) NSNumber *heightAttribute;
@property (nullable, nonatomic, retain) NSManagedObject *group;

@end

@interface PhotoItem (CoreDataGeneratedAccessors)

@end

NS_ASSUME_NONNULL_END
