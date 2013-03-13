//
//  HomeCellController.h
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TimelineItem.h"

@interface HomeCellController : UITableViewCell
@property TimelineItem* tl;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *sourceAndDestinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UIView *statusIcon;
@property (weak, nonatomic) IBOutlet UILabel *viaLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void) reload;
@end
