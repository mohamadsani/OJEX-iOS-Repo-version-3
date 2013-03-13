//
//  SearchWrapperController.m
//  OJEX
//
//  Created by alham fikri on 1/21/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "SearchWrapperController.h"
#import "HistoryAndCommentController.h"
#import "Util.h"


@interface SearchWrapperController ()

@end

@implementation SearchWrapperController
@synthesize searchDisplayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) createSearchBar {

    UISearchBar* searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(70,0,200,
                                                                            44)];
                        
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    self.searchDisplayController.searchResultsDelegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.delegate = self;
    
    [self.navigationController.navigationBar addSubview:searchBar];
                              
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //add search bar in navigation
    [self createSearchBar];
    
    
    //dismiss listener untuk screen yang otomatis naik
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    
}

- (void)adjustFrame:(NSNotification *) notification {
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [controller.searchResultsTableView setDelegate:self];
    CGFloat gr = 12.0;
    controller.searchResultsTableView.backgroundColor = [UIColor colorWithRed:gr green:gr blue:gr alpha:0.0];
    [controller.searchResultsTableView setSeparatorStyle:UITableViewCellSelectionStyleNone];
    CGRect searchTableFrame = CGRectMake(7, 105, 305, 292);
    [controller.searchResultsTableView setFrame:searchTableFrame];
}

@end
