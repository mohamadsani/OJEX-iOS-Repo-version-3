//
//  ForgetPasswordController.m
//  OJEX
//
//  Created by Mohamad Sani on 2/18/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "ForgetPasswordController.h"
#import "Connector.h"
#import "Util.h"

@interface ForgetPasswordController ()

@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)resetPassword:(id)sender;

@end

Connector* c;

@implementation ForgetPasswordController

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

- (IBAction)resetPassword:(id)sender {
    self.email = self.emailField.text;
    
    c = [Connector getInstance];
    
    NSMutableArray* key = [[NSMutableArray alloc] initWithObjects:@"usernameoremail",nil];
    NSMutableArray* data = [[NSMutableArray alloc] initWithObjects:self.email,nil];
    NSString* url = @"http://badr-interactive.org/ojex/index.php/profile/forgotPassword";
    
    [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(LoginResponse) withLoading:YES];
}

- (void) LoginResponse {
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: c.receivedData
                          options:kNilOptions
                          error:nil];
    
    if ([[json objectForKey:@"success"] isEqualToString:@"false"])
        [Util showErrorWithMessage:@"Invalid Username/Password"];
    else
        [Util showMessage:@"password sent successfully"];

}
@end
