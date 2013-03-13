//
//  SearchButton.h
//  OJEX
//
//  Created by alham fikri on 1/28/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"
@interface SearchButton : UIView  <UIActionSheetDelegate>

@property (strong, nonatomic) UIViewController* wrapper;

- (IBAction)searchPressed:(id)sender;
- (IBAction)postARide:(id)sender;

@end
