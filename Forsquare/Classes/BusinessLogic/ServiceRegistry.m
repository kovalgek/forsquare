//
//  ServiceRegistry.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "ServiceRegistry.h"
#import "CoreDataStack.h"
#import "ServiceLayer.h"

@implementation ServiceRegistry

+ (ServiceRegistry *) instance
{
    static ServiceRegistry *serviceRegistry = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        serviceRegistry = [[self alloc] init];
    });
    return serviceRegistry;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.coreDataStack = [[CoreDataStack alloc] init];
        self.serviceLayer = [[ServiceLayer alloc] init];
    }
    return self;
}

@end
