//
//  Venue+CoreDataProperties.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Venue+CoreDataProperties.h"
#import "Location.h"

@implementation Venue (CoreDataProperties)

@dynamic idAttribute;
@dynamic nameAttribute;
@dynamic location;
@dynamic photos;

@end
