//
//  ProfileDriver.m
//  OJEX
//
//  Created by alham fikri on 1/18/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "ProfileDriver.h"
#import "HistoryCellController.h"
#import "CommentCellController.h"
#import "ProfileWrapperController.h"
#import "CustomRatingView.h"
#import "GlobalVar.h"
#import "QuartzCore/QuartzCore.h"
#import "Connector.h"

@implementation ProfileDriver

Connector* c;
int height = 0;
int firstTableHeight = 0;
int secondTableHeight = 0;
NSString* firstImageName = @"images.jpeg";
NSString* secondImageName = @"topan.jpg";
int imageShowed = 0;

- (id) init {
    self = [super init];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

//inisialisasi awal UI, atur rating, dan beberapa menu
- (void) initUI
{
    imageShowed = 0;
    self.sideProfile.layer.zPosition = 100;
    CustomRatingView* userRating = (CustomRatingView*) [[[NSBundle mainBundle] loadNibNamed:@"CustomRatingView" owner:self options:nil] objectAtIndex:0];
    
    [userRating updateRate:4.5];
    
    [self.ratingStarContainer addSubview:userRating];
    
    //ambil rate & comment dari user ini:
    NSString* url = @"http://badr-interactive.org/ojex/index.php/rating";
    
    NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:
                            @"providerid",
                            nil];
    NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:
                             [NSString stringWithFormat:@"%@",[[[GlobalVar getInstance] userProfile] userId]],
                             nil];
    
    c = [Connector getInstance];
    [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(GetCommentResponse) withLoading:NO];
    
}

-(void) GetCommentResponse {

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.historyTableView){
        return 3;
    }
    else{
        return 3;//comment cell have different height
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.historyTableView){
        firstTableHeight += 70; //history table cell have fixed size
        return 70; //history cell have fixed height
    }
    else{
        secondTableHeight += 120;
        return 120; //comment cell have different height
    }
}


- (void) UIUpdate {
    
    //below code will updates the UI of profile, such as name, image, etc. User object will using User object at <GlobalVar userProfile> variable.
    GlobalVar* g = [GlobalVar getInstance];
    User* u = g.userProfile; //get the profile
    
    [self.secondImageView setImage:u.avatar];
    if (u.avatar == nil)
        [self.secondImageView setImage:[UIImage imageNamed:@"ic_blank_avatar.gif"]];
    
    [self.firstImageView setImage:u.profile.motorImage];
    if (u.profile.motorImage == nil)
        [self.firstImageView setImage:[UIImage imageNamed:@"ic_blank_bike.png"]];
    
    [self.profileNameLabel setText:u.name];
    [self.antarCountLabel setText:[NSString stringWithFormat:@"%d",u.profile.deliver]];
    
    [self.userDescription setText:u.profile.bio];
    
    int updateHeight = self.userDescription.frame.size.height;
    
    //adjust the height of biography
    CGRect frame = self.userDescription.frame;
    frame.size.height = self.userDescription.contentSize.height;
    self.userDescription.frame = frame;
    
    updateHeight -= self.userDescription.frame.size.height;
    updateHeight *= -1;
    
    //shift down table
    self.innerTableContainer.frame = CGRectOffset(self.innerTableContainer.frame, 0, updateHeight);
    self.frame = CGRectMake(0,0,320, self.frame.size.height +   updateHeight);
    
    //updates UI with its status (driver? or passanger)
    if (u.status == UserPassanger){
    
    }
    else {
        //hapus tombol pick me up, naikkan tampilan di bawahnya 10 pixel
        [self.pickMeUpButtonContainer setHidden:YES];
        self.tableContainer.frame = CGRectOffset(self.tableContainer.frame, 0, -10);
        self.frame = CGRectMake(0,0,320, self.frame.size.height - 10);
        
        if (u.status == UserSelf) {
            //hapus tombol rate, call, dan sms, naikkan tampilan di bawahnya 12 pixel;
            [self.contactContainer setHidden:YES];
            self.tableContainer.frame = CGRectOffset(self.tableContainer.frame, 0, -12);
            self.frame = CGRectMake(0,0,320, self.frame.size.height - 12);
        }
    }
    
    //below code will updates the height of UI because of different table height of comments
    //first tableView height modify
    
    double masterViewHeight = self.frame.size.height;
    double increase = 0;
    
    CGRect aFrame = self.historyTableContainer.frame;
    increase += (firstTableHeight - self.historyTableContainer.frame.size.height);
    
    aFrame.size.width = 320;
    aFrame.size.height = firstTableHeight;
    self.historyTableContainer.frame = aFrame;
    
    //shift down second tableView Y-coordinate position
    self.commentTableContainer.frame = CGRectOffset(self.commentTableContainer.frame, 0, increase);
    
    //shift down comment label container
    self.commentLabel.frame = CGRectOffset(self.commentLabel.frame, 0, increase);
    
    //shift down see-more button of history
    self.historySeeMoreButton.frame = CGRectOffset(self.historySeeMoreButton.frame, 0, increase);
   
    //second tableView height modify
    CGRect dFrame = self.commentTableContainer.frame;
    increase += (secondTableHeight - self.commentTableContainer.frame.size.height);
    
    dFrame.size.width = 320;
    dFrame.size.height = secondTableHeight;
    self.commentTableContainer.frame = dFrame;
    
    //shift down see-more button of comment
    self.commentSeeMoreButton.frame = CGRectOffset(self.commentSeeMoreButton.frame, 0, increase);
    
    CGRect eFrame = self.tableContainer.frame;
    
    eFrame.size.height += increase;
    self.tableContainer.frame = eFrame;
    
    
    self.frame = CGRectMake(0,0,320,masterViewHeight + increase);
    height = masterViewHeight + increase;
    
    [self.wrapper.scrollView setContentSize:CGSizeMake(320, [self getHeight])];
   
}

//cell configuration
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cells";
    
    NSLog(@"cell load %d",indexPath.row);
    
    //konfigurasi untuk tabel aktivitas
    if(tableView == self.historyTableView){
        
        
        HistoryCellController *cell = (HistoryCellController*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self options:nil];
            cell = (HistoryCellController *)[nib objectAtIndex:0];
        }
        
        [self UIUpdate];
        return cell;
    }
    //konfigurasi untuk tabel komentar
    else {
        
        CommentCellController *cell = (CommentCellController*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
            cell = (CommentCellController *)[nib objectAtIndex:0];
        }
        
        //embed rating sebagai subview dari tabel komentar
         CustomRatingView* userRating = (CustomRatingView*) [[[NSBundle mainBundle] loadNibNamed:@"CustomRatingView" owner:self options:nil] objectAtIndex:0];
        
        [cell.ratingStarContainer addSubview:userRating];
        [userRating updateRate:1.0 + indexPath.row ];
        [self UIUpdate];
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



- (int) getHeight {
    return height;
}

- (void) initHeight{
    height = 0;
    firstTableHeight = 0;
    secondTableHeight = 0;
}


- (void) slideImageToLeft {
    if (imageShowed == 1) {
        imageShowed = 0;
        
        //first tableView height modify
        CGRect aFrame = self.secondImageView.frame;
        aFrame.origin.x = 168;
        self.secondImageView.frame = aFrame;
        
        const float movementDuration = 0.5f;
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: NO];
        [UIView setAnimationDuration: movementDuration];
        
        self.secondImageView.frame = CGRectOffset(self.secondImageView.frame,  -168,0);
        self.firstImageView.frame = CGRectOffset(self.firstImageView.frame,  -168,0);
        
        [UIView commitAnimations];
    }
    else
        if (imageShowed == 0) {
            imageShowed = 1;
            
            //first tableView height modify
            CGRect aFrame = self.firstImageView.frame;
            aFrame.origin.x = 168;
            self.firstImageView.frame = aFrame;
            
            const float movementDuration = 0.5f;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: NO];
            [UIView setAnimationDuration: movementDuration];
            
            self.secondImageView.frame = CGRectOffset(self.secondImageView.frame, -168,0);
            self.firstImageView.frame = CGRectOffset(self.firstImageView.frame,-168,0);
            
            [UIView commitAnimations];
        }
}


- (void) slideImageToRight {
    if (imageShowed == 1) {
        imageShowed = 0;
        
        //first tableView height modify
        CGRect aFrame = self.secondImageView.frame;
        aFrame.origin.x = -168;
        self.secondImageView.frame = aFrame;
        
        const float movementDuration = 0.5f;
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: NO];
        [UIView setAnimationDuration: movementDuration];
        
        self.secondImageView.frame = CGRectOffset(self.secondImageView.frame,  168,0);
        self.firstImageView.frame = CGRectOffset(self.firstImageView.frame,  168,0);
        
        [UIView commitAnimations];
    }
    else
        if (imageShowed == 0) {
            imageShowed = 1;
            
            //first tableView height modify
            CGRect aFrame = self.firstImageView.frame;
            aFrame.origin.x = -168;
            self.firstImageView.frame = aFrame;
            
            const float movementDuration = 0.5f;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: NO];
            [UIView setAnimationDuration: movementDuration];
            
            self.secondImageView.frame = CGRectOffset(self.secondImageView.frame, 168,0);
            self.firstImageView.frame = CGRectOffset(self.firstImageView.frame,168,0);
            
            [UIView commitAnimations];
        }
}



- (IBAction)imageSlideToLeft:(id)sender {
    [self slideImageToLeft];
}

- (IBAction)secondImageSlideToLeft:(id)sender {
    [self slideImageToLeft];
}

- (IBAction)rateAndCommentButtonListener:(id)sender {
    UIAlertView *rateAlert = [[UIAlertView alloc] initWithTitle:@"" message:nil delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",nil];
    UIView* addComment= (UIView*) [[[NSBundle mainBundle] loadNibNamed:@"AddComment" owner:self options:nil] objectAtIndex:0];
    
    UITextField* myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    
    //[rateAlert addSubview:myTextField];
    [rateAlert addSubview:addComment];
    rateAlert.title = @"Add Comment";
    [rateAlert show];
    //rateAlert.frame = CGRectMake(0,0,300,250);
    

}

- (IBAction)seeMoreHistory:(id)sender {
    [self.wrapper performSegueWithIdentifier:@"ProfileToHistory" sender:self];

}

- (IBAction)seeMoreComment:(id)sender {
    [self.wrapper performSegueWithIdentifier:@"ProfileToComment" sender:self];
}

- (IBAction)pickMeUp:(id)sender {
    [self.wrapper performSegueWithIdentifier:@"ProfileToPembayaran" sender:self];
}

- (IBAction)imageSlideToRight:(id)sender {
      [self slideImageToRight];
}

- (IBAction)secondImageSlideToRight:(id)sender {
      [self slideImageToRight];
}

@end
