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

@end
