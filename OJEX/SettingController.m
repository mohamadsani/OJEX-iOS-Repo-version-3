//
//  SettingController.m
//  OJEX
//
//  Created by Mohamad Sani on 3/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "SettingController.h"

@interface SettingController ()

@end

@implementation SettingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isShareToFacebook = [[NSUserDefaults standardUserDefaults] boolForKey:@"isShareToFacebook"];
	if (isShareToFacebook) {
        [self.facebookSwitch setOn:YES];
    } else {
        [self.facebookSwitch setOn:NO];
    }
    
    BOOL isShareToTwitter = [[NSUserDefaults standardUserDefaults] boolForKey:@"isShareToTwitter"];;
	if (isShareToTwitter) {
        [self.twitterSwitch setOn:YES];
    } else {
        [self.twitterSwitch setOn:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareToFacebook:(id)sender {
    if (self.facebookSwitch.isOn) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isShareToFacebook"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isShareToFacebook"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)shareToTwitter:(id)sender {
    if (self.twitterSwitch.isOn) {
        NSLog(@"twitter on");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isShareToTwitter"];
    } else {
        NSLog(@"twitter off");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isShareToTwitter"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
