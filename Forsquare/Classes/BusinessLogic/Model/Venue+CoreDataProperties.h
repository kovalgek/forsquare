//
//  Venue+CoreDataProperties.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Venue.h"
#import "Photo.h"
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Venue (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *idAttribute;
@property (nullable, nonatomic, retain) NSString *nameAttribute;
@property (nullable, nonatomic, retain) Location *location;
@property (nullable, nonatomic, retain) Photo *photos;

@end


NS_ASSUME_NONNULL_END
