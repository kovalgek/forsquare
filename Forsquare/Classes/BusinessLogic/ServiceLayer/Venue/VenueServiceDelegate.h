//
//  VenueServiceDelegate.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 29.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

@class Venue;

@protocol VenueServiceDelegate <NSObject>

@optional
- (void)requestingVenuesFailedWithError:(NSError *)error;
- (void)requestingVenueDetailedInfoFailedWithError:(NSError *)error;
- (void)didReceiveVenues:(NSArray *)venues;
- (void)didReceiveVenue:(Venue *)venue;
@end
