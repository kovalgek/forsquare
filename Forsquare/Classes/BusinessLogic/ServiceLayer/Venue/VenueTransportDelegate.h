//
//  VenueTransportDelegate.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 31.01.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//
@protocol  VenueTransportDelegate <NSObject>

- (void)searchingForVenuesFailedWithError:(NSError *)error;
- (void)receivedVenuesJSON:(NSString *)objectNotation;

- (void)requestDetailedInfoForVenueFailedWithError:(NSError *)error;
- (void)receivedDetailedInfoForVenueJSON:(NSString *)objectNotation;

@end