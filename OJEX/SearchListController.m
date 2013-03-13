//
//  SearchListController.m
//  OJEX
//
//  Created by alham fikri on 1/21/13.
//  Copyright (c) 2013 Badr Interactive. All rights reserved.
//

#import "SearchListController.h"
#import "HomeCellController.h"
#import "Connector.h"
#import "TimelineItem.h"

@interface SearchListController ()

@end

@implementation SearchListController

NSMutableArray* timelineList;//array ini menyimpan seluruh user yang akan ditampilkan di layar...


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    timelineList = [[NSMutableArray alloc] init];
    
    Connector* c = [Connector getInstance];
    
    NSMutableArray*  key = [[NSMutableArray alloc] initWithObjects: nil];
    NSMutableArray*  data = [[NSMutableArray alloc] initWithObjects:nil];
    
    [c HTTPPostURL:@"http://badr-interactive.org/ojex/index.php/timeline/search"
        withSender:self withKeys:key andData:data callWhenDone:@selector(searchResponse) withLoading:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) searchResponse {

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
    
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (timelineList == nil) return 0;
    return [timelineList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellForHome";
    
    HomeCellController *cell = (HomeCellController*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
        cell = (HomeCellController *)[nib objectAtIndex:0];
    }
    
    cell.tl = [timelineList objectAtIndex:indexPath.row];
    
    [cell reload]; //reload interface
    return cell;


}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end


