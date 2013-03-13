//
//  CustomRatingView.m
//  OJEX
//
//  Created by alham fikri on 1/28/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "CustomRatingView.h"

@implementation CustomRatingView
@synthesize rate;

NSString* emptyStarImg = @"ic_rating_not_important.png";
NSString* fullStarImg = @"ic_rating_important.png";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) updateRate:(float)x
{
    
    NSLog(@"hoy");
    rate = x;
    NSLog(@"berhasil dipanggil");
    
    [self.star1 setImage:[UIImage imageNamed:emptyStarImg]];
    [self.star2 setImage:[UIImage imageNamed:emptyStarImg]];
    [self.star3 setImage:[UIImage imageNamed:emptyStarImg]];
    [self.star4 setImage:[UIImage imageNamed:emptyStarImg]];
    [self.star5 setImage:[UIImage imageNamed:emptyStarImg]];
    
    if (rate >= 1.0) [self.star1 setImage:[UIImage imageNamed:fullStarImg]];
    if (rate >= 2.0) [self.star2 setImage:[UIImage imageNamed:fullStarImg]];
    if (rate >= 3.0) [self.star3 setImage:[UIImage imageNamed:fullStarImg]];
    if (rate >= 4.0) [self.star4 setImage:[UIImage imageNamed:fullStarImg]];
    if (rate >= 5.0) [self.star5 setImage:[UIImage imageNamed:fullStarImg]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) kenapa{
    NSLog(@"gapapa");
}

@end
