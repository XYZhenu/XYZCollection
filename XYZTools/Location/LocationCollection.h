//
//  LocationCollection.h
//  XYZCollection
//
//  Created by xieyan on 15/4/8.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationCollection : NSObject<CLLocationManagerDelegate>
-(void)location;


@property (strong, nonatomic)  UILabel *lblMessage;
@property (strong, nonatomic)  UIImageView *imgView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *recentLocation;

-(double)headingToLocation:(CLLocationCoordinate2D)desired current:(CLLocationCoordinate2D)current;
@end
