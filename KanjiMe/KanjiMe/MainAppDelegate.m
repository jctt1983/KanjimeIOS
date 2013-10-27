//
//  MainAppDelegate.m
//  KanjiMe
//
//  Created by Lion User on 5/25/13.
//  Copyright (c) 2013 Alteran System. All rights reserved.
//

#import "MainAppDelegate.h"
#import "UtilHelper.h"

@implementation MainAppDelegate

-(void)customizeiPhoneTheme
{
    // General
    if([UtilHelper isVersion6AndBelow]) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    
    // Tab Bar Appeareance
    if([UtilHelper isVersion6AndBelow]) {
        UIImage* tabBarBackground = [UIImage tallImageNamed:@"tabbar.png"];
        [[UITabBar appearance] setBackgroundImage:tabBarBackground];
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    }
    // Navigation Bar Appereance
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    if([UtilHelper isVersion6AndBelow]) {
        UIImage *navBarImage = navBarImage = [[UIImage tallImageNamed:@"menubar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
        [navigationBarAppearance setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
        //navBarLandscapeImage = [[UIImage imageNamed:@"menubar-landscape"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
        //[navigationBarAppearance setBackgroundImage:navBarLandscapeImage forBarMetrics:UIBarMetricsLandscapePhone];
    } else {
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];
        UIImage *navBarImage = navBarImage = [[UIImage tallImageNamed:@"menubar-7.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
        [navigationBarAppearance setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    }
    [navigationBarAppearance setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                      UIColorFromRGB(0xf5f5f5), NSForegroundColorAttributeName,
                                                      [UIFont fontWithName:@"MyriadPro-BoldCond" size:23.0], NSFontAttributeName, nil]];

    // Menu Bar Buttons
    if([UtilHelper isVersion6AndBelow]) {
        [[UIBarButtonItem appearance] setTintColor:UIColorFromRGB(0x333333)];
    }
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          UIColorFromRGB(0xf5f5f5), NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"MyriadPro-Cond" size:21.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    //UIImage *barButton = [[UIImage tallImageNamed:@"menubar-clear.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    //[[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //UIImage *backButton = [[UIImage tallImageNamed:@"back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 4)];
    //[[UIBarButtonItem appearance] setBackButtonBackgroundImage:barButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
//    UIImage *minImage = [UIImage tallImageNamed:@"ipad-slider-fill"];
//    UIImage *maxImage = [UIImage tallImageNamed:@"ipad-slider-track.png"];
//    UIImage *thumbImage = [UIImage tallImageNamed:@"ipad-slider-handle.png"];
//    
//    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
//    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
//    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
//    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateHighlighted];
}

- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
{
    /*
    UINavigationController *navigationController = (UINavigationController*)_window.rootViewController;
    ChatViewController *chatViewController =
    (ChatViewController*)[navigationController.viewControllers  objectAtIndex:0];
    
    DataModel *dataModel = chatViewController.dataModel;
    
	Message *message = [[Message alloc] init];
	message.date = [NSDate date];
    
	NSString *alertValue = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    
	NSMutableArray *parts = [NSMutableArray arrayWithArray:[alertValue componentsSeparatedByString:@": "]];
	message.senderName = [parts objectAtIndex:0];
	[parts removeObjectAtIndex:0];
	message.text = [parts componentsJoinedByString:@": "];
    
	int index = [dataModel addMessage:message];
    
	if (updateUI)
		[chatViewController didSaveMessage:message atIndex:index];
     */
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeiPhoneTheme];    
    // Override point for customization after application launch.

#if !TARGET_IPHONE_SIMULATOR
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#endif
    if (launchOptions != nil)
	{
		NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
			[self addMessageFromRemoteNotification:dictionary updateUI:NO];
		}
	}
    return YES;
}
					
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveContext];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Did register for remote notifications: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Fail to register for remote notifications: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Received notification: %@", userInfo);
	[self addMessageFromRemoteNotification:userInfo updateUI:YES];
}

- (CoreDataHandler *)coreDataHandler
{
    
    // Instantiate a single instance of the Database Handler
    if(!_coreDataHandler) {
        _coreDataHandler = [[CoreDataHandler alloc] init];
    }
    return _coreDataHandler;
}

- (void)saveContext
{
    [self.coreDataHandler saveDocument];    
}

@end
