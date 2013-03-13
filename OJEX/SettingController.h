//
//  SettingController.h
//  OJEX
//
//  Created by Mohamad Sani on 3/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *facebookSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *twitterSwitch;
- (IBAction)shareToFacebook:(id)sender;
- (IBAction)shareToTwitter:(id)sender;

@end
