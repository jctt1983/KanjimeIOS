//
//  FeedDetailViewController.h
//  KanjiMe
//
//  Created by Lion User on 8/29/13.
//  Copyright (c) 2013 Alteran System. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AdMobLoader.h"
#import "GADBannerViewDelegate.h"

@interface FeedDetailViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, GADBannerViewDelegate, UIWebViewDelegate> {
    // Declare one as an instance variable
    GADBannerView *bannerView_;
}

@property (nonatomic, weak) IBOutlet UITableView* feedTableView;
- (void)setDetail:(id)newDetailItem;
@end
