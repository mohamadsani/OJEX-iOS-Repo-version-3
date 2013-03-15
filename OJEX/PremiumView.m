//
//  PremiumView.m
//  OJEX
//
//  Created by Mohamad Sani on 3/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "PremiumView.h"

@implementation PremiumView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setContent:(int)contentNumber {
    
    switch (contentNumber) {
        case 1:
            self.titleLabel.text = @"Jaminan Keamanan";
            self.descriptionLabel.text = @"Dengan menjadi Pengguna Premium, sejumlah poin lawan transaksi Anda akan dikunci oleh sistem sebagai jaminan untuk transaksi Anda";
            [self.imageView setImage:[UIImage imageNamed:@"premium_lock"]];
            [self.pageControl setCurrentPage:0];
            break;
        case 2:
            self.titleLabel.text = @"Meningkatkan Prestise";
            self.descriptionLabel.text = @"Sebagai Premium User yang dijamin sepenuhnya oleh OJEX, tentu meningkatkan tingkat kepercayaan Anda baik sebagai penumpang maupun pengemudi";
            [self.imageView setImage:[UIImage imageNamed:@"premium_prestige"]];
            [self.pageControl setCurrentPage:1];
            break;
        case 3:
            self.titleLabel.text = @"Fitur Premium";
            self.descriptionLabel.text = @"Sejumlah Premium Feature dapat digunakan oleh Pengguna Premium seperti Transaksi Poin dan Fitur Saring hasil pencarian";
            [self.imageView setImage:[UIImage imageNamed:@"premium_star"]];
            [self.pageControl setCurrentPage:2];
            break;
        case 4:
            self.titleLabel.text = @"Tak Berubah Nilainya";
            self.descriptionLabel.text = @"Poin digunakan sebagai transaksi merupakan sebuah universal unit of account yang nilainya selalu di-update setiap 6 jam sekali oleh sistem";
            [self.imageView setImage:[UIImage imageNamed:@"premium_diamond"]];
            [self.pageControl setCurrentPage:3];
            break;
        case 5:
            self.titleLabel.text = @"Kesempatan Hadiah";
            self.descriptionLabel.text = @"Dengan menjadi Pengguna Premium, Anda berkesempatan mendapatkan sejumlah hadiah dan undian menarik dari OJEX";
            [self.imageView setImage:[UIImage imageNamed:@"premium_present"]];
            [self.pageControl setCurrentPage:4];
            break;
        default:
            break;
    }
}

@end
