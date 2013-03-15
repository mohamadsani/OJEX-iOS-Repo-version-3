//
//  PremiumPageController.m
//  OJEX
//
//  Created by Mohamad Sani on 3/15/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "PremiumPageController.h"
#import "PremiumView.h"

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
	
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    
    PremiumView *v1 = (PremiumView*) [[[NSBundle mainBundle] loadNibNamed:@"PremiumView" owner:self options:nil] objectAtIndex:0];
    [v1 setContent:1];
    UIViewController* vc1 = [[UIViewController alloc] init];
    [vc1 setView:v1];
    [vcs addObject:vc1];
    
    PremiumView *v2 = (PremiumView*) [[[NSBundle mainBundle] loadNibNamed:@"PremiumView" owner:self options:nil] objectAtIndex:0];
    [v2 setContent:2];
    UIViewController* vc2 = [[UIViewController alloc] init];
    [vc2 setView:v2];
    [vcs addObject:vc2];
    
    PremiumView *v3 = (PremiumView*) [[[NSBundle mainBundle] loadNibNamed:@"PremiumView" owner:self options:nil] objectAtIndex:0];
    [v3 setContent:3];
    UIViewController* vc3 = [[UIViewController alloc] init];
    [vc3 setView:v3];
    [vcs addObject:vc3];
    
    PremiumView *v4 = (PremiumView*) [[[NSBundle mainBundle] loadNibNamed:@"PremiumView" owner:self options:nil] objectAtIndex:0];
    [v4 setContent:4];
    UIViewController* vc4 = [[UIViewController alloc] init];
    [vc4 setView:v4];
    [vcs addObject:vc4];
    
    PremiumView *v5 = (PremiumView*) [[[NSBundle mainBundle] loadNibNamed:@"PremiumView" owner:self options:nil] objectAtIndex:0];
    [v5 setContent:5];
    UIViewController* vc5 = [[UIViewController alloc] init];
    [vc5 setView:v5];
    [vcs addObject:vc5];
    
    
    //jangan otak atik dibawah sini
    
    NSMutableArray *vcsinit = [[NSMutableArray alloc] init];
    [vcsinit addObject:vc1];
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

- (IBAction)goPremium:(id)sender {
}
@end
