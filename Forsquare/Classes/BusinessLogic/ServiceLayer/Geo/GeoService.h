//
//  GeoService.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 01.02.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "AbstractEntityService.h"
#import <CoreLocation/CoreLocation.h>

@protocol GeoServiceProtocol <NSObject>
@optional
- (void) didChangeAuthorizationStatus:(CLAuthorizationStatus)status;
- (void) didUpdateLocation:(CLLocation *)location;
- (void) didFailLocation;
@end

@interface GeoService : AbstractEntityService

@property (weak, nonatomic) id<GeoServiceProtocol> delegate;
@property (strong, nonatomic) CLLocation *currentLocation;

- (BOOL)requestWhenInUseAuthorization;
- (void) startUpdatingLocation;

@end
