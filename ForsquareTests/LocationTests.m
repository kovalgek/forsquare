//
//  LocationTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Location.h"
#import "Venue.h"
#import "CoreDataStack.h"

@interface LocationTests : XCTestCase
{
    CoreDataStack *coreDataStack;
    Location *location;
    Venue *venue;
}
@end

@implementation LocationTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:coreDataStack.managedObjectContext];
    location.addressAttribute = @"London";
    location.latAttribute = [NSNumber numberWithFloat:0.0f];
    location.lngAttribute = [NSNumber numberWithFloat:100.0f];
    
    venue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:coreDataStack.managedObjectContext];
    location.venue = venue;
}

- (void)tearDown
{
    coreDataStack = nil;
    location = nil;
    [super tearDown];
}

- (void)testThatLocationExists
{
    XCTAssertNotNil(location, @"Should be able to create Location instance");
}

- (void)testThatLocationHasAddress
{
    XCTAssertEqualObjects(location.addressAttribute, @"London", @"Venue should has an id attribute");
}

- (void)testThatLocationHasLat
{
    XCTAssertEqualObjects(location.latAttribute, [NSNumber numberWithFloat:0.0f], @"Venue should has a lat");
}

- (void)testThatLocationHasLng
{
    XCTAssertEqualObjects(location.lngAttribute, [NSNumber numberWithFloat:100.0f], @"Venue should has a lng");
}

- (void)testThatLocationHasAVenue
{
    XCTAssertTrue([[[location.venue entity] name] isEqualToString: NSStringFromClass([Venue class])], @"Location should have venue");
}

@end
