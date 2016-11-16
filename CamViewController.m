//
//  CamViewController.m
//  LearnCamera
//
//  Created by Sergio Contreras on 12/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CamViewController.h"
#import "MobileCoreServices/MobileCoreServices.h"
#import "Event2.h"
@class InfoGathererAppDelegate;


@implementation CamViewController

@synthesize recording;
@synthesize first_time;
@synthesize disable_start;
@synthesize send_switch;

@synthesize location_manager;
@synthesize motion_manager;
@synthesize my_ipc;

@synthesize label_one;
@synthesize label_two;
@synthesize label_three;
@synthesize label_four;
@synthesize label_five;
@synthesize label_six;
@synthesize label_seven;
@synthesize label_eight;
@synthesize label_nine;
@synthesize internet_switch;

@synthesize string_From_Date;

@synthesize previous_loc;
@synthesize running_total;
@synthesize dist;

@synthesize timer;
@synthesize oldtime;

//@synthesize timestamps_array;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.recording = NO; // not recording
		self.disable_start = NO;	// start works like it should
		self.my_ipc = [[[UIImagePickerController alloc] init] autorelease];
		if ([CLLocationManager headingAvailable] == NO) 
		{
			NSLog(@"no heading available");
		}
		
		
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];	
}

- (void)viewDidAppear:(BOOL)animated{
	//+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)repeats
	self.oldtime = [NSDate date];
	//Create the location manager object
	location_manager = [[CLLocationManager alloc] init];
	
	motion_manager = [[CMMotionManager alloc] init];
	
	//Make this object(GPSRecorderAppDelegate) the delegate for location_manager
	[location_manager setDelegate:self];
	
	//Set the distance filter to update for any movement
	[location_manager setDistanceFilter:kCLDistanceFilterNone];
	
	//Set for best accuracy, will consume the most power, and take the most time
	[location_manager setDesiredAccuracy:kCLLocationAccuracyBest];
	//[location_manager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
	
	[self.my_ipc setSourceType:UIImagePickerControllerSourceTypeCamera]; //get camera
	[self.my_ipc setMediaTypes:[[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil]]; //movie
	[self.my_ipc setDelegate:self]; // set delegate to CamViewController
	// Set options for image picker
	[self.my_ipc setCameraOverlayView:CustomView];  // put my custom view on top
	[self.my_ipc setShowsCameraControls:NO]; //turn off default camera controls
	[self.my_ipc setCameraDevice:UIImagePickerControllerCameraDeviceRear]; //rear device
	[self.my_ipc setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff]; //turn off the lights
	[self.my_ipc setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff]; //turn off the lights
	[self.my_ipc setVideoMaximumDuration:3600]; // set maximum duration to 1 hour
	
	[self presentModalViewController:self.my_ipc animated:YES];
	
}




/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	/*
	 [label_one release];
	 [label_two release];
	 [label_three release];
	 [label_four release];
	 [label_five release];
	 [label_six release];
	 [label_seven release];
	 */
	//[my_ipc release];
	//[location_manager release];
	//[motion_manager release];
	label_one = nil;
	label_two = nil;
	label_three = nil;
	label_four = nil;
	label_five = nil;
	label_six = nil;
	label_seven = nil;
	label_eight = nil;
	label_nine = nil;
	internet_switch = nil;
	//location_manager = nil;
	//motion_manager = nil;
}


- (void)dealloc {
	[label_one release];
	[label_two release];
	[label_three release];
	[label_four release];
	[label_five release];
	[label_six release];
	[label_seven release];
	[label_eight release];
	[label_nine release];
	[internet_switch release];
	
	[the_button release];
	[CustomView release];
	
	[my_ipc release];
	[location_manager release];
	[motion_manager release];
	
	[previous_loc release];

	
	
	[timer release];
	[string_From_Date release];
	[oldtime release];
	
	[xmlData release];
	[connectionInProgress release];
	
	//[timestamps_array release];
	
    [super dealloc];
}

- (IBAction)start_recording:(id)sender  // main start button
{
	if (recording==YES)	// if it is "recording" then stop recording	
	{
		[timer invalidate];			// stop timer
		[sender setEnabled:NO];		// disable the button
		
		[location_manager stopUpdatingLocation];	// stop getting locations
		
		if ([CLLocationManager headingAvailable] == YES) {
			[location_manager stopUpdatingHeading];
			NSLog(@"Stopped Updating Heading");
		}
		
		
		// stop accelerometer and gyro updates 		
		[motion_manager stopAccelerometerUpdates];
		[motion_manager stopGyroUpdates];
		
		
		// set boolean
		self.recording = NO;
		
		
		// clean out displays
		[label_one setText:@"Instant Transmission of Data?"];
		[label_two setText:@""];
		[label_three setText:@""];
		[label_four setText:@""];
		[label_five setText:@""];
		[label_six setText:@""];
		[label_seven setText:@""];
		[label_eight setText:@""];
		[label_nine setText:@""];
		//----------------------------------------------------------------
		[managedObjectContext_ release];
		[persistentStoreCoordinator_ release];
		[managedObjectModel_ release];
		managedObjectContext_ = nil;
		persistentStoreCoordinator_ = nil;
		managedObjectModel_ = nil;
		//----------------------------------------------------------------
		
		[self.my_ipc stopVideoCapture]; // stop the recording
		
		[sender setTitle:@"Start" forState:UIControlStateNormal] ; //change the button to "start"
		[sender setEnabled:YES];
		[CustomView addSubview:internet_switch];
	}
	else	// it is off and should start recording
	{
		if (disable_start == YES) {
			return;		// start was held for more than 5 seconds
			// don't do anything if this happens
		}
		
		[timer2 invalidate];	// less than 5 seconds, stop timer2
		
		[sender setEnabled:NO];		//disable the button
		
		pk = 0;			// set primary key to 0
		[label_one setText:@""];
		
		self.send_switch = internet_switch.on;
		[internet_switch removeFromSuperview]; // remove switch
		
		self.first_time= YES;		//set this to YES
		
		// start getting locations
		NSDate *today = [NSDate date];		//Get the date
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];	// get a formatter
		[formatter setDateFormat:@"MM_dd_yyyy_hh_mm_ss"];		// format of the formatter
		
		self.string_From_Date = [formatter stringFromDate:today];	// make it a string
		NSLog(@"%@", self.string_From_Date);		// display the string
		
		[formatter release];
		formatter = nil;		// get rid of formatter
		
		NSString *folder_name = [NSString stringWithFormat:@"%@/%@",[NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()], self.string_From_Date];
		NSLog(@"%@", folder_name);
		
		[[NSFileManager defaultManager] createDirectoryAtPath:folder_name withIntermediateDirectories:(BOOL)YES attributes:nil error:nil];
		// this creates a directory with the name of the timestamp
		
		//[timestamps_array addObject:folder_name]; // put the name of the directory on the timestamps array
		
		NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataGatherer2" withExtension:@"momd"];
		managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]; 
		
		
		NSString *stringFromDate2 = [NSString stringWithFormat:@"%@.sqlite", string_From_Date];
		
		NSURL *storeURL = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:(@"%@",string_From_Date)]  URLByAppendingPathComponent:(@"%@",stringFromDate2)];
		NSLog(@"%@", storeURL);
		
		NSError *error = nil;
		persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel_];
		if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 
			 Typical reasons for an error here include:
			 * The persistent store is not accessible;
			 * The schema for the persistent store is incompatible with current managed object model.
			 Check the error message to determine what the actual problem was.
			 
			 
			 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
			 
			 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
			 * Simply deleting the existing store:
			 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
			 
			 * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
			 [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
			 
			 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
			 
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}   
		
		NSPersistentStoreCoordinator *coordinator = persistentStoreCoordinator_;
		if (coordinator != nil) {
			managedObjectContext_ = [[NSManagedObjectContext alloc] init];
			[managedObjectContext_ setPersistentStoreCoordinator:coordinator];
		}
		
		
		[location_manager startUpdatingLocation];
		
		if ([CLLocationManager headingAvailable] == YES) 
		{
			[location_manager startUpdatingHeading];
			NSLog(@"Started Updating Heading");
			//[motion_manager dismissHeadingCalibrationDisplay];
		}
		
		
		// start the updates
		[motion_manager	setAccelerometerUpdateInterval:0.5];
		[motion_manager startAccelerometerUpdates];
		
		[motion_manager	setGyroUpdateInterval:0.5];
		[motion_manager startGyroUpdates];
		
		recording = YES;
		
		
		
		[self.my_ipc startVideoCapture]; //start recording
		[sender setTitle:@"Stop" forState:UIControlStateNormal]; // change button to stop
		
		[sender setEnabled:YES];
		timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(targetMethod:) userInfo:nil repeats: YES];
	}
}



- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
	if (self.recording==YES) {
		// Then video stopped because of duration limit
		
		[timer invalidate];		//stop the updating timer
		
		[the_button setEnabled:NO];
		
		// stop getting locations
		[location_manager stopUpdatingLocation];
		
		if ([CLLocationManager headingAvailable] == YES) 
		{
			[location_manager stopUpdatingHeading];
			NSLog(@"Stopped Updating Heading");
		}
		
		
		//stop accelerometer and gyro
		[motion_manager stopAccelerometerUpdates];
		[motion_manager stopGyroUpdates];
		
		// set boolean
		self.recording = NO;
		
		// clean out displays
		
		[label_one setText:@""];
		[label_two setText:@""];
		[label_three setText:@""];
		[label_four setText:@""];
		[label_five setText:@""];
		[label_six setText:@""];
		[label_seven setText:@""];
		[label_eight setText:@""];
		[label_nine setText:@""];
		//----------------------------------------------------------------
		[managedObjectContext_ release];
		[persistentStoreCoordinator_ release];
		[managedObjectModel_ release];
		managedObjectContext_ = nil;
		persistentStoreCoordinator_ = nil;
		managedObjectModel_ = nil;
		
		[the_button setTitle:@"Start" forState:UIControlStateNormal] ; //change the button to start
		[the_button setEnabled:YES];
		[CustomView addSubview:internet_switch];
	}
	
	NSString *tempFilePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
	
	/*
	 if ( UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(tempFilePath))
	 {
	 // Copy it to the camera roll.
	 UISaveVideoAtPathToSavedPhotosAlbum(tempFilePath, nil, nil, nil);
	 }
	 */	
	
	NSString *destinationPath = [NSString stringWithFormat:@"%@/%@.MOV",[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(), self.string_From_Date], self.string_From_Date]; 
	NSLog(@"%@", destinationPath);
	[[NSFileManager defaultManager] moveItemAtPath:tempFilePath toPath:destinationPath error:nil];
	
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location:%@",error);
	
	Event2 *rd = (Event2 *)[NSEntityDescription 
							insertNewObjectForEntityForName:@"Event2" 
							inManagedObjectContext:managedObjectContext_];
	
	
	// store the description of the newLocation to string display
	[label_one setText:(@"%@", [error description])];
	//[rd setLatitude:0];
	//[rd setLongitude:0];
	
	[label_two setText:(@"%@", [error description])];
	//[rd setHorizontal_accuracy:0];
	
	[label_three setText:(@"%@", [error description])];
	//[rd setSpeed:0];
	
	[label_four setText:(@"%@", [error description])];
	//[rd setHeading:0];
	
	[label_five setText:(@"%@", [error description])];
	//NSString *err = (@"%@", error);
	[rd setDate_time:(@"%@", [error description]) ];
	
	
	[label_six setText:[NSString stringWithFormat:@"%@%@%c", @"a: ", motion_manager.accelerometerData]];
	
	
	CMAccelerometerData *accel = motion_manager.accelerometerData;
	CMAcceleration acc = accel.acceleration;
	NSLog(@"accel pieces = %f, %f, %f", acc.x, acc.y, acc.z);
	
	
	[rd setAccelerometer_x:[NSNumber numberWithFloat:acc.x]];
	[rd setAccelerometer_y:[NSNumber numberWithFloat:acc.y]];
	[rd setAccelerometer_z:[NSNumber numberWithFloat:acc.z]];
	/*
	 [label_seven setText:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
	 [rd setGyro:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
	 */
	
	
	[label_seven setText:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
	
	CMGyroData *gyroData = motion_manager.gyroData;
	CMRotationRate rotate = gyroData.rotationRate;
	NSLog(@"gyro pieces = %f, %f, %f", rotate.x, rotate.y, rotate.z);
	
	[rd setGyro_x:[NSNumber numberWithFloat:rotate.x]];
	[rd setGyro_y:[NSNumber numberWithFloat:rotate.y]];
	[rd setGyro_z:[NSNumber numberWithFloat:rotate.z]];
	
	NSError *error2 = nil;
	if (![managedObjectContext_ save:&error2]) {
		NSLog(@"error in saving");
	}
	
	[timer invalidate]; // stop timer
	
	[the_button setEnabled:NO];
	
	// stop getting locations
	[location_manager stopUpdatingLocation];
	
	if ([CLLocationManager headingAvailable] == YES) {
		[location_manager stopUpdatingHeading];
		NSLog(@"Stopped Updating Heading");
	}
	
	
	// stop accelerometer and gyro updates 		
	[motion_manager stopAccelerometerUpdates];
	[motion_manager stopGyroUpdates];
	
	// set boolean
	self.recording = NO;
	
	//----------------------------------------------------------------
	[managedObjectContext_ release];
	[persistentStoreCoordinator_ release];
	[managedObjectModel_ release];
	managedObjectContext_ = nil;
	persistentStoreCoordinator_ = nil;
	managedObjectModel_ = nil;
	
	[self.my_ipc stopVideoCapture]; // stop the recording
	
	[the_button setTitle:@"Start" forState:UIControlStateNormal] ; //change the button to start
	[the_button setEnabled:YES];
	[CustomView addSubview:internet_switch];
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)x
{
	//Return YES if incoming orientation is Portrait
	// or either of the Landscapes, otherwise, Return NO
	return (x == UIInterfaceOrientationPortrait) || UIInterfaceOrientationIsLandscape(x);
}

- (NSURL *)applicationDocumentsDirectory 
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)home_button
{
	// Save and init
	if (self.recording==YES) 
	{
		// Then video stopped because application is in background
		[timer invalidate];
		[the_button setEnabled:NO];
		// stop getting locations
		[location_manager stopUpdatingLocation];
		
		if ([CLLocationManager headingAvailable] == YES) {
			[location_manager stopUpdatingHeading];
		}
		
		
		[motion_manager stopAccelerometerUpdates];
		[motion_manager stopGyroUpdates];
		
		// set boolean
		self.recording = NO;
		
		// clean out displays
		
		[label_one setText:@"Instant Transmission of Data?"];
		[label_two setText:@""];
		[label_three setText:@""];
		[label_four setText:@""];
		[label_five setText:@""];
		[label_six setText:@""];
		[label_seven setText:@""];
		[label_eight setText:@""];
		[label_nine setText:@""];
		//----------------------------------------------------------------
		[managedObjectContext_ release];
		[persistentStoreCoordinator_ release];
		[managedObjectModel_ release];
		managedObjectContext_ = nil;
		persistentStoreCoordinator_ = nil;
		managedObjectModel_ = nil;
		
		[self.my_ipc stopVideoCapture]; // stop the recording
		
		/*
		 NSError *error3 = nil;
		 if (![managedObjectContext_ save:&error3]) 
		 {
		 NSLog(@"error in saving");
		 }
		 */
		
		[the_button setTitle:@"Start" forState:UIControlStateNormal] ; //change the button to start
		[the_button setEnabled:YES];
		[CustomView addSubview:internet_switch];
	}
	
}

-(void) targetMethod: (NSTimer *) theTimer 
{
	// stop location updates 		
	[location_manager stopUpdatingLocation];
	
	
	NSLog(@"It has been 1 second");
	
	NSLog(@"%@", location_manager.location.timestamp);
	NSLog(@"%@", self.oldtime);
	
	//NSTimeInterval one_second= 1;
	NSTimeInterval secondsBetween = [location_manager.location.timestamp timeIntervalSinceDate:self.oldtime];
	float secondselapsed = (float)secondsBetween;
	float fixed_seconds = 5;
	NSLog(@"%d", secondselapsed);
	NSLog(@"%d", fixed_seconds);
	
	if ((fixed_seconds-secondselapsed) <= 0.2) 
	{
		
		self.oldtime = location_manager.location.timestamp;
		NSLog(@"%@", oldtime);
		
		
		Event2 *rd = (Event2 *)[NSEntityDescription 
								insertNewObjectForEntityForName:@"Event2" 
								inManagedObjectContext:managedObjectContext_];
		
		
		[label_one setText:[NSString stringWithFormat:@"%@%f %f", @"coordinate: ", location_manager.location.coordinate ]];
		CLLocationCoordinate2D location2d = location_manager.location.coordinate;
		
		[rd setLatitude:[NSNumber numberWithFloat:location2d.latitude]];
		[rd setLongitude:[NSNumber numberWithFloat:location2d.longitude]];
		
		[label_two setText:[NSString stringWithFormat:@"%@%f", @"horizontal accuracy: ", location_manager.location.horizontalAccuracy ]];
		[rd setHorizontal_accuracy:[NSNumber numberWithFloat:location_manager.location.horizontalAccuracy ]];
		
		[label_three setText:[NSString stringWithFormat:@"%@%f", @"speed: ", location_manager.location.speed]];
		[rd setSpeed:[NSNumber numberWithFloat:location_manager.location.speed]];
		
		[label_four setText:[NSString stringWithFormat:@"%@%f", @"heading: ", location_manager.location.course]];
		[rd setHeading:[NSNumber numberWithFloat:location_manager.location.course]];
		
		
		NSDate *timestamp_date =  oldtime;
		NSDateFormatter *formatter_ = [[NSDateFormatter alloc] init];
		[formatter_ setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
		[formatter_ setTimeZone:[NSTimeZone timeZoneWithName:@"PST"]];
		NSString *stringFromDate = [formatter_ stringFromDate:timestamp_date];
		[formatter_ release];
		NSLog(@"%@",stringFromDate);
		
		
		[label_five setText:[NSString stringWithFormat:@"%@%@", @"timestamp: ", stringFromDate]];
		[rd setDate_time:[NSString stringWithFormat:@"%@", stringFromDate]];
		
		
		[label_six setText:[NSString stringWithFormat:@"%@%@%c", @"a: ", motion_manager.accelerometerData]];
		
		
		CMAccelerometerData *accel = motion_manager.accelerometerData;
		CMAcceleration acc = accel.acceleration;
		
		
		[rd setAccelerometer_x: [NSNumber numberWithFloat:acc.x]];
		[rd setAccelerometer_y: [NSNumber numberWithFloat:acc.y]];
		[rd setAccelerometer_z: [NSNumber numberWithFloat:acc.z]];
		/*
		 [label_seven setText:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
		 [rd setGyro:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
		 */
		
		
		[label_seven setText:[NSString stringWithFormat:@"%@%@%c", @"g: ", motion_manager.gyroData]];
		
		CMGyroData *gyroData = motion_manager.gyroData;
		CMRotationRate rotate = gyroData.rotationRate;
		
		
		[rd setGyro_x:[NSNumber numberWithFloat:rotate.x]];
		[rd setGyro_y:[NSNumber numberWithFloat:rotate.y]];
		[rd setGyro_z:[NSNumber numberWithFloat:rotate.z]];
		
		// distance stuff here
		if (self.first_time == YES) {
			// this is first location, no distance to report
			self.previous_loc = location_manager.location;
		
			self.first_time = NO; // only first time once
			self.dist = [location_manager.location distanceFromLocation:location_manager.location];
			self.running_total = [location_manager.location distanceFromLocation:location_manager.location];
			
			[label_eight setText:[NSString stringWithFormat:@"%@%f", @"interval distance: ", self.dist]];
			[label_nine setText:[NSString stringWithFormat:@"%@%f", @"total kilometers: ", self.running_total/1000]];
		}
		else 
		{
			if(location_manager.location.horizontalAccuracy <= 20){
			// get distance from last location
			self.dist = [location_manager.location distanceFromLocation:self.previous_loc];
			[rd setDistance_interval:[NSNumber numberWithFloat:self.dist]];
			[label_eight setText:[NSString stringWithFormat:@"%@%f", @"interval distance: ", self.dist]];
			
			self.running_total = self.running_total + self.dist;
			[rd setDistance_total:[NSNumber numberWithFloat:(self.running_total/1000)]];
			[label_nine setText:[NSString stringWithFormat:@"%@%f", @"total kilometers: ", self.running_total/1000]];
			
			self.previous_loc = location_manager.location;
			}
			else {
				self.dist = [location_manager.location distanceFromLocation:location_manager.location];
				[rd setDistance_interval:[NSNumber numberWithFloat:self.dist]];
				[label_eight setText:[NSString stringWithFormat:@"%@%f", @"interval distance: ", self.dist]];
				
				[rd setDistance_total:[NSNumber numberWithFloat:(self.running_total/1000)]];
				[label_nine setText:[NSString stringWithFormat:@"%@%f", @"total kilometers: ", self.running_total/1000]];
			}

		}
		NSError *error1 = nil;
		if (![managedObjectContext_ save:&error1]) {
			NSLog(@"error in saving");
		}
		
		
		///////////////////////////////////////////////////// send to server
		
		//NSString *xmlString = @"<?xml version=\"1.0\"?>\n<table>\n<passwordin>ta6aSU3a</passwordin>\n<site>site1</site>\n<driversb>Yes</driversb>\n<driverage>15-19</driverage>\n<driversex>Male</driversex>\n<driverrace>Caucasian</driverrace>\n<passengersb>Yes</passengersb>\n<passengerage>20-60</passengerage>\n<passengersex>Female</passengersex>\n<passengerrace>Caucasian</passengerrace>\n<state>NV</state>\n<vehicle>Sedan/Station Wagon</vehicle>\n<passwordout>sqwb3QQs</passwordout>\n</table>";
		if (send_switch) {
			
		pk = pk + 1;
		//NSString *xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\"?>\n<table>%@\n<passwordin>ta6aSU3a</passwordin>\n<pk>", self.string_From_Date];
		//xmlString = [xmlString stringByAppendingString:@"1</pk>\n<acc_x>"]; 
			
		xmlString = [NSString stringWithFormat:@"<?xml version=\"1.0\"?>\n<table>%@\n<passwordin>ta6aSU3a</passwordin>\n<pk>", self.string_From_Date];	
			
		xmlString = [xmlString stringByAppendingFormat:@"%i</pk>\n<acc_x>", pk]; 
		xmlString = [xmlString stringByAppendingFormat:@"%@</acc_x>\n<acc_y>", [NSNumber numberWithFloat:acc.x]]; 
		xmlString = [xmlString stringByAppendingFormat:@"%@</acc_y>\n<acc_z>", [NSNumber numberWithFloat:acc.y]]; 
		xmlString = [xmlString stringByAppendingFormat:@"%@</acc_z>\n<gyro_x>", [NSNumber numberWithFloat:acc.z]];
		
		xmlString = [xmlString stringByAppendingFormat:@"%@</gyro_x>\n<gyro_y>", [NSNumber numberWithFloat:rotate.x]]; 
		xmlString = [xmlString stringByAppendingFormat:@"%@</gyro_y>\n<gyro_z>", [NSNumber numberWithFloat:rotate.y]]; 
		xmlString = [xmlString stringByAppendingFormat:@"%@</gyro_z>\n<dist_int>", [NSNumber numberWithFloat:rotate.z]]; 
		
		xmlString = [xmlString stringByAppendingFormat:@"%@</dist_int>\n<tot_dist>", [NSNumber numberWithFloat:self.dist]];
		xmlString = [xmlString stringByAppendingFormat:@"%@</tot_dist>\n<hor_acc>", [NSNumber numberWithFloat:(self.running_total/1000)]];
		xmlString = [xmlString stringByAppendingFormat:@"%@</hor_acc>\n<long>", [NSNumber numberWithFloat:location_manager.location.horizontalAccuracy ]];
		NSLog(@"Mistake after this");
		xmlString = [xmlString stringByAppendingFormat:@"%@</long>\n<latt>", [NSNumber numberWithFloat:location2d.longitude]];
		xmlString = [xmlString stringByAppendingFormat:@"%@</latt>\n<heading>", [NSNumber numberWithFloat:location2d.latitude]];
		xmlString = [xmlString stringByAppendingFormat:@"%@</heading>\n<speed>", [NSNumber numberWithFloat:location_manager.location.course]];
		
		xmlString = [xmlString stringByAppendingFormat:@"%@</speed>\n<timestamp>", [NSNumber numberWithFloat:location_manager.location.speed]];
		xmlString = [xmlString stringByAppendingFormat:@"%@</timestamp>\n<passwordout>sqwb3QQs</passwordout>\n</table>", [NSString stringWithFormat:@"%@", stringFromDate]];
		
		NSLog(@"%@", xmlString);
			
		
		// Construct the web service URL
		///*
		 NSURL *url = [NSURL URLWithString:@"http://nutc.unlv.edu/APMS_service.php"];
		 
		 
		 // Construct the web service URL
		 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
		 cachePolicy:NSURLRequestReloadIgnoringCacheData
		 timeoutInterval:10];
		 [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"]; 
		 [request setHTTPMethod:@"POST"]; 
		 [request setHTTPBody:[xmlString dataUsingEncoding:NSUTF8StringEncoding]]; 
		 
		 
		 if (connectionInProgress) {
		 [connectionInProgress cancel];
		 [connectionInProgress release];
		 }
		 
		 //Instantiate the object to hold all incoming data
		 [xmlData release];
		 xmlData = [[NSMutableData alloc] init];
		 
		 //Create and initiate the connection - non-blocking
		 connectionInProgress = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
		 //*/
		
		}
		///////////////////////////////////////////////////// send to server
	}
	
	[location_manager startUpdatingLocation];
	

}

- (IBAction)button_down:(id)sender
{
	if (self.recording==YES) {
		return;		// if its recording, button is pressed for stopping the recording
	}
	
	// if it gets to here, then the button was pressed to record
	timer2 = [NSTimer scheduledTimerWithTimeInterval: 5.0 target:self selector:@selector(targetMethod2:) userInfo:nil repeats: NO];
}

-(void) targetMethod2: (NSTimer *) theTimer 
{
	self.disable_start = YES;
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erase All Data?" 
													message:@"Erasing all saved data will free up memory. Make sure to save data elsewhere before erasing."
												   delegate:self
										  cancelButtonTitle:@"NO" 
										  otherButtonTitles:@"YES", nil];
	[alert show];
	//[alert release]; dont need to release if delegate is used
	return;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {						// if click came from YES
		// erase data
		self.disable_start = NO;
		
		
		 
		
		NSArray *homePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *homeDir = [homePaths objectAtIndex:0];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		NSError *error=nil;
		
		NSArray *contents = [fileManager contentsOfDirectoryAtPath:homeDir error:nil];
		
		for (NSString *file in contents) {
			BOOL success = [fileManager removeItemAtPath:[homeDir stringByAppendingPathComponent:file] error:&error];
			
			if(!success){
				NSLog(@"couldn't delete file: %@",error);
			}
		}
		
		
		return;
	}
	else {
		self.disable_start = NO;
		return;
	}
	
}

//This method will be called several times as the data arrives
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[xmlData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//We are just checking to make sure we are getting the XML
	NSString *xmlCheck = [[[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"xmlCheck = %@", xmlCheck);
	
	
	
	//----------------------------------------------------------------------------
	/*
	 //Create the parser object with the data received from the web service
	 NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
	 
	 //Give it a delegate
	 [parser setDelegate:self];
	 
	 //Tell it to start parsing - the document will be parsed and 
	 //the delegate of NSXMLParser will get all of its delegate messages
	 // sent to it before this line finishes execution- it is blocking
	 [parser parse];
	 
	 // The parser is done (it blocks until done), you can release it immediately
	 [parser release];
	 */
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connectionInProgress release];
	connectionInProgress= nil;
	
	[xmlData release];
	xmlData = nil;
	
	NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [error localizedDescription]];
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorString delegate:nil cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil];
	[actionSheet showInView:CustomView];
	[actionSheet autorelease];
}

@end
