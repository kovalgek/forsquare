//
//  VenueParserTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VenueParser.h"
#import "Venue.h"
#import "Location.h"

static NSString *stringIsNotJSON = @"Not JSON";
static NSString *noItemsJSONString = @"{\"response\" :  { \"noitems\": true }}";
static NSString *emptyItemsArray = @"{ \"items\": [] }";

@interface VenueParserTests : XCTestCase
{
    VenueParser *venueParser;
    NSString *venueJSON;
    NSString *detailedVenueJSON;
    Venue *venue;
}
@end

@implementation VenueParserTests

- (void)setUp
{
    [super setUp];
    
    venueParser = [[VenueParser alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"venuesJSON" ofType:@"json"];
    venueJSON = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    venue = [[venueParser venuesFromJSON:venueJSON error:NULL] objectAtIndex:0];
    
    NSString *detailedVenueFilePath = [[NSBundle mainBundle] pathForResource:@"venueJSON" ofType:@"json"];
    detailedVenueJSON = [NSString stringWithContentsOfFile:detailedVenueFilePath encoding:NSUTF8StringEncoding error:nil];
}

- (void)tearDown
{
    venueJSON = nil;
    venue = nil;
    venueParser = nil;
    detailedVenueJSON = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([venueParser venuesFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([venueParser venuesFromJSON:@"Not JSON" error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorSetWhenStringIsNotJSON
{
    NSError *error = nil;
    [venueParser venuesFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"An error occurred, we should be told");
}

- (void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([venueParser venuesFromJSON:@"Not JSON" error:NULL], @"Using a NULL error parameter should not be a problem");
}

- (void) testRealJSONWithoutItemsArrayIsError
{
    NSString *jsonString = @"{\"novenues\" : true}";
    NSError *error = nil;
    [venueParser venuesFromJSON:jsonString error:&error];
    XCTAssertEqual([error code], VenueParserMissingDataError, @"This case shouldn't be an invalid JSON error");
}

- (void) testJSONWithOneVenueReturnsOneVenueObject
{
    NSError *error = nil;
    NSArray *venues = [venueParser venuesFromJSON:venueJSON error:&error];
    XCTAssertEqual([venues count], (NSUInteger)1, @"The parser should have created a venue");
}

- (void) testVenueCreatedFromJSONHasPropertiesPresentedInJSON
{
    XCTAssertEqualObjects(venue.idAttribute, @"430d0a00f964a5203e271fe3", @"The venue ID should match the data we sent");
    XCTAssertEqualObjects(venue.nameAttribute, @"Brooklyn Bridge Park", @"Name should match the provided data");
    
    Location *location = venue.location;
    XCTAssertEqualObjects(location.addressAttribute, @"Main St", @"Location should match address");
    XCTAssertEqualObjects(location.latAttribute, [NSNumber numberWithFloat:40.70227697066692f], @"Location should match latitude");
    XCTAssertEqualObjects(location.lngAttribute, [NSNumber numberWithFloat:-73.9965033531189f], @"Location should match longitude");
}

- (void)testBuildingVenueDetailedInfoWithNoDataCannotBeTried
{
    XCTAssertThrows([venueParser fillInDetailedInfoForVenue:venue fromJSON:nil], @"Not receiving data should have been handled earlier");
}

- (void)testBuildingVenueDetailedInfoWithNoVenueCannotBeTried
{
    XCTAssertThrows([venueParser fillInDetailedInfoForVenue:nil fromJSON:detailedVenueJSON], @"No reason to expect that a nil venue is passed");
}

- (void)testNonJSONDataDoesNotCauseABodyToBeAddedToAQuestion
{
    [venueParser fillInDetailedInfoForVenue:venue fromJSON:stringIsNotJSON];
    XCTAssertNil(venue.photos, @"Photo should not have been added");
}

- (void)testJSONWhichDoesNotContainABodyDoesNotCauseBodyToBeAdded
{
    [venueParser fillInDetailedInfoForVenue:venue fromJSON:noItemsJSONString];
    XCTAssertNil(venue.photos, @"Photo should not have been added");
}

- (void)testBodyContainedInJSONIsAddedToQuestion
{
    [venueParser fillInDetailedInfoForVenue:venue fromJSON:detailedVenueJSON];
    XCTAssertEqualObjects(venue.photos.countAttribute, @1555, @"The correct question body is added");
}
/*
- (void)testEmptyQuestionsArrayDoesNotCrash
{
    XCTAssertNoThrow([questionBuilder fillInDetailsForQuestion: question fromJSON: emptyQuestionsArray], @"Don't throw if no questions are found");
}
*/

@end
