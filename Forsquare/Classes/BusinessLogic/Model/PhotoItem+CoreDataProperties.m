//
//  PhotoItem+CoreDataProperties.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PhotoItem+CoreDataProperties.h"

@implementation PhotoItem (CoreDataProperties)

@dynamic idAttribute;
@dynamic createdAtAttribute;
@dynamic prefixAttribute;
@dynamic suffixAttribute;
@dynamic widthAttribute;
@dynamic heightAttribute;
@dynamic group;
@dynamic imageAttribute;
@dynamic imageIsDownloadingAttribute;

@end
