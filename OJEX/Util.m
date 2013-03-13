//
//  Util.m
//  OJEX
//
//  Created by alham fikri on 1/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "Util.h"

@interface Util ()

@end

@implementation Util

@synthesize receivedData;


static UIAlertView *loading;
static UIAlertView *errorAlert;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) showLoading
{
    if (loading == nil){
        loading = [[UIAlertView alloc] init];
        loading.title = @"loading";
        loading.message = @"please wait...";
    }
    
    [loading show];
}

+ (void) hideLoading
{
    if (loading == nil){
        loading = [[UIAlertView alloc] init];
        loading.title = @"loading";
        loading.message = @"please wait...";
    }
    
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
}

+ (void) showErrorWithMessage:(NSString *)x
{
    if (errorAlert == nil){
        errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
       
        
        
    }
     errorAlert.title = @"Error";
    errorAlert.message = x;
    [errorAlert show];
}

+ (void) showMessage:(NSString *)x
{
    if (errorAlert == nil){
        errorAlert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        errorAlert.title = @"";
        
        
    }
    errorAlert.title = @"";
    errorAlert.message = x;
    [errorAlert show];
}

+ (void) slideFrame:(UIViewController *)x toUp:(BOOL)direction
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (direction ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    x.view.frame = CGRectOffset(x.view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (void)slideFrame:(UIViewController *)x toUp:(BOOL)direction withHeight:(int)h
{
    const int movementDistance = h; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (direction ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    x.view.frame = CGRectOffset(x.view.frame, 0, movement);
    [UIView commitAnimations];
}

+ (float)rupiahToPoint:(float)rupiah
{
    return rupiah / 10000.0;
}


@end
