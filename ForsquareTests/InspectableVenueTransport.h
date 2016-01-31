//
//  InspectableVenueTransport.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 30.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueTransport.h"

@interface InspectableVenueTransport : VenueTransport
- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;
@end
