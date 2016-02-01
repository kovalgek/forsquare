//
//  MapViewController.m
//  Forsquare
//
//  Created by Anton Kovalchuk on 01.02.16.
//  Copyright © 2016 KovalchukCo. All rights reserved.
//

#import "MapViewController.h"
#import "ServiceRegistry.h"
#import "ServiceLayer.h"
#import "GeoService.h"
#import "MapAnnotation.h"
#import "Venue.h"
#import "Location.h"
#import "VenueCache.h"

@interface MapViewController() <GeoServiceProtocol>
- (void)go2Coords;
- (void)addAnnotations;
@end

@implementation MapViewController

- (void)loadView
{
    [super loadView];
    
    self.title = @"MAP";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(goBack)];
    [self go2Coords];
    [self addAnnotations];
}

- (void)go2Coords
{
    float spanX = 0.25725;
    float spanY = 0.25725;
    MKCoordinateRegion region;
    region.center = SREG.serviceLayer.geoService.currentLocation.coordinate;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.map setRegion:region animated:YES];
}

- (void)addAnnotations
{
    NSArray *venues = [((VenueCache *)SREG.serviceLayer.venueService.abstractCache) venues];
    
    for(Venue *venue in venues)
    {
        MapAnnotation *mapAnnotation = [[MapAnnotation alloc] initWithLocation:CLLocationCoordinate2DMake(venue.location.latAttribute.doubleValue, venue.location.lngAttribute.doubleValue)];
        [self.map addAnnotation:mapAnnotation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if ([annotation isKindOfClass:[MapAnnotation class]])
    {
        static NSString *annotationIdentifier = @"MyAnnotation";
        MKAnnotationView *annotationView = [map dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        if (!annotationView)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.image = [UIImage imageNamed:@"locationIcon.png"];
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    return nil;
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
