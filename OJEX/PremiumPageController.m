//
//  PremiumPageController.m
//  OJEX
//
//  Created by Mohamad Sani on 3/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "PremiumPageController.h"

@interface PremiumPageController ()

@end

@implementation PremiumPageController
@synthesize modelArray;

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
	
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
    
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    UIView *vc = (UIView*) [[[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil] objectAtIndex:0];
    UIViewController* uivc = [[UIViewController alloc] init];
    
    [uivc setView:vc];
    UIView *vc2 = (UIView*) [[[NSBundle mainBundle] loadNibNamed:@"SearchButton" owner:self options:nil] objectAtIndex:0];
    UIViewController* uivc2 = [[UIViewController alloc] init];
    [uivc2 setView:vc2];
    [vcs addObject:uivc];
    [vcs addObject:uivc2];
    
    //tambahkan view lainnya seperti diatas
    
    
    //jangan otak atik dibawah sini
    
    NSMutableArray *vcsinit = [[NSMutableArray alloc] init];
    [vcsinit addObject:uivc];
    self.modelArray = vcs;
    
    //set delegate and datasource protocols
    self.dataSource = self;
    self.delegate = self;
    
    
    [self setViewControllers:vcsinit direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIPageViewControllerDataSource Methods

// Returns the view controller before the given view controller. (required)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
  //  return nil;
  
        NSUInteger currentIndex = [self.modelArray indexOfObject:viewController];
       if(currentIndex == 0)
           return nil;
    
        UIViewController *cVC = [self.modelArray objectAtIndex:currentIndex - 1];
        return cVC;
}

// Returns the view controller after the given view controller. (required)
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
//    return nil;
//  
       NSUInteger currentIndex = [self.modelArray indexOfObject:viewController];
     if(currentIndex == self.modelArray.count - 1)
          return nil;
    
     UIViewController *cVC = [self.modelArray objectAtIndex:currentIndex + 1];
       return cVC;
}

@end
