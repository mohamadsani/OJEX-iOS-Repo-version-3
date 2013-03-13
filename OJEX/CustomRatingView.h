//
//  CustomRatingView.h
//  OJEX
//
//  Created by alham fikri on 1/28/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomRatingView : UIView

@property float rate;

@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;

- (void) updateRate:(float)x;
- (void) kenapa;
@end
