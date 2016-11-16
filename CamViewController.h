//
//  CamViewController.h
//  LearnCamera
//
//  Created by Sergio Contreras on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreData/CoreData.h>


@interface CamViewController : UIViewController 
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>
{
	int	pk;
	
	BOOL recording;
	BOOL first_time;
	BOOL disable_start;
	BOOL send_switch;
	
	NSString *xmlString;
	
	CLLocationManager *location_manager;
	CMMotionManager *motion_manager;
	UIImagePickerController *my_ipc;
	
	CLLocation *previous_loc;
	CLLocationDistance running_total;
	CLLocationDistance dist;
	
	IBOutlet UILabel *label_one;
	IBOutlet UILabel *label_two;
	IBOutlet UILabel *label_three;
	IBOutlet UILabel *label_four;
	IBOutlet UILabel *label_five;
	IBOutlet UILabel *label_six;
	IBOutlet UILabel *label_seven;
	IBOutlet UILabel *label_eight;
	IBOutlet UILabel *label_nine;
	
	IBOutlet UISwitch *internet_switch;
	
	IBOutlet UIView *CustomView;
	IBOutlet UIButton *the_button;
	
	NSString *string_From_Date;
	NSTimer *timer;
	NSTimer *timer2;
	NSDate *oldtime;
	
	//NSMutableArray *timestamps_array;
	
	NSMutableData *xmlData;
	NSURLConnection *connectionInProgress;
	
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}
@property(nonatomic) BOOL recording;
@property(nonatomic) BOOL first_time;
@property(nonatomic) BOOL disable_start;
@property(nonatomic) BOOL send_switch;

@property(nonatomic, retain) CLLocationManager *location_manager;
@property(nonatomic, retain) CMMotionManager *motion_manager;
@property(nonatomic, retain) UIImagePickerController *my_ipc;

@property(nonatomic, retain) CLLocation *previous_loc;
@property(nonatomic) CLLocationDistance running_total;
@property(nonatomic) CLLocationDistance dist;

@property(nonatomic, retain) IBOutlet UILabel *label_one;
@property(nonatomic, retain) IBOutlet UILabel *label_two;
@property(nonatomic, retain) IBOutlet UILabel *label_three;
@property(nonatomic, retain) IBOutlet UILabel *label_four;
@property(nonatomic, retain) IBOutlet UILabel *label_five;
@property(nonatomic, retain) IBOutlet UILabel *label_six;
@property(nonatomic, retain) IBOutlet UILabel *label_seven;
@property(nonatomic, retain) IBOutlet UILabel *label_eight;
@property(nonatomic, retain) IBOutlet UILabel *label_nine;
@property(nonatomic, retain) IBOutlet UISwitch *internet_switch;

@property(nonatomic, copy) NSString *string_From_Date;
@property(nonatomic, retain) NSTimer *timer;
@property(nonatomic, retain) NSDate *oldtime;

//@property(nonatomic, retain) NSMutableArray *timestamps_array;

- (NSURL *)applicationDocumentsDirectory;
- (IBAction)start_recording:(id)sender;
- (IBAction)button_down:(id)sender;
- (void)home_button;




@end