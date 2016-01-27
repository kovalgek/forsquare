//
//  ServiceRegistry.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#define SREG ((ServiceRegistry*)[ServiceRegistry instance])

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "ServiceLayer.h"

@interface ServiceRegistry : NSObject
@property (nonatomic, strong)  CoreDataStack *coreDataStack;
@property (nonatomic, strong)  ServiceLayer *serviceLayer;
+ (ServiceRegistry *)instance;
@end
