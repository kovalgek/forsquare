//
//  VenueServiceDelegate.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

@protocol VenueServiceDelegate <NSObject>

- (void)requestingVenuesFailedWithError:(NSError *)error;
- (void)requestingVenueDetailedInfoFailedWithError:(NSError *)error;
- (void)didReceiveVenues:(NSArray *)venues;
@end
