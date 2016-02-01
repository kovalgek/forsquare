//
//  ServiceLayer.m
//  EventGridManager
//
//  Created by Anton Kovalchuk on 07.01.15.
//  Copyright (c) 2015 Entech Solutions. All rights reserved.
//

#import "ServiceLayer.h"

@interface ServiceLayer()

@end

@implementation ServiceLayer


- (instancetype)init
{
    if(self = [super init])
    {
        self.venueService = [[VenueService alloc] init];
        self.geoService   = [[GeoService alloc] init];
    }
    return self;
}

@end
