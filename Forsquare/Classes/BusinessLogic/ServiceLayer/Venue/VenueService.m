//
//  VenueService.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueService.h"
#import "VenueCache.h"
#import "VenueParser.h"
#import "VenueTransport.h"
#import "Venue.h"

NSString *VenueSearchFailedError = @"VenueSearchFailedError";

@interface VenueService()
@property (strong, nonatomic) Venue *venueNeedingDetailedInfo;
@end

@implementation VenueService

- (instancetype)init
{
    if(self = [super init])
    {
        self.abstractTransport = [[VenueTransport alloc] init];
        self.abstractCache = [[VenueCache alloc] init];
        self.abstractParser = [[VenueParser alloc] init];
    }
    return self;
}

- (void)setDelegate:(id<VenueServiceDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol: @protocol(VenueServiceDelegate)])
    {
        [[NSException exceptionWithName: NSInvalidArgumentException
                                 reason: @"Delegate object does not conform to the delegate protocol"
                               userInfo: nil] raise];
    }
    _delegate = newDelegate;
}

- (void)requestVenues
{
    [((VenueTransport *)self.abstractTransport) requestVenues];
}

- (void)searchingForVenuesFailedWithError:(NSError *)error
{
    [self tellDelegateAboutVenuesSearchError:error];
}

- (void) tellDelegateAboutVenuesSearchError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject: error
                                                forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: VenueSearchFailedError
                                                   code: VenueServiceErrorSearchCode
                                               userInfo: errorInfo];
    [self.delegate requestingVenuesFailedWithError:reportableError];
}

- (void)receivedVenuesJSON:(NSString *)objectNotation
{
    NSError *error = nil;
    NSArray *venues = [((VenueParser *)self.abstractParser) venuesFromJSON:objectNotation error:&error];
    if(!venues)
    {
        [self tellDelegateAboutVenuesSearchError:error];
    }
    else
    {
        [self.delegate didReceiveVenues:venues];
    }
}

//Detailed info
- (void)requestDetailedInfoForVenue:(Venue *)venue
{
    self.venueNeedingDetailedInfo = venue;
    [((VenueTransport *)self.abstractTransport) requestDetailedInfoForVenueID:venue.idAttribute];
}

- (void)requestDetailedInfoForVenueFailedWithError:(NSError *)error
{
    NSDictionary *errorInfo = nil;
    if (error)
    {
        errorInfo = [NSDictionary dictionaryWithObject: error forKey: NSUnderlyingErrorKey];
    }
    NSError *reportableError = [NSError errorWithDomain: VenueSearchFailedError
                                                   code: VenueServiceErrorVenueDetailedInfoFetchCode
                                               userInfo:errorInfo];
    [self.delegate requestingVenueDetailedInfoFailedWithError: reportableError];
}

- (void)receivedDetailedInfoForVenueJSON:(NSString *)objectNotation
{
    [((VenueParser *)self.abstractParser) fillInDetailedInfoForVenue:self.venueNeedingDetailedInfo fromJSON:objectNotation];
}

@end
