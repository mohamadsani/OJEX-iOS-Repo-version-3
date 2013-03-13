//
//  OJEXDetailViewController.h
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OJEXDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
