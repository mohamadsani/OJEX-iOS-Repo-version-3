//
//  LoginController.m
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "LoginController.h"
#import "Util.h"
#import "GlobalVar.h"
#import "User.h"
#import "Connector.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginController ()

@end

Connector* c;

@implementation LoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//create UI programmatically because UI design from mr. Amri is impossible to do it from storyboard
- (void) createUI
{
    //taro username textfield
    self.usernameTextField.frame = CGRectOffset(self.usernameTextField.frame, 14, 7);
    self.passwordTextField.frame = CGRectOffset(self.passwordTextField.frame, 14, 7);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createUI];
    
   	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LoginButtonListener:(id)sender {
  
    
    c = [Connector getInstance];
    
    NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:@"username",@"password", nil];
    NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:self.usernameTextField.text, self.passwordTextField.text,nil];
    NSString* url = @"http://badr-interactive.org/ojex/index.php/login";
    
    [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(LoginResponse) withLoading:YES];
 
}

NSString* globalId;

- (void) LoginResponse {
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:c.receivedData
                          
                          options:kNilOptions
                          error:nil];
    
    
    if ([[json objectForKey:@"success"] isEqualToString:@"false"]) [Util showErrorWithMessage:@"Invalid Username/Password"];
        else
        {
            //ambil profil diri sendiri
            NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:@"userid", nil];
            NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:[json objectForKey:@"id"],nil];
            NSString* url = @"http://badr-interactive.org/ojex/index.php/profile/get";
            
            [[GlobalVar getInstance] setUserid:[[json objectForKey:@"id"] intValue]];
            [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(GetProfileResponse) withLoading:YES];
            
    	}
}

- (void) GetProfileResponse {
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:c.receivedData
                          
                          options:kNilOptions
                          error:nil];
    
    User* u = [[User alloc] init];
    
    [u createDataWithJSON:json];
    
    u.userId = globalId;
    u.password = self.passwordTextField.text;
    
    [[GlobalVar getInstance] setUser:u];
    [self performSegueWithIdentifier:@"LoginToHome" sender:self];
}

- (IBAction)geserKanan:(id)sender {
    [Util showErrorWithMessage:@"geser"];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellLogin";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0)
        [cell addSubview: self.usernameTextField ];
    else
        [cell addSubview: self.passwordTextField ];
    
    return cell;
}

- (IBAction)usernameEditStart:(id)sender {
    [Util slideFrame:self toUp:YES withHeight:130];
}

- (IBAction)usernameEditEnd:(id)sender {
    
    [Util slideFrame:self toUp:NO withHeight:130];
 
}

-(IBAction)logout:(UIStoryboardSegue *)segue {
    
}
@end
