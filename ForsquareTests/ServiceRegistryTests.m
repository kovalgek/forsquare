//
//  ServiceRegistryTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServiceRegistry.h"
#import "CoreDataStack.h"
#import "ServiceLayer.h"

@interface ServiceRegistryTests : XCTestCase

@end

@implementation ServiceRegistryTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    
    [super tearDown];
}

- (void)testSingletonSharedInstanceCreated
{
    XCTAssertNotNil([[ServiceRegistry alloc] init]);
}

- (void)testSingletonUniqueInstanceCreated
{
    XCTAssertNotNil(SREG);
}

- (void)testSingletonReturnsSameSharedInstanceTwice
{
    ServiceRegistry *serviceRegistry = SREG;
    XCTAssertEqual(serviceRegistry, SREG);
}

- (void)testSingletonSharedInstanceSeparateFromUniqueInstance
{
    ServiceRegistry *serviceRegistry = SREG;
    XCTAssertNotEqual(serviceRegistry, [[ServiceRegistry alloc] init]);
}

- (void)testSingletonReturnsSeparateUniqueInstances
{
    ServiceRegistry *serviceRegistry = [[ServiceRegistry alloc] init];
    XCTAssertNotEqual(serviceRegistry, [[ServiceRegistry alloc] init]);
}

- (void)testRegistryHasACoreStack
{
    XCTAssertTrue([SREG.coreDataStack isKindOfClass:[CoreDataStack class]], @"ServiceRegistry should has coreDataStack");
}

- (void)testRegistryHasAServiceLayer
{
    XCTAssertTrue([SREG.serviceLayer isKindOfClass:[ServiceLayer class]], @"ServiceRegistry should has serviceLayer");
}

@end
