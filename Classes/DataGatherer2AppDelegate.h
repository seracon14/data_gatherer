//
//  DataGatherer2AppDelegate.h
//  DataGatherer2
//
//  Created by Sergio Contreras on 12/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CamViewController.h"

@interface DataGatherer2AppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	CamViewController *this_view;
	BOOL is_st_available;
    

}

@property (nonatomic, retain) IBOutlet UIWindow *window;



- (NSURL *)applicationDocumentsDirectory;


@end

