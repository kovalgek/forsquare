//
//  VenueTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "Venue.h"
#import "Location.h"
#import "Photo.h"

@interface VenueTests : XCTestCase
{
    CoreDataStack *coreDataStack;
    Venue *venue;
    Location *location;
}
@end

@implementation VenueTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    venue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:coreDataStack.managedObjectContext];
    venue.idAttribute = @"430d0a00f964a5203e271fe3";
    venue.nameAttribute = @"John";
    
    location = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:coreDataStack.managedObjectContext];
    venue.location = location;
    
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:coreDataStack.managedObjectContext];
    venue.photos = photo;
}

- (void)tearDown
{
    coreDataStack = nil;
    venue = nil;
    location = nil;
    [super tearDown];
}

- (void)testThatVenueExists
{
    XCTAssertNotNil(venue, @"Should be able to create Venue instance");
}

- (void)testThatVenueHasId
{
    XCTAssertEqualObjects(venue.idAttribute, @"430d0a00f964a5203e271fe3", @"Venue should has an id attribute");
}

- (void)testThatVEnueHasName
{
    XCTAssertEqualObjects(venue.nameAttribute, @"John", @"Venue should has a name attribute");
}

- (void)testThatVenueHasLocation
{
    XCTAssertTrue([[[venue.location entity] name] isEqualToString: NSStringFromClass([Location class])], @"Venue should has location");
}

- (void)testThatVenueHasPhotoSet
{
    XCTAssertTrue([[[venue.photos entity] name] isEqualToString: NSStringFromClass([Photo class])], @"Venue should has photos");
}

@end
