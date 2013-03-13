//
//  HomeCellController.m
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "HomeCellController.h"

@implementation HomeCellController

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) reload
{
    User* user = [self.tl user];
    [self.avatar setImage:user.avatar];
    self.nameLabel.text = user.name;
    self.sourceAndDestinationLabel.text = [NSString stringWithFormat:@"%@ -> %@",user.source, user.destination];
    
    self.viaLabel.text = self.tl.via;
   
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    self.timeStampLabel.text = [formatter stringFromDate:self.tl.timestamp];
    self.priceLabel.text = [NSString stringWithFormat:@"%d Rb",(self.tl.priceInRupiah/1000)];
    
}

@end
