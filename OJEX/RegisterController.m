//
//  RegisterController.m
//  OJEX
//
//  Created by alham fikri on 2/6/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "RegisterController.h"
#import "Connector.h"
#import "Util.h"


@interface RegisterController ()

@end

@implementation RegisterController

Connector* c;

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

- (bool) validate {
    if ([self.namaLengkap.text length] == 0)
    {
        [Util showMessage:@"Masukkan nama lengkap anda"];
        return false;
    }
    if ([self.username.text length] == 0)
    {
        [Util showMessage:@"Masukkan username anda"];
        return false;
    }if ([self.telepon.text length] == 0)
    {
        [Util showMessage:@"Masukkan Nomor telepon anda"];
        return false;
    }if ([self.password.text length] == 0)
    {
        [Util showMessage:@"Masukkan password anda"];
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
        
        NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:
                                @"username",
                                @"name",
                                @"password",
                                @"gender",
                                @"phoneNumber",
                                @"email",
                                nil];
        NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:
                                 self.username.text,
                                 self.namaLengkap.text,
                                 self.password.text,
                                 gender,
                                 self.telepon.text,
                                 self.email.text,
                                 nil];
        
        
        
        NSString* url = @"http://badr-interactive.org/ojex/index.php/register";
        
        [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(RegisterResponse) withLoading:YES];
    
    }
            
}

- (void) RegisterResponse {
    
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:[c receivedData]
                          
                          options:kNilOptions
                          error:nil];
    
    
    if ([[json objectForKey:@"success"] isEqualToString:@"false"])
        [Util showErrorWithMessage:@"Error"];
    else
        [Util showMessage:@"Sukses"];
    

 }
@end
