//
//  PremiumViewController.m
//  OJEX
//
//  Created by Mohamad Sani on 3/12/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "PremiumViewController.h"

@interface PremiumViewController ()

@end

@implementation PremiumViewController

@synthesize titleLabel, descriptionLabel, imageView;

- (void)viewDidLoad
{
    titleLabel.text = @"taruh stringnya di sini";
    descriptionLabel.text = @"taruh stringnya di sini";
//    imageView.image = ;
}

// load the view nib and initialize the pageNumber ivar
- (id)initWithPageNumber:(int)page
{
//    if (self = [super initWithNibName:@"PremiumViewController" bundle:nil])
    {
        pageNumber = page;
    }
    return self;
}

//- (void)dealloc
//{
//    [titleLabel release];
//    [descriptionLabel release];
//    [imageView release];
//    [super dealloc];
//}

@end
