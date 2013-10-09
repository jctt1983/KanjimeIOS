//
//  MainAppDelegate.h
//  KanjiMe
//
//  Created by Lion User on 5/25/13.
//  Copyright (c) 2013 Alteran System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHandler.h"

#import "Collection.h"

@interface MainAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) CoreDataHandler *coreDataHandler;
@property (strong, nonatomic) Collection *collection;



@end
