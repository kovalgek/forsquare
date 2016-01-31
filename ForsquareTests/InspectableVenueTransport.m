//
//  InspectableVenueTransport.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 30.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "InspectableVenueTransport.h"

@implementation InspectableVenueTransport

- (NSURL *)URLToFetch
{
    return fetchingURL;
}

- (NSURLConnection *)currentURLConnection
{
    return fetchingConnection;
}

@end
