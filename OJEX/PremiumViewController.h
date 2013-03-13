//
//  PremiumViewController.h
//  OJEX
//
//  Created by Mohamad Sani on 3/12/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PremiumViewController : UIView

{
    int pageNumber;
    UILabel *titleLabel;
    UILabel *descriptionLabel;
    UIImageView *imageView;
}

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

- (id)initWithPageNumber:(int)page;

@end
