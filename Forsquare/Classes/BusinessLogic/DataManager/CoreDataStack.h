//
//  DataManager.h
//  EventGridManager
//
//  Created by Антон Ковальчук on 03.12.13.
//  Copyright (c) 2013 Антон Ковальчук. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (void)save;
@end
