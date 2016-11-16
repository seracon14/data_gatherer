//
//  Event2.h
//  DataGatherer2
//
//  Created by Sergio Contreras on 1/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Event2 :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * speed;
@property (nonatomic, retain) NSNumber * heading;
@property (nonatomic, retain) NSNumber * distance_interval;
@property (nonatomic, retain) NSNumber * gyro_z;
@property (nonatomic, retain) NSNumber * gyro_y;
@property (nonatomic, retain) NSNumber * accelerometer_z;
@property (nonatomic, retain) NSNumber * horizontal_accuracy;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * gyro_x;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * accelerometer_y;
@property (nonatomic, retain) NSNumber * distance_total;
@property (nonatomic, retain) NSNumber * accelerometer_x;
@property (nonatomic, retain) NSString * date_time;

@end



