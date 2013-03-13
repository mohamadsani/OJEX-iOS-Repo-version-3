//
//  ProfileDriver.h
//  OJEX
//
//  Created by alham fikri on 1/18/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ProfileWrapperController;

@interface ProfileDriver : UIView
@property (weak, nonatomic) IBOutlet UIView *contactContainer;
- (IBAction)pickMeUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pickMeUpButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *pickMeUpButton;
@property (weak, nonatomic) IBOutlet UIView *ratingStarContainer;
@property (weak, nonatomic) IBOutlet UITableView *historyTableView;
@property (weak, nonatomic) IBOutlet UIView *historyTableContainer;
@property (weak, nonatomic) IBOutlet UIButton *commentSeeMoreButton;
@property (weak, nonatomic) IBOutlet UIView *tableContainer;
@property (strong, nonatomic) ProfileWrapperController *wrapper;
@property (weak, nonatomic) IBOutlet UIButton *historySeeMoreButton;
@property (weak, nonatomic) IBOutlet UIView *commentTableContainer;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIView *sideProfile;

- (int) getHeight;
- (void) initUI;
- (void) initHeight;
- (IBAction)imageSlideToLeft:(id)sender;
- (IBAction)secondImageSlideToLeft:(id)sender;
- (IBAction)rateAndCommentButtonListener:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *userDescription;
@property (weak, nonatomic) IBOutlet UIView *innerTableContainer;
@property (weak, nonatomic) IBOutlet UILabel *antarCountLabel;
- (IBAction)imageSlideToRight:(id)sender;
- (IBAction)secondImageSlideToRight:(id)sender;


@end
