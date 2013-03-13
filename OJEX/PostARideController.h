//
//  PostARideController.h
//  OJEX
//
//  Created by alham fikri on 2/8/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostARideController : UITableViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIButton *kamuInginTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
- (IBAction)timeStartEdit:(id)sender;
- (IBAction)backButtonListener:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *formLocationField;
- (IBAction)priceOnEditing:(id)sender;
- (IBAction)kamuInginListener:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *toLocationField;
@property (weak, nonatomic) IBOutlet UITextField *viaLocationField;
- (IBAction)initializeTrip:(id)sender;


@end
