//
//  MapAnnotation.m
//  CustomerApp
//
//  Created by Антон Ковальчук on 03.04.14.
//  Copyright (c) 2014 Антон Ковальчук. All rights reserved.
//

#import "MapAnnotation.h"

@implementation MapAnnotation

- (id)initWithLocation:(CLLocationCoordinate2D)coord
{
    if (self = [super init])
    {
        _coordinate = coord;
    }
    return self;
}
@end
