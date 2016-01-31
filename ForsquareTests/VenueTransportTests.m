//
//  VenueTransportTests.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 30.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "VenueTransport.h"
#import "InspectableVenueTransport.h"
#import "NonNetworkedVenueTransport.h"
#import "MockVenueService.h"
#import "FakeURLResponse.h"
#import "Constants.h"

@interface VenueTransportTests : XCTestCase
{
    InspectableVenueTransport *inspectableVenueTransport;
    NonNetworkedVenueTransport *nonNetworkedVenueTransport;
    MockVenueService *mockVenueService;
    FakeURLResponse *fourOhFourResponse;
    NSData *receivedData;
}
@end

@implementation VenueTransportTests

- (void)setUp
{
    [super setUp];
    inspectableVenueTransport = [[InspectableVenueTransport alloc] init];
    nonNetworkedVenueTransport = [[NonNetworkedVenueTransport alloc] init];
    mockVenueService = [[MockVenueService alloc] init];
    nonNetworkedVenueTransport.delegate = mockVenueService;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode: 404];
    receivedData = [@"Result" dataUsingEncoding: NSUTF8StringEncoding];
}

- (void)tearDown
{
    inspectableVenueTransport = nil;
    nonNetworkedVenueTransport = nil;
    mockVenueService = nil;
    fourOhFourResponse = nil;
    receivedData = nil;
    [super tearDown];
}

- (void)testSearchingForVenuesCallsVenuesAPI
{
    [inspectableVenueTransport requestVenues];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_URL, [NSString stringWithFormat:VENUES_SEARCH, CLIENT_ID, CLIENT_SECRET]];
    XCTAssertEqualObjects([[inspectableVenueTransport URLToFetch] absoluteString],urlStr, @"Use the search API to find venues");
}

- (void)testFillingInQuestionBodyCallsQuestionAPI
{
    [inspectableVenueTransport requestDetailedInfoForVenueID:@"123"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",API_URL, [NSString stringWithFormat:VENUE_BY_ID, @"123", CLIENT_ID, CLIENT_SECRET]];
    XCTAssertEqualObjects([[inspectableVenueTransport URLToFetch] absoluteString],urlStr, @"Use the venue/id API to fetch detailed venue");
}

- (void)testSearchingForQuestionsCreatesURLConnection
{
    [inspectableVenueTransport requestVenues];
    XCTAssertNotNil([inspectableVenueTransport currentURLConnection], @"There should be a URL connection in-flight now.");
}

- (void)testStartingNewSearchThrowsOutOldConnection
{
    [inspectableVenueTransport requestVenues];
    NSURLConnection *firstConnection = [inspectableVenueTransport currentURLConnection];
    [inspectableVenueTransport requestVenues];
    XCTAssertFalse([[inspectableVenueTransport currentURLConnection] isEqual: firstConnection], @"The venueTransport needs to replace its URL connection to start a new one");
}

- (void)testReceivingResponseDiscardsExistingData
{
    nonNetworkedVenueTransport.receivedData = [@"Hello" dataUsingEncoding: NSUTF8StringEncoding];
    [nonNetworkedVenueTransport requestVenues];
    [nonNetworkedVenueTransport connection: nil didReceiveResponse: nil];
    XCTAssertEqual([nonNetworkedVenueTransport.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceivingResponseWith404StatusPassesErrorToDelegate
{
    [nonNetworkedVenueTransport requestVenues];
    [nonNetworkedVenueTransport connection: nil didReceiveResponse: (NSURLResponse *)fourOhFourResponse];
    XCTAssertEqual(mockVenueService.venueSearchFailureErrorCode, 404, @"Fetch failure was passed through to delegate");
}

- (void)testNoErrorReceivedOn200Status
{
    FakeURLResponse *twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode: 200];
    [nonNetworkedVenueTransport requestVenues];
    [nonNetworkedVenueTransport connection: nil didReceiveResponse: (NSURLResponse *)twoHundredResponse];
    XCTAssertFalse(mockVenueService.venueSearchFailureErrorCode == 200, @"No need for error on 200 response");
}

- (void)testConnectionFailingPassesErrorToDelegate
{
    [nonNetworkedVenueTransport requestVenues];
    NSError *error = [NSError errorWithDomain: @"Fake domain" code: 12345 userInfo: nil];
    [nonNetworkedVenueTransport connection: nil didFailWithError: error];
    XCTAssertEqual(mockVenueService.venueSearchFailureErrorCode, 12345, @"Failure to connect should get passed to the delegate");
}

- (void)testSuccessfulQuestionSearchPassesDataToDelegate
{
    [nonNetworkedVenueTransport requestVenues];
    [nonNetworkedVenueTransport setReceivedData: receivedData];
    [nonNetworkedVenueTransport connectionDidFinishLoading: nil];
    XCTAssertEqualObjects(mockVenueService.venueSearchString, @"Result", @"The delegate should have received data on success");
}

- (void)testAdditionalDataAppendedToDownload
{
    [nonNetworkedVenueTransport setReceivedData: receivedData];
    NSData *extraData = [@" appended" dataUsingEncoding: NSUTF8StringEncoding];
    [nonNetworkedVenueTransport connection: nil didReceiveData: extraData];
    NSString *combinedString = [[NSString alloc] initWithData: [nonNetworkedVenueTransport receivedData] encoding: NSUTF8StringEncoding];
    XCTAssertEqualObjects(combinedString, @"Result appended", @"Received data should be appended to the downloaded data");
}


@end
