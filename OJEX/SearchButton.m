//
//  SearchButton.m
//  OJEX
//
//  Created by alham fikri on 1/28/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "SearchButton.h"
#import "LoginController.h"
#import "User.h"
#import "GlobalVar.h"
#import "ProfileWrapperController.h"
#import <QuartzCore/QuartzCore.h>

@implementation SearchButton

@synthesize wrapper;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)searchPressed:(id)sender {
    NSString *actionSheetTitle = @"Menu"; //Action Sheet Title
    
    NSString *button1 = @"My Profile";
    if ([[[GlobalVar getInstance] user] isEqual:[[GlobalVar getInstance] userProfile]] &&[wrapper isKindOfClass:[ProfileWrapperController class]])
        button1 = @"Edit Profile";
    NSString *button2 = @"Pengaturan";
    NSString *button3 = @"Go Premium";
    NSString *button4 = @"Tentang";
    NSString *button5 = @"Logout";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:button1, button2, button3, button4, button5, nil];
    
    [actionSheet showInView:self];
    

}

- (IBAction)postARide:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle: nil];
    
    //opening my profile
    UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"PostARideNavigation"];

    
    [wrapper presentViewController:myNewVC animated:YES completion:NULL];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle: nil];
    
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"My Profile"]) {
        //opening my profile
        UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"ProfileNavigation"];
       
        GlobalVar* g = [GlobalVar getInstance];
        g.userProfile = g.user;
        
        [wrapper presentViewController:myNewVC animated:YES completion:NULL];
    }
    
    if ([buttonTitle isEqualToString:@"Edit Profile"]) {
        [wrapper performSegueWithIdentifier:@"ProfileToEdit" sender:self];
    }
    
    if ([buttonTitle isEqualToString:@"Pengaturan"]) {
        UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"SettingNavigation"];
        [wrapper presentViewController:myNewVC animated:YES completion:NULL];
    }
    
    if ([buttonTitle isEqualToString:@"Tentang"]) {
        UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"PremiumNavigation"];
        [wrapper presentViewController:myNewVC animated:YES completion:NULL];
    }
    
    if ([buttonTitle isEqualToString:@"Go Premium"]) {
        UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"PremiumNavigation"];
        [wrapper presentViewController:myNewVC animated:YES completion:NULL];
    }
    
    if ([buttonTitle isEqualToString:@"Logout"]) {
        //just go to Login Screen
        UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"];
        [wrapper presentViewController:myNewVC animated:YES completion:NULL];
    }
    
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }

}


@end
