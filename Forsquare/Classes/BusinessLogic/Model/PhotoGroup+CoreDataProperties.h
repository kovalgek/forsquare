//
//  PhotoGroup+CoreDataProperties.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoGroup (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *typeAttribute;
@property (nullable, nonatomic, retain) NSString *nameAttribute;
@property (nullable, nonatomic, retain) Photo *photo;
@property (nullable, nonatomic, retain) NSSet<PhotoItem *> *items;

@end

@interface PhotoGroup (CoreDataGeneratedAccessors)

- (void)addItemsObject:(PhotoItem *)value;
- (void)removeItemsObject:(PhotoItem *)value;
- (void)addItems:(NSSet<PhotoItem *> *)values;
- (void)removeItems:(NSSet<PhotoItem *> *)values;

@end

NS_ASSUME_NONNULL_END
