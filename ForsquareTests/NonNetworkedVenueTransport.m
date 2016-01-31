//
//  NonNetworkedVenueTransport.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 30.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "NonNetworkedVenueTransport.h"

@implementation NonNetworkedVenueTransport

- (void)launchConnectionForRequest: (NSURLRequest *)request
{
    
}

- (void)setReceivedData:(NSData *)data
{
    receivedData = [data mutableCopy];
}

- (NSData *)receivedData
{
    return [receivedData copy];
}

@end
