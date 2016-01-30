//
//  VenueCreationWorkflowTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 28.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServiceLayer.h"
#import "MockVenueServiceDelegate.h"
#import "MockVenueTransport.h"
#import "MockVenueParser.h"
#import "CoreDataStack.h"
#import "VenueService.h"
#import "Venue.h"

@interface VenueCreationWorkflowTests : XCTestCase
{
    VenueService *venueService;
    CoreDataStack *coreDataStack;
    MockVenueServiceDelegate *delegate;
    MockVenueTransport *venueTrasport;
    MockVenueParser *venueParser;
    NSError *underlyingError;
    NSArray *venuesArray;
    Venue *venue;
}
@end

@implementation VenueCreationWorkflowTests

- (void)setUp
{
    [super setUp];
    coreDataStack = [[CoreDataStack alloc] init];
    venueService = [[VenueService alloc] init];
    
    delegate = [[MockVenueServiceDelegate alloc] init];
    venueService.delegate = delegate;
    
    venueTrasport = [[MockVenueTransport alloc] init];
    venueService.abstractTransport = venueTrasport;
    
    venueParser = [[MockVenueParser alloc] init];
    venueService.abstractParser = venueParser;
    
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    
    venue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:coreDataStack.managedObjectContext];
    venuesArray = @[venue];
}

- (void)tearDown
{
    venueTrasport = nil;
    venueService = nil;
    venueParser = nil;
    coreDataStack = nil;
    delegate = nil;
    underlyingError = nil;
    venuesArray = nil;
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate
{
    XCTAssertThrows(venueService.delegate = (id <VenueServiceDelegate>)[NSNull null], @"NSNull doesn't conform to the delegate protocol");
}

- (void)testEntityServiceAcceptsNilAsADelegate
{
    XCTAssertNoThrow(venueService.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

- (void)testConformingObjectCanBeDelegate
{
    XCTAssertNoThrow(venueService.delegate = delegate, @"Object conforming to the delegate protocol can be delegate");
}

- (void)testAskingForVenuesMeansRequestingData
{
    [venueService requestVenues];
    XCTAssertTrue(venueTrasport.wasAskedToRequestVenues, @"The transport should need to fetch data.");
}

- (void) testErrorReturnedToDelegateIsNotErrorNotifiedByTransport
{
    [venueService searchingForVenuesFailedWithError: underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

- (void) testErrorReturnedToDelegateDocumentsUnderlyingError
{
    [venueService searchingForVenuesFailedWithError: underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

- (void)testVenuesJSONIsPassedToParser
{
    [venueService receivedVenuesJSON: @"Fake JSON"];
    XCTAssertEqualObjects(venueParser.JSON, @"Fake JSON", @"Downloaded JSON is sent to the parser");
}

- (void)testDelegateNotifiedOfErrorWhenParserFails
{
    venueParser.arrayToReturn = nil;
    venueParser.errorToSet = underlyingError;
    [venueService receivedVenuesJSON: @"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"The delegate should have found out about the error");
}

- (void)testDelegateNotToldAboutErrorWhenVenuesReceived
{
    venueParser.arrayToReturn = venuesArray;
    [venueService receivedVenuesJSON: @"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be received on success");
}

- (void)testDelegateReceivesTheVenuesDiscoveredByVenueService
{
    venueParser.arrayToReturn = venuesArray;
    [venueService receivedVenuesJSON: @"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedVenues], venuesArray, @"The venueService should have sent its venues to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate
{
    venueParser.arrayToReturn = @[];
    [venueService receivedVenuesJSON: @"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedVenues], @[], @"Returning an empty array is not an error");
}

// detailed info for Venue (Photos)
- (void)testAskingForVenueDetailedInfoMeansRequestingData
{
    [venueService requestDetailedInfoForVenue: venue];
    XCTAssertTrue(venueTrasport.wasAskedToRequestVenuesDetailedInfo, @"The venueService should need to retrieve data for the venue detailed info");
}

- (void)testDelegateNotifiedOfFailureToFetchVenue
{
    [venueService requestDetailedInfoForVenueFailedWithError: underlyingError];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey: NSUnderlyingErrorKey], @"Delegate should have found out about this error");
}

- (void)testVenueServicePassesRetrievedVenueDetailedInfoToVenueParser
{
    [venueService receivedDetailedInfoForVenueJSON: @"Fake JSON"];
    XCTAssertEqualObjects(venueParser.JSON, @"Fake JSON", @"Successfully-retrieved data should be passed to the parser");
}

- (void)testVenueServicePassesVenueItWasSentToVenuePArserForFillingIn
{
    [venueService requestDetailedInfoForVenue: venue];
    [venueService receivedDetailedInfoForVenueJSON: @"Fake JSON"];
    XCTAssertEqualObjects(venueParser.venueToFill, venue, @"The venue should have been passed to the parser");
}

@end
