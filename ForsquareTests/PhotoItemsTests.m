//
//  PhotoItemsTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 27.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "PhotoItem.h"
#import "PhotoGroup.h"

@interface PhotoItemsTests : XCTestCase
{
    CoreDataStack *coreDataStack;
    PhotoGroup *photoGroup;
    PhotoItem  *photoItem;
}
@end

@implementation PhotoItemsTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    
    photoGroup = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoGroup" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    photoItem = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoItem" inManagedObjectContext:coreDataStack.managedObjectContext];
    photoItem.idAttribute = @"511cef52e4b00d6a2c7fddd5";
    photoItem.prefixAttribute = @"https://irs2.4sqi.net/img/general/";
    photoItem.suffixAttribute = @"/690170_HnduV5yM9RLNUHQseOOvDi3OCm4AoYmMld79iVTxrPg.jpg";
    photoItem.widthAttribute = @5;
    photoItem.heightAttribute = @6;
    photoItem.createdAtAttribute = @7;
    photoItem.group = photoGroup;
}

- (void)tearDown
{
    coreDataStack = nil;
    photoGroup = nil;
    photoItem = nil;
    [super tearDown];
}

- (void)testThatPhotoItemGroupExists
{
    XCTAssertNotNil(photoItem, @"Should be able to create PhotoItem instance");
}

- (void)testThatPhotoItemHasId
{
    XCTAssertEqualObjects(photoItem.idAttribute, @"511cef52e4b00d6a2c7fddd5", @"Photo item should has an id attribute");
}

- (void)testThatPhotoItemHasPrefix
{
    XCTAssertEqualObjects(photoItem.prefixAttribute, @"https://irs2.4sqi.net/img/general/", @"Photo item should has a prefix attribute");
}

- (void)testThatPhotoItemHasSuffix
{
    XCTAssertEqualObjects(photoItem.suffixAttribute, @"/690170_HnduV5yM9RLNUHQseOOvDi3OCm4AoYmMld79iVTxrPg.jpg", @"Photo item should has a suffix attribute");
}

- (void)testThatPhotoItemHasCreateAt
{
    XCTAssertEqualObjects(photoItem.createdAtAttribute, @7, @"Photo item should has a createAt attribute");
}

- (void)testThatPhotoItemHasWidth
{
    XCTAssertEqualObjects(photoItem.widthAttribute, @5, @"Photo item should has a width attribute");
}

- (void)testThatPhotoItemHasHeight
{
    XCTAssertEqualObjects(photoItem.heightAttribute, @6, @"Photo item should has a height attribute");
}

- (void)testThatPhotoGroupHasAPhotoGroup
{
    XCTAssertTrue([[[photoItem.group entity] name] isEqualToString: NSStringFromClass([PhotoGroup class])], @"PhotoItem should has photoGroup");
}

@end
