//
//  MockVenueService.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueTransportDelegate.h"

@interface MockVenueService : NSObject <VenueTransportDelegate>

@property (nonatomic) NSInteger venueSearchFailureErrorCode;
@property (nonatomic) NSInteger venueDetailedFailureErrorCode;
@property (nonatomic, strong) NSString *venueSearchString;
@property (nonatomic, strong) NSString *venueByIDString;

@end
