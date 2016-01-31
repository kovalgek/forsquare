//
//  VenueTransport.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractTransport.h"
#import "VenueTransportDelegate.h"

@interface VenueTransport : AbstractTransport <NSURLConnectionDataDelegate>
{
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
@private
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (nonatomic, weak) id <VenueTransportDelegate> delegate;

- (void)requestVenues;
- (void)requestDetailedInfoForVenueID:(NSString *)venueID;

@end
