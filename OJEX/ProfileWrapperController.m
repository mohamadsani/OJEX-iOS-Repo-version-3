//
//  ProfileWrapperController.m
//  OJEX
//
//  Created by alham fikri on 1/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "ProfileWrapperController.h"
#import "ProfileController.h"
#import "ProfileDriver.h"
#import "HistoryAndCommentController.h"
#import "SearchButton.h"

@interface ProfileWrapperController ()

@end

@implementation ProfileWrapperController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //set the scroll view
    self.scrollView.scrollEnabled = YES;
    
    //load seperate XIB file to inserted to main view because there are three different view for profile UI
    
    ProfileDriver *profileView = (ProfileDriver*) [[[NSBundle mainBundle] loadNibNamed:@"ProfileDriver" owner:self options:nil] objectAtIndex:0];
    profileView.wrapper = self;
   [profileView initUI];
    
    [self.scrollView addSubview:profileView];
    
    [profileView initHeight];
    [profileView.commentTableView reloadData];
    [profileView initHeight];
    [profileView.historyTableView reloadData];
    
    //set up navigation bar
    SearchButton* searchItem = (SearchButton*) [[[NSBundle mainBundle] loadNibNamed:@"SearchButton" owner:self options:nil] objectAtIndex:0];
    searchItem.wrapper = self;
    
    [self.searchNavigation addSubview: searchItem];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ProfileToHistory"])
        [[segue destinationViewController] setMode:@"History"];
    else if ([[segue identifier] isEqualToString:@"ProfileToComment"])
        [[segue destinationViewController] setMode:@"Comment"];
}


@end
