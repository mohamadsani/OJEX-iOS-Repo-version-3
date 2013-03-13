//
//  PostARideController.m
//  OJEX
//
//  Created by alham fikri on 2/8/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "PostARideController.h"
#import "Util.h"
#import "Connector.h"
#import "GlobalVar.h"

@interface PostARideController ()

@end

@implementation PostARideController

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



- (IBAction)timeStartEdit:(id)sender {
    [self callDP:self];
}

- (IBAction)backButtonListener:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)priceOnEditing:(id)sender {
    self.pointLabel.text = [NSString stringWithFormat:@"%.1f",[Util rupiahToPoint:[self.priceTextField.text floatValue]]];
}

- (IBAction)kamuInginListener:(id)sender {
    if ([self.kamuInginTextField.titleLabel.text isEqualToString:@"beri tumpangan"])
        [self.kamuInginTextField setTitle:@"menumpang" forState:UIControlStateNormal];
    else
        [self.kamuInginTextField setTitle:@"beri tumpangan" forState:UIControlStateNormal];    
    [self refreshControl];
    
}

UIDatePicker* datePickerView;
- (void)callDP:(id)sender {
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Set time" delegate:self cancelButtonTitle:@"Clear" destructiveButtonTitle:nil otherButtonTitles:@"set", nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 170, 0, 0);
    
    
    datePickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    datePickerView.tag = 10;
    
    [datePickerView addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:datePickerView];
    
    //[actionSheet showInView:self.view];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 585)];
}

//action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [self.view endEditing:YES];
    [formatter setDateFormat:@"yyyy-mm-dd HH:mm"];
    
    if (buttonIndex == 0)
        self.timeTextField.text = [formatter stringFromDate:datePickerView.date];
    if (buttonIndex == 1)
        self.timeTextField.text = @"";
}

- (IBAction)initializeTrip:(id)sender {
    NSString* url = @"http://badr-interactive.org/ojex/index.php/trip";
    NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:
                            @"userid",
                            @"status",
                            @"source_label",
                          //  @"source_latitude",
                          // @"source_longitude",
                            @"destination_label",
                            @"via",
                            @"departTime",
                            @"priceInRupiah",
                            @"priceInPoint",
                            @"notes",
                            nil];
    NSString* status = @"P";
    if ([self.kamuInginTextField.titleLabel.text isEqualToString:@"menumpang"])
        status = @"U";

    NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:
                             [NSString stringWithFormat:@"%d",[[GlobalVar getInstance] userid]],
                             status,
                             self.formLocationField.text,
                            // source lat,
                            // source long,
                             self.toLocationField.text,
                             self.viaLocationField.text,
                             self.timeTextField.text,
                             self.priceTextField.text,
                             self.pointLabel.text,
                             self.notesTextField.text,
                             nil];
    
    c = [Connector getInstance];
    [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(AddTripResponse) withLoading:YES];
    
    
}

- (void) AddTripResponse {
    
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
