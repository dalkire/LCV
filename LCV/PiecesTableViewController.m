//
//  PiecesTableViewController.m
//  LCV
//
//  Created by David Alkire on 12/15/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import "PiecesTableViewController.h"
#import "RootViewController.h"


@implementation PiecesTableViewController

@synthesize delegate    = _delegate;
@synthesize piecesArray = _piecesArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _piecesArray = [[NSMutableArray alloc] initWithObjects: [NSNumber numberWithInt:ALPHA], 
                                                                [NSNumber numberWithInt:LINE], 
                                                                [NSNumber numberWithInt:MAGNETIC], 
                                                                [NSNumber numberWithInt:MARK], 
                                                                [NSNumber numberWithInt:MOTIF], 
                                                                [NSNumber numberWithInt:USUAL], 
                                                                [NSNumber numberWithInt:UTRECHT], nil];
        [self setTitle:@"Pieces"];
        
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
    
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                               target:self 
                               action:@selector(didTouchDoneBtn)];
    
    self.navigationItem.rightBarButtonItem = doneBtn;
}

- (void)didTouchDoneBtn
{
    if ([_delegate respondsToSelector:@selector(dismissMenu)]) {
        [(RootViewController *)_delegate dismissMenu];
    }
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
    return [_piecesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSMutableString *prefix = [[NSMutableString alloc] initWithString:@"usual_"];
    switch ([[_piecesArray objectAtIndex:indexPath.row] intValue]) {
        case ALPHA:
            prefix = [NSMutableString stringWithString:@"alpha_"];
            [cell.textLabel setText:@"Alpha"];
            break;
        case LINE:
            prefix = [NSMutableString stringWithString:@"line_"];
            [cell.textLabel setText:@"Line"];
            break;
        case MAGNETIC:
            prefix = [NSMutableString stringWithString:@"magnetic_"];
            [cell.textLabel setText:@"Magnetic"];
            break;
        case MARK:
            prefix = [NSMutableString stringWithString:@"mark_"];
            [cell.textLabel setText:@"Mark"];
            break;
        case MOTIF:
            prefix = [NSMutableString stringWithString:@"motif_"];
            [cell.textLabel setText:@"Motif"];
            break;
        case USUAL:
            prefix = [NSMutableString stringWithString:@"usual_"];
            [cell.textLabel setText:@"Usual"];
            break;
        case UTRECHT:
            prefix = [NSMutableString stringWithString:@"utrecht_"];
            [cell.textLabel setText:@"Utrecht"];
            break;
            
        default:
            break;
    }
    
    UIImage *wp = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *bp = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *wn = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wn.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *bn = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bn.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *wb = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wb.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *bb = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bb.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *wr = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wr.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *br = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@br.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *wq = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wq.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *bq = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bq.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *wk = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@wk.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    UIImage *bk = [RootViewController imageWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@bk.png", prefix]] scaledToSize:CGSizeMake(30, 30)];
    
    [cell.imageView setImage:wp];
    [cell.imageView setAnimationImages:[NSArray arrayWithObjects:wp, bp, wn, bn, wb, bb, wr, br, wq, bq, wk, bk, nil]];
    [cell.imageView setAnimationDuration:30];
    [cell.imageView startAnimating];
    
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
