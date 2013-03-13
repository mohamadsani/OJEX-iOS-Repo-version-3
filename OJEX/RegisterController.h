//
//  RegisterController.h
//  OJEX
//
//  Created by alham fikri on 2/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *namaLengkap;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *telepon;
@property (weak, nonatomic) IBOutlet UITextField *jenisKelamin;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordKonfirmed;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *alamat;
@property (weak, nonatomic) IBOutlet UITextField *motor;

- (IBAction)submitButtonListener:(id)sender;
@end
