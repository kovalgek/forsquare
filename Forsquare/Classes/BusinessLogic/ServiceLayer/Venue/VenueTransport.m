//
//  VenueTransport.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueTransport.h"
#import "Constants.h"

NSString *VenueTransportErrorDomain = @"VenueTransportErrorDomain";

@implementation VenueTransport

- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void (^)(NSError *))errorBlock
           successHandler:(void (^)(NSString *))successBlock
{
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL: fetchingURL];
    
    
    [self launchConnectionForRequest: request];
}

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest: request delegate: self];
}

- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

- (void)requestVenues
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL, [NSString stringWithFormat:VENUES_SEARCH, CLIENT_ID,CLIENT_SECRET]]]
               errorHandler: ^(NSError *error) {
                   [_delegate searchingForVenuesFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [_delegate receivedVenuesJSON: objectNotation];
             }];
}

- (void)requestDetailedInfoForVenueID:(NSString *)venueID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_URL, [NSString stringWithFormat:VENUE_BY_ID,venueID, CLIENT_ID,CLIENT_SECRET]]]
               errorHandler: ^(NSError *error) {
                   [_delegate requestDetailedInfoForVenueFailedWithError: error];
               }
             successHandler: ^(NSString *objectNotation) {
                 [_delegate receivedDetailedInfoForVenueJSON: objectNotation];
             }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200)
    {
        NSError *error = [NSError errorWithDomain: VenueTransportErrorDomain
                                             code: [httpResponse statusCode]
                                         userInfo: nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    }
    else
    {
        receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedData = nil;
    fetchingConnection = nil;
    fetchingURL = nil;
    errorHandler(error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    fetchingConnection = nil;
    fetchingURL = nil;
    NSString *receivedText = [[NSString alloc] initWithData: receivedData
                                                   encoding: NSUTF8StringEncoding];
    receivedData = nil;
    successHandler(receivedText);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData: data];
}

@end
