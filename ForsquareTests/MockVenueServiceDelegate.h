//
//  MockVenueServiceDelegate.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueServiceDelegate.h"

@interface MockVenueServiceDelegate : NSObject <VenueServiceDelegate>
@property (strong, nonatomic) NSError *fetchError;
@property (strong, nonatomic) NSArray *receivedVenues;
@end
