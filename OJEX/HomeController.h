//
//  HomeController.h
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController<UIActionSheetDelegate,UITableViewDelegate, UITableViewDataSource> {
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *allItem;
    NSArray *searchResults;
    
}
- (IBAction)homeSegmentControlListener:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *homeSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *searchNavigation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (nonatomic, copy) NSArray *searchResults;
@property (nonatomic, copy) NSMutableArray *allItem;
- (IBAction)editStartTime:(id)sender;
- (IBAction)editEndTime:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *fromDateField;
@property (weak, nonatomic) IBOutlet UITextField *toDateField;
- (IBAction)fromMapButtonListener:(id)sender;

@end
