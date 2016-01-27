//
//  PhotoTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "Photo.h"
#import "Venue.h"

@interface PhotoTests : XCTestCase
{
    Photo *photo;
    Venue *venue;
    CoreDataStack *coreDataStack;
}
@end

@implementation PhotoTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:coreDataStack.managedObjectContext];
    photo.countAttribute = @123;
    
    venue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:coreDataStack.managedObjectContext];
    photo.venue = venue;
}

- (void)tearDown
{
    coreDataStack = nil;
    photo = nil;
    [super tearDown];
}

- (void)testThatPhotoExists
{
    XCTAssertNotNil(photo, @"Should be able to create Photo instance");
}

- (void)testThatPhotoHasCount
{
    XCTAssertEqualObjects(photo.countAttribute, @123, @"Photo should has a count");
}

- (void)testThatPhotoHasVenue
{
    XCTAssertTrue([[[photo.venue entity] name] isEqualToString: NSStringFromClass([Venue class])], @"Photo should has venue");
}

- (void)testThatPhotoHasGroupSet
{
    XCTAssertTrue([photo.groups isKindOfClass:[NSSet class]], @"Photo should has photoGroup set");
}

@end
