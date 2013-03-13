//
//  SearchWrapperController.h
//  OJEX
//
//  Created by alham fikri on 1/21/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchWrapperController : UITabBarController<UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UISearchDisplayController *searchDisplayController;

@end
