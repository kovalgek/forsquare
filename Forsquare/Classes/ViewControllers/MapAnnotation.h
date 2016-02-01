//
//  MapAnnotation.h
//  Forsquare
//
//  Created by Антон Ковальчук on 03.04.14.
//  Copyright (c) 2016 Антон Ковальчук. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
