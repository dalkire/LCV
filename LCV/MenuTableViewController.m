//
//  MenuTableViewController.m
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import "MenuTableViewController.h"


@implementation MenuTableViewController

@synthesize delegate    = _delegate;
@synthesize sections    = _sections;
@synthesize accounts    = _accounts;
@synthesize preferences = _preferences;
@synthesize about       = _about;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _accounts = [[NSMutableArray alloc] initWithObjects:@"ICC", @"FICS", nil];
        _preferences = [[NSMutableArray alloc] initWithObjects:@"Pieces", @"Board", nil];
        _about = [[NSMutableArray alloc] initWithObjects:@"Help", @"About", @"Donate", nil];
        _sections = [[NSMutableArray alloc] initWithObjects:_accounts, _preferences, _about, nil];
        
        [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
        
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-red.png"]];
        [bg setContentMode:UIViewContentModeCenter];
        [self.tableView setBackgroundView:bg];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                               target:self 
                               action:@selector(didTouchDone)];
    
    self.navigationItem.rightBarButtonItem = doneBtn;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [_accounts count];
    }
    else if (section == 1) {
        return [_preferences count];
    }
    else if (section == 2) {
        return [_about count];
    }
         
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    [cell.textLabel setText:[[_sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Accounts";
    }
    else if (section == 1) {
        return @"Preferences";
    }
    else if (section == 2) {
        return @"About";
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)] autorelease];
    
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 6, tableView.bounds.size.width - 10, 18)] autorelease];
    label.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    [label setFont:[UIFont boldSystemFontOfSize:16]];
    label.textColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                      green:(float)0xEE/0xFF 
                                       blue:(float)0xEE/0xFF 
                                      alpha:1.0f];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    
    
    return headerView;
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    if (indexPath.section == 0) {           //accounts
        switch (indexPath.row) {
            case 0:                         //ICC
                NSLog(@"ICC");
                break;
            case 1:                         //FICS
                NSLog(@"FICS");
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {      //actions
        switch (indexPath.row) {
            case 0:                         //PIECES
                NSLog(@"PIECES");
                PiecesTableViewController *piecesTableViewController = [[PiecesTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:piecesTableViewController animated:YES];
                [piecesTableViewController setDelegate:_delegate];
                break;
            case 1:                         //BOARD
                NSLog(@"BOARD");
                BoardTableViewController *boardTableViewController = [[BoardTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:boardTableViewController animated:YES];
                [boardTableViewController setDelegate:_delegate];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 2) {      //about
        switch (indexPath.row) {
            case 0:                         //HELP
                NSLog(@"HELP");
                break;
            case 1:                         //ABOUT
                NSLog(@"ABOUT");
                break;
            case 2:                         //DONATE
                NSLog(@"DONATE");
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - toolbar actions

- (void)didTouchDone
{
    NSLog(@"Touched done");
    [_delegate dismissMenu];
}

@end
