//
//  DataGatherer2AppDelegate.m
//  DataGatherer2
//
//  Created by Sergio Contreras on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DataGatherer2AppDelegate.h"


@implementation DataGatherer2AppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (id)init
{
	[super init];
	
	// Check available features
	is_st_available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
	NSLog(@"Camera BOOL = %d",(int)is_st_available);
	
	is_st_available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
	NSLog(@"PhotoLibrary BOOL = %d",(int)is_st_available);
	
	is_st_available = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
	NSLog(@"PhotosAlbum BOOL = %d",(int)is_st_available);
	NSDate *today = [NSDate date];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM_dd_yyyy_HH:mm:ss"];
	
	NSString *stringFromDate = [formatter stringFromDate:today];
	[formatter release];
	NSLog(@"%@",stringFromDate);
	
	return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

	//-----------------------------------------------------------------------------------
	
	// Creat a view controller instance of CamViewController
	//CamViewController *view_controller
	this_view = [[CamViewController alloc] initWithNibName:nil bundle:nil];
    
	//Give it the array
	//[this_view setTimestamps_array:ts_array];
	
    [window setRootViewController:this_view]; // put this view controller on window
    //this_view = view_controller;
	//[view_controller release];
	//The window retains the controller, so i can release the reference
	
	[this_view release];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    //[self saveContext];
	[this_view home_button];
	//[self archive_timestamps];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    //[self saveContext];
}


#pragma mark -
#pragma mark Core Data stack




#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {

	[CamViewController release];
    [window release];
    [super dealloc];
}



@end

