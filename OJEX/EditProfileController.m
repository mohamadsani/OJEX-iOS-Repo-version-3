//
//  EditProfileController.m
//  OJEX
//
//  Created by alham fikri on 3/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "EditProfileController.h"
#import "Connector.h"
#import "Util.h"
#import "User.h"
#import "GlobalVar.h"

@interface EditProfileController ()

@end

@implementation EditProfileController


Connector* c;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    User* u = [[GlobalVar getInstance] user];
    
    self.alamat.text = u.profile.alamat;
    self.telepon.text = u.profile.phoneNumber;
    self.username.text = u.username;
    self.namaLengkap.text = u.name;
    self.email.text = u.email;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (bool) validate {
    if ([self.namaLengkap.text length] == 0)
    {
        [Util showMessage:@"Masukkan nama lengkap anda"];
        return false;
    }
    if ([self.telepon.text length] == 0)
    {
        [Util showMessage:@"Masukkan Nomor telepon anda"];
        return false;
    }
    if ([self.email.text length] == 0)
    {
        [Util showMessage:@"Masukkan alamat surel elektronik anda"];
        return false;
    }
    return true;
}

- (IBAction)submitButtonListener:(id)sender {
    
    if ([self validate]) {
        //submit to server
        NSString* gender = @"M";
        if ([self.jenisKelamin.text isEqualToString:@"wanita"]) gender = @"F";
        
        c = [Connector getInstance];
        
        NSLog(@"%@",[[[GlobalVar getInstance] user] userId]);
        NSLog(@"%@",gender);
        NSLog(@"%@",self.telepon.text);
        NSLog(@"%@",self.email.text);
        NSLog(@"%@",self.license.text);
        NSLog(@"%@",self.motor.text);
        
       
        NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:
                                @"userid",
                                @"name",
                                @"gender",
                                @"phoneNumber",
                                @"email",
                                @"licenseNumber",
                                @"motorDesc",
                                nil];
        NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:
                                 [NSString stringWithFormat:@"%d",[[GlobalVar getInstance] userid]],
                                 self.namaLengkap.text,
                                 gender,
                                 self.telepon.text,
                                 self.email.text,
                                 self.license.text,
                                 self.motor.text,
                                 nil];
        
        NSString* url = @"http://badr-interactive.org/ojex/index.php/profile/update";
   
        [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(EditResponse) withLoading:YES];
        
    }
    
}

- (void) EditResponse {
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:[c receivedData]
                          
                          options:kNilOptions
                          error:nil];
    
    if ([[json objectForKey:@"success"] isEqualToString:@"false"])
        [Util showErrorWithMessage:@"Error"];
    else
        [Util showMessage:@"Sukses"];
    
    //check if user want to change password?
    if ([self.passwordLama.text length] > 0) {
        NSLog(@"%@ jadi %@ = %@\n",self.passwordLama.text,self.password.text,self.passwordKonfirmed.text);
        if (![self.password.text isEqualToString:self.passwordKonfirmed.text ])
        {
            [Util showMessage:@"Password dan konfirmasi password tidak sama"];
            return;
        }
        if (![self.passwordLama.text isEqualToString:[[[GlobalVar getInstance] user] password]])
        {
            [Util showMessage:@"Password salah"];
            return;
        }
        
        NSString* url2 = @"http://badr-interactive.org/ojex/index.php/profile/changePassword";
        NSMutableArray*  key2 = [[NSMutableArray alloc] initWithObjects:
                                 @"userid",
                                 @"password",
                                 nil];
        NSMutableArray*  data2 = [[NSMutableArray alloc] initWithObjects:
                                  [NSString stringWithFormat:@"%d",[[GlobalVar getInstance] userid]],
                                  self.passwordKonfirmed.text,
                                  nil];
        
        [c HTTPPostURL:url2 withSender:self withKeys:key2 andData:data2 callWhenDone:nil withLoading:YES];
       
        [[[GlobalVar getInstance] user] setPassword:self.passwordKonfirmed.text];
    }
    
    
}
@end

