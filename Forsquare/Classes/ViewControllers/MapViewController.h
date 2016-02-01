//
//  MapViewController.h
//  Forsquare
//
//  Created by Anton Kovalchuk on 01.02.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *map;
@end
