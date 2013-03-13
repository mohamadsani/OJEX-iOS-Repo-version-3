//
//  LoginController.h
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong) IBOutlet UITableView *myTableView;

- (IBAction)LoginButtonListener:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
- (IBAction)usernameEditStart:(id)sender;
- (IBAction)usernameEditEnd:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end
