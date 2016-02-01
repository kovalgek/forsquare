//
//  ServiceLayer.h
//  EventGridManager
//
//  Created by Anton Kovalchuk on 07.01.15.
//  Copyright (c) 2015 Entech Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VenueService.h"
#import "GeoService.h"

@interface ServiceLayer : NSObject
@property (nonatomic, strong) VenueService *venueService;
@property (nonatomic, strong) GeoService   *geoService;
@end
