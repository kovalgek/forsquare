//
//  PhotoGroupTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "PhotoGroup.h"
#import "Photo.h"
#import "PhotoItem.h"

@interface PhotoGroupTests : XCTestCase
{
    CoreDataStack *coreDataStack;
    PhotoGroup *photoGroup;
    Photo *photo;
}
@end

@implementation PhotoGroupTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    photoGroup = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoGroup" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoGroup.typeAttribute = @"venue";
    photoGroup.nameAttribute = @"my photo";
    
    photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoGroup.photo = photo;
}

- (void)tearDown
{
    coreDataStack = nil;
    photoGroup = nil;
    photo = nil;
    [super tearDown];
}

- (void)testThatPhotoGroupExists
{
    XCTAssertNotNil(photoGroup, @"Should be able to create PhotoGroup instance");
}

- (void)testThatPhotoGroupHasType
{
    XCTAssertEqualObjects(photoGroup.typeAttribute, @"venue", @"Photo group should has a type attribute");
}

- (void)testThatPhotoGroupHasName
{
    XCTAssertEqualObjects(photoGroup.nameAttribute, @"my photo", @"Photo group should has a name attribute");
}

- (void)testThatPhotoGroupHasAPhoto
{
    XCTAssertTrue([[[photoGroup.photo entity] name] isEqualToString: NSStringFromClass([Photo class])], @"PhotoGroup should has photo");
}

- (void)testThatPhotoGroupHasPhotoItemsSet
{
    XCTAssertTrue([photoGroup.items isKindOfClass:[NSSet class]], @"PhotGroup should has photo items set");
}

- (void)testForAListOfPhotoItems
{
    XCTAssertTrue([[photoGroup sortedByCrationAtPhotoItems] isKindOfClass: [NSArray class]], @"PhotoGroup should provide an array of photo items");
}

- (void)testForInitiallyEmptyPhotoItemList
{
    XCTAssertEqual([[photoGroup sortedByCrationAtPhotoItems] count], (NSUInteger)0, @"No photo item added yet, count should be zero");
}

- (void)testAddingAPhotoItemToTheList
{
    PhotoItem *photoItem = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoItem" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoGroup.items = [NSSet setWithObject:photoItem];
    XCTAssertEqual([[photoGroup sortedByCrationAtPhotoItems] count], (NSUInteger)1, @"Add a photoItem, and the count of items should go up");
}

- (void)testGroupsAreListedSortedByName
{
    PhotoItem *photoItem0 = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoItem" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoItem0.createdAtAttribute = @0;
    
    PhotoItem *photoItem1 = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoItem" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoItem1.createdAtAttribute = @1024;
    
    photoGroup.items = [NSSet setWithObjects:photoItem0, photoItem1, nil];
    
    NSArray *sortedItems = [photoGroup sortedByCrationAtPhotoItems];
    PhotoItem *firstPhotoItem = [sortedItems objectAtIndex:0];
    PhotoItem *secondPhotoItem = [sortedItems objectAtIndex:1];
    XCTAssertEqualObjects(firstPhotoItem, photoItem1, @"Created at 1024 should be first");
    XCTAssertEqualObjects(secondPhotoItem, photoItem0, @"Created at 0 should be last");
}


@end
