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
#import "PhotoGroup.h"

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

- (void)testForAListOfPhotoGroups
{
    XCTAssertTrue([[photo sortedGroup] isKindOfClass: [NSArray class]], @"Photo should provide an array of photo groups");
}

- (void)testForInitiallyEmptyPHotoGroupList
{
    XCTAssertEqual([[photo sortedGroup] count], (NSUInteger)0, @"No groups added yet, count should be zero");
}

- (void)testAddingAGroupToTheList
{
    PhotoGroup *photoGroup = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoGroup" inManagedObjectContext:coreDataStack.managedObjectContext];
    photo.groups = [NSSet setWithObject:photoGroup];
    XCTAssertEqual([[photo sortedGroup] count], (NSUInteger)1, @"Add a photoGroup, and the count of groups should go up");
}

- (void)testGroupsAreListedSortedByName
{
    PhotoGroup *photoGroup0 = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoGroup" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoGroup0.nameAttribute = @"Boris";
    PhotoGroup *photoGroup1 = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoGroup" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoGroup1.nameAttribute = @"Michael";
    
    photo.groups = [NSSet setWithObjects:photoGroup0,photoGroup1,nil];
    
    NSArray *sortedGroups = [photo sortedGroup];
    PhotoGroup *firstPhotoGroup = [sortedGroups objectAtIndex:0];
    PhotoGroup *secondPhotoGroup = [sortedGroups objectAtIndex:1];
    XCTAssertEqualObjects(photoGroup0, firstPhotoGroup, @"Boris should be first");
    XCTAssertEqualObjects(photoGroup1, secondPhotoGroup, @"Michael should be last");
}

@end
