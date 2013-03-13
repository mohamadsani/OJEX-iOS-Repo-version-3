//
//  EditProfileController.h
//  OJEX
//
//  Created by alham fikri on 3/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *namaLengkap;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *telepon;
@property (weak, nonatomic) IBOutlet UITextField *passwordLama;
@property (weak, nonatomic) IBOutlet UITextField *jenisKelamin;
@property (weak, nonatomic) IBOutlet UITextField *passwordKonfirmed;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *alamat;
@property (weak, nonatomic) IBOutlet UITextField *motor;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *license;

- (IBAction)submitButtonListener:(id)sender;
@end
