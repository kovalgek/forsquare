//
//  MockVenueTransport.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "VenueTransport.h"

@interface MockVenueTransport : VenueTransport
@property (nonatomic) BOOL wasAskedToRequestVenues;
@property (nonatomic) BOOL wasAskedToRequestVenuesDetailedInfo;
@end
