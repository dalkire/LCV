//
//  BoardTableViewController.m
//  LCV
//
//  Created by David Alkire on 12/15/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import "BoardTableViewController.h"

@implementation BoardTableViewController

@synthesize delegate    = _delegate;
@synthesize boardArray  = _boardArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _boardArray = [[NSMutableArray alloc] initWithObjects:  [NSNumber numberWithInt:CUSTOM], 
                                                                [NSNumber numberWithInt:PAPER], 
                                                                [NSNumber numberWithInt:PINSTRIPES], 
                                                                [NSNumber numberWithInt:PLAIN], 
                                                                [NSNumber numberWithInt:WOOD_DARK], 
                                                                [NSNumber numberWithInt:WOOD_LIGHT], nil];
        [self setTitle:@"Boards"];
        
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        
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
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_boardArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch ([[_boardArray objectAtIndex:indexPath.row] intValue]) {
        case CUSTOM:
            [cell.textLabel setText:@"Custom"];
            break;
        case PAPER:
            [cell.textLabel setText:@"Paper"];
            break;
        case PINSTRIPES:
            [cell.textLabel setText:@"Pinstripes"];
            break;
        case PLAIN:
            [cell.textLabel setText:@"Plain"];
            break;
        case WOOD_DARK:
            [cell.textLabel setText:@"Wood Dark"];
            break;
        case WOOD_LIGHT:
            [cell.textLabel setText:@"Wood Light"];
            break;
            
        default:
            break;
    }
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
