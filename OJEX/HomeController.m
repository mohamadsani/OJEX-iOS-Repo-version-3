//
//  HomeController.m
//  OJEX
//
//  Created by alham fikri on 1/14/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "HomeController.h"
#import "HomeCellController.h"
#import "ProfileController.h"
#import "Util.h"
#import "SearchButton.h"
#import "GlobalVar.h"
#import "User.h"
#import "TimelineItem.h"
#import "Connector.h"

@interface HomeController ()

@end

UIButton *flipButton;
SearchButton* searchItem;

@implementation HomeController
@synthesize allItem;
@synthesize searchResults;
@synthesize searchDisplayController;
@synthesize searchNavigation;

NSMutableArray* timelineList;//array ini menyimpan seluruh user yang akan ditampilkan di layar...
int userCounter; //ini digunakan sebagai counter index dari userList, karena penampilan pada home screen berdasarkan jenis usernya (driver / passanger) sementara userList menyimpan seluruh tipe user, maka diperlukan sebuah counter tersendiri untuk melakukan loop dan memilih user yang sesuai untuk ditampilkan

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) refreshTimeline {
    Connector* c = [Connector getInstance];
    
    NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects:@"userid", nil];
    NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",[[GlobalVar getInstance] userid]],nil];
    
    NSString* url = @"http://badr-interactive.org/ojex/index.php/timeline";
    
    [c HTTPPostURL:url withSender:self withKeys:key andData:data callWhenDone:@selector(getTimelineResponse) withLoading:YES];
    
}

- (void) getTimelineResponse
{
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:[[Connector getInstance] receivedData]
                          
                          options:kNilOptions
                          error:nil];
    
    NSArray* timeline = [json objectForKey:@"timeline"];
    
    //inisialisasi timelineList
    timelineList = [[NSMutableArray alloc] init];
    
    //pecah timeline ke array
    for (int i=0;i<[timeline count];i++) {
        TimelineItem* tl = [[TimelineItem alloc] init];
        
        [tl createDataWithJSON:[timeline objectAtIndex:i]]; //membuat timelineItem dari JSON
        
        [timelineList addObject:tl]; //menambah objek timeline ke array
    }
    
    NSLog(@"A data masuk %d\n",[timelineList count]);
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    allItem = [[NSMutableArray alloc] init];
    searchResults = [[NSArray alloc] init];
    
    //insert dummy auto-complete text
    //REMOVE THIS WHEN ACTUAL DATA IS AVAILABLE
    //================
    [allItem addObject:@"Spanyol"];
    [allItem addObject:@"Al-hidayah depok"];
    [allItem addObject:@"Universitas Indonesia"];
    [allItem addObject:@"Hatimu <3"];
    [allItem addObject:@"mana aja boleeehh"];    
    
    //set up navigation bar
    searchItem = (SearchButton*) [[[NSBundle mainBundle] loadNibNamed:@"SearchButton" owner:self options:nil] objectAtIndex:0];
    searchItem.wrapper = self;

    [self.searchNavigation addSubview: searchItem];
    // self.navigationItem.rightBarButtonItem = searchItem;
    
    [self refreshTimeline];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //otomatis screen naik ketika user ingin mengetik lokasi tujuan..., supaya keren dan spacenya lebih luas
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(adjustFrame:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(adjustFrame:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //dismiss listener untuk screen yang otomatis naik
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //inisaialisasi
    userCounter = 0;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [searchResults count];
    
    //calculate the number of user with Driver status
    int ct = 0;
    for (int i=0;i<[timelineList count];i++){
        TimelineItem* tl = [timelineList objectAtIndex:i];
        
        if ([[tl user] status] == UserDriver) ct++;
    }
    
    if (self.homeSegmentControl.selectedSegmentIndex == 0) //selecting driver
    {
        return ct;
    }
    if (self.homeSegmentControl.selectedSegmentIndex == 1) //selecting passanger
    {
        return [timelineList count] - ct;
    }
    
    return  [timelineList count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return 45;
    
    return 71;
}  


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellForHome";
    
    //kalau sedang search, maka cell viewnya adalah hasil search
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellForSearch"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }

        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
        return cell;
    }
    
    //jika tidak, maka cell viewnya adalah timeline dia ]
    HomeCellController *cell = (HomeCellController*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
        cell = (HomeCellController *)[nib objectAtIndex:0];
    }
    
    if (self.homeSegmentControl.selectedSegmentIndex == 0) //driver
        cell.tl = [self findUserWithNumber:indexPath.row withStatus:0];
    
    if (self.homeSegmentControl.selectedSegmentIndex == 1) //passanger
        cell.tl = [self findUserWithNumber:indexPath.row withStatus:1];
    
    if (self.homeSegmentControl.selectedSegmentIndex == 2) //all
        cell.tl = [self findUserWithNumber:indexPath.row withStatus:2];
    
    [cell reload]; //reload interface
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        [self performSegueWithIdentifier:@"HomeToSearch" sender:self];    
    else
    {
        
        
        
        
        GlobalVar* g = [GlobalVar getInstance];
  
        
        if (self.homeSegmentControl.selectedSegmentIndex == 0) //driver
            g.userProfile = [[self findUserWithNumber:indexPath.row withStatus:0] user];
        
        if (self.homeSegmentControl.selectedSegmentIndex == 1) //passanger
            g.userProfile = [[self findUserWithNumber:indexPath.row withStatus:1] user];
        
        if (self.homeSegmentControl.selectedSegmentIndex == 2) //all
            g.userProfile = [[self findUserWithNumber:indexPath.row withStatus:2] user];
        //go to profile when cell is clicked
        [self performSegueWithIdentifier:@"HomeToProfile" sender:self];
    }
}



//====================
//kode dibawah ini sudah fix dan bersifat mengatur sistem, seperti autocomplete, dll. JANGAN dimodifikasi kecuali memang perlu
//====================



#pragma mark auto-complete

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [allItem filteredArrayUsingPredicate:resultPredicate];
    NSLog(@"%d",[searchResults count]);
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
   //ProfileController *destination = [segue destinationViewController];
    
    //for parsing data
}

-(IBAction)returnedFromProfile:(UIStoryboardSegue *)segue {
    
}

-(IBAction)returnedFromSearch:(UIStoryboardSegue *)segue {

}

- (void)adjustFrame:(NSNotification *) notification {
    if ([[notification name] isEqual:UIKeyboardWillHideNotification]) {
        //[Util slideFrame:self toUp:NO];
        [searchItem setHidden:NO];
        if (flipButton != nil)
            [flipButton setHidden:YES];
    }
    else  {
        //[Util slideFrame:self toUp:YES];
        
        if (flipButton == nil){
            flipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [flipButton addTarget:self
                       action:@selector(searchNearby)
             forControlEvents:UIControlEventTouchDown];
            [flipButton setTitle:@"Cari" forState:UIControlStateNormal];
            flipButton.frame = CGRectMake(0.0, 6.0, 60.0, 30.0);
           // [view addSubview:button];
            [self.searchNavigation addSubview:flipButton];
        }
        
        //self.navigationItem.rightBarButtonItem = flipButton;
        [flipButton setHidden:NO];
        [searchItem setHidden:YES];

    }
}

- (void) searchNearby{
    [self performSegueWithIdentifier:@"HomeToSearch" sender:self];
    
}

- (IBAction)homeSegmentControlListener:(id)sender {
    [self.tableView reloadData];
    NSLog(@"%d",self.homeSegmentControl.selectedSegmentIndex);
}

UITextField* selected;

- (IBAction)editStartTime:(id)sender {
    
    selected = self.fromDateField;
    [self callDP:self];
}

- (IBAction)editEndTime:(id)sender {
    selected = self.toDateField;
    [self callDP:self];
}

UIDatePicker* datePickerView;
- (void)callDP:(id)sender {
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"Set time" delegate:self cancelButtonTitle:@"Clear" destructiveButtonTitle:nil otherButtonTitles:@"set", nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 170, 0, 0);
    
    
    datePickerView = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    datePickerView.tag = 10;
    datePickerView.datePickerMode = UIDatePickerModeTime;
    
    [datePickerView addTarget:self action:nil forControlEvents:UIControlEventValueChanged];
    
    [actionSheet addSubview:datePickerView];
    
    //[actionSheet showInView:self.view];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 585)];
}

//action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.view endEditing:YES];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    if (buttonIndex == 0)
        selected.text = [formatter stringFromDate:datePickerView.date];
    if (buttonIndex == 1)
         selected.text = @"";
}


#pragma mark private Algorithm

//mencari user ke-N yang memiliki tipe tertentu (driver/passanger) di semua list user yang ada
//kelihatannya rumit, tapi ini cuman algo sederhana untuk memisahkan mana yang driver dan mana yang passanger di uesrList

- (TimelineItem*) findUserWithNumber:(int) n withStatus:(int) status
{
    int needed = n;
    userCounter = 0;
    
  
    //start of algorithm
    //=======
   
    if (status == 0) //mencari user dengan jenis Driver
    {
        NSLog(@"cari %d",status);
        while (needed >= 0){
            while (userCounter + 1 < [timelineList count] && [[(TimelineItem*)[timelineList objectAtIndex:userCounter] user] status] != UserDriver) userCounter++;
            if (needed > 0)
                userCounter++;
            needed--;
        }
    }
    else
        if (status == 1) //mencari user dengan jenis Passanger
        {
             NSLog(@"cari %d",status);
            while (needed >= 0){
                while (userCounter + 1 < [timelineList count] && [[(TimelineItem*)[timelineList objectAtIndex:userCounter] user] status] != UserPassanger) userCounter++;
                if (needed > 0)
                    userCounter++;
                needed--;
            }
        }
        else //global (all)
            userCounter = needed;
    //end of algorithm
    //=====
    
    return (TimelineItem*)[timelineList objectAtIndex:userCounter];
}

- (IBAction)fromMapButtonListener:(id)sender {
    
    //open map picker to select location
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone"
                                                         bundle: nil];
    
    //opening my profile
    UINavigationController *myNewVC =  [storyboard instantiateViewControllerWithIdentifier:@"MapNavigation"];
    
    [self presentViewController:myNewVC animated:YES completion:NULL];
}
@end
