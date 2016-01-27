//
//  Photo+CoreDataProperties.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *countAttribute;
@property (nullable, nonatomic, retain) Venue *venue;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *groups;

@end

@interface Photo (CoreDataGeneratedAccessors)

- (void)addGroupsObject:(NSManagedObject *)value;
- (void)removeGroupsObject:(NSManagedObject *)value;
- (void)addGroups:(NSSet<NSManagedObject *> *)values;
- (void)removeGroups:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
