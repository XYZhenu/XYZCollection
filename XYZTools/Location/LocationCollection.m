//
//  LocationCollection.m
//  XYZCollection
//
//  Created by xieyan on 15/4/8.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "LocationCollection.h"
#define kDestLongitude 113.12 //精度
#define kDestLatitude 22.23 //纬度
#define kRad2Deg 57.2957795 // 180/π
#define kDeg2Rad 0.0174532925 // π/180

@implementation LocationCollection
-(void)location{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    self.locationManager.distanceFilter = 1609; //1英里≈1609米
    [self.locationManager startUpdatingLocation];
    
    if([CLLocationManager headingAvailable])
    {
        self.locationManager.headingFilter = 10; //10°
        [self.locationManager startUpdatingHeading];
    }
    
    
    
    
}

-(double)headingToLocation:(CLLocationCoordinate2D)desired current:(CLLocationCoordinate2D)current
{
    double lat1 = current.latitude*kDeg2Rad;
    double lat2 = desired.latitude*kDeg2Rad;
    double lon1 = current.longitude;
    double lon2 = desired.longitude;
    double dlon = (lon2-lon1)*kDeg2Rad;
    
    double y = sin(dlon)*cos(lat2);
    double x = cos(lat1)*sin(lat2) - sin(lat1)*cos(lat2)*cos(dlon);
    
    double heading=atan2(y,x);
    heading=heading*kRad2Deg;
    heading=heading+360.0;
    heading=fmod(heading,360.0);
    return heading;
}



- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if(error.code == kCLErrorLocationUnknown)
    {
        NSLog(@"Currently unable to retrieve location.");
    }
    else if(error.code == kCLErrorNetwork)
    {
        NSLog(@"Network used to retrieve location is unavailable.");
    }
    else if(error.code == kCLErrorDenied)
    {
        NSLog(@"Permission to retrieve location is denied.");
        [manager stopUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    
}
@end
