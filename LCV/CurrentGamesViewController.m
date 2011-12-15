//
//  CurrentGamesViewController.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#define NONE        0
#define WATCHING    200
#define TRAINING    201
#define ICC         300
#define FICS        301

#import "CurrentGamesViewController.h"
#import "StreamController.h"
#import "BoardViewController.h"
#import "RootViewController.h"


@implementation CurrentGamesViewController

@synthesize rootViewController      = _rootViewController;
@synthesize watchingViewController  = _watchingViewController;
@synthesize currentGames            = _currentGames;
@synthesize toolbar                 = _toolbar;
@synthesize observing;
@synthesize toBeCleared;
@synthesize activityIndicatorView   = _activityIndicatorView;

- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"init with style");
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        
        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self 
                                                                                action:@selector(didTouchDoneBtn)];
        [self.navigationItem setRightBarButtonItem:doneBtn];
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView setFrame:CGRectMake((self.view.frame.size.width - 20)/2, (self.view.frame.size.height - 20)/2, 20, 20)];
        [_activityIndicatorView setHidesWhenStopped:YES];
        [_activityIndicatorView startAnimating];
        
        _currentGames = [[NSMutableArray alloc] initWithCapacity:0];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.tableView.frame = CGRectMake(0, 0, 320, 416);
        }
        else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.tableView.frame = CGRectMake(0, 0, 320, 416);
        }
        
        [self.tableView addSubview:_activityIndicatorView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VDL CGVC");
    //UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    
    //[self.view addSubview:tv];
    [self refresh];
}

- (void)didTouchDoneBtn
{
    NSLog(@"in current games pressing done %@", _watchingViewController);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_watchingViewController dismissModalViewControllerAnimated:YES];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        NSLog(@"CGpop: %@", _watchingViewController.currentGamesPopover);
        [_watchingViewController.currentGamesPopover dismissPopoverAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	self.currentGames = nil;
//	self.toolbar = nil;
	self.observing = nil;
	_activityIndicatorView = nil;
}


- (void)dealloc {
	[currentGames release];
//	[toolbar release];
	[observing release];
	[_activityIndicatorView release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.currentGames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	
	NSInteger row = [indexPath row];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	  cell.textLabel.text = [[_currentGames objectAtIndex:row] valueForKey:@"game_players"];
	  cell.textLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:12];
	  cell.detailTextLabel.text = [[_currentGames objectAtIndex:row] valueForKey:@"game_desc"];
	  cell.detailTextLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
	  cell.tag = (NSInteger)[[_currentGames objectAtIndex:row] valueForKey:@"game_id"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
	if (self.observing) {
		NSMutableString *unobserveCommand = [[NSMutableString alloc] initWithFormat:@"unobserve %@\r\n", self.observing];
		[[StreamController sharedStreamController] sendCommand:unobserveCommand];
		[unobserveCommand release];
	}
	
    NSUInteger row = [indexPath row]; 
    NSString *gameID = [[_currentGames objectAtIndex:row] valueForKey:@"game_id"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	BoardViewController *bvc = _rootViewController.watchingViewController;
	
	NSString *whitePlayerLabel = [[NSString alloc] initWithFormat:@"%@ %@", [[_currentGames objectAtIndex:row] valueForKey:@"white_player"], [[_currentGames objectAtIndex:row] valueForKey:@"white_rating"]];
	NSString *blackPlayerLabel = [[NSString alloc] initWithFormat:@"%@ %@", [[_currentGames objectAtIndex:row] valueForKey:@"black_player"], [[_currentGames objectAtIndex:row] valueForKey:@"black_rating"]];
	[bvc setPlayerLabel:whitePlayerLabel forColor:@"white"];
	[bvc setPlayerLabel:blackPlayerLabel forColor:@"black"];
	bvc.whiteName = [NSString stringWithString:[[_currentGames objectAtIndex:row] valueForKey:@"white_player"]];
	bvc.blackName = [NSString stringWithString:[[_currentGames objectAtIndex:row] valueForKey:@"black_player"]];
	bvc.whiteElo = [NSString stringWithString:[[_currentGames objectAtIndex:row] valueForKey:@"white_rating"]];
	bvc.blackElo = [NSString stringWithString:[[_currentGames objectAtIndex:row] valueForKey:@"black_rating"]];
	[whitePlayerLabel release];
	[blackPlayerLabel release];
	
	[_rootViewController.watchingViewController resetResults];
	
	if ([StreamController sharedStreamController].server == ICC) {
		[_rootViewController.watchingViewController resetBoard];
	}
	
	[_rootViewController.watchingViewController resetMoveListView];
	NSMutableString *command = [[NSMutableString alloc] initWithFormat:@"observe %@\r\n", gameID];
	self.observing = gameID;
	[StreamController sharedStreamController].observing = [self.observing integerValue];
	[StreamController sharedStreamController].ficsMoveList = [NSMutableArray new];
	[StreamController sharedStreamController].currentFicsLocalMoveNumber = 0;
	[[StreamController sharedStreamController] sendCommand:command];
	[command release];
} 

- (void)commandResult:(NSString *)result fromCommand:(NSInteger)command {
	_currentGames = [self parseCurrentGamesFromCommandResult:result];
    NSLog(@"_currentgames count: %d", [_currentGames count]);
    [self.tableView reloadData];
}

- (NSMutableArray *)parseCurrentGamesFromCommandResult:(NSString *)result {
	[_activityIndicatorView stopAnimating];
	
	NSArray *arr;// = [NSArray array];
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	NSMutableArray *rowArray = [[NSMutableArray alloc] init];
	
	arr = [result componentsSeparatedByString:@"\r\n"];
	NSUInteger i = 0;
	for (NSString *row in arr) {
		//NSLog(@"row: %@", row);
		if (i > 0 && i < [arr count] - 5) {
			[rowArray removeAllObjects];
			[rowArray addObjectsFromArray:[row componentsSeparatedByString:@" "]];
			[rowArray removeObject:@""];
			if ([rowArray count] >= 9) {
			NSMutableString *game_players = [NSMutableString new];
			NSMutableString *game_desc = [NSMutableString new];
			NSMutableDictionary *dict = [NSMutableDictionary new];
			[game_players appendFormat:@"(%@) %@ vs (%@) %@", [rowArray objectAtIndex:1], [rowArray objectAtIndex:2], [rowArray objectAtIndex:3], [rowArray objectAtIndex:4]];
			if([rowArray count] > 9) {
				[game_desc appendFormat:@"%@ %@ %@ move is %@ %@", [rowArray objectAtIndex:5], [rowArray objectAtIndex:6], [rowArray objectAtIndex:7], [rowArray objectAtIndex:8], [rowArray objectAtIndex:9]];
			}
			else {
				[game_desc appendFormat:@"%@ %@ %@ move is %@ %@", [rowArray objectAtIndex:5], [rowArray objectAtIndex:6], [rowArray objectAtIndex:7], [rowArray objectAtIndex:8]];
			}
			[dict setValue:[game_players mutableCopy] forKey:@"game_players"];
			[dict setValue:[rowArray objectAtIndex:2] forKey:@"white_player"];
			[dict setValue:[rowArray objectAtIndex:1] forKey:@"white_rating"];

			[dict setValue:[rowArray objectAtIndex:4] forKey:@"black_player"];
			[dict setValue:[rowArray objectAtIndex:3] forKey:@"black_rating"];
			[dict setValue:[rowArray objectAtIndex:0] forKey:@"game_id"];
			[dict setValue:[game_desc mutableCopy] forKey:@"game_desc"];
			[resultArray addObject:[dict mutableCopy]];
			[game_players release];
			[game_desc release];
			}
		}
		i++;
	}
	
	[rowArray release];
	return resultArray;
}

- (void)refresh {
	NSLog(@"REFRESH..");
	[self clearCurrentGamesTable];
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([StreamController sharedStreamController].server == FICS) {
		[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"~~startgames\r\ngames /b\r\n~~endgames\r\n" fromViewController:(UITableViewController *)self];
	}
	else {
		if ([defaults valueForKey:@"iccusername"] == NULL || [[defaults valueForKey:@"iccusername"] isEqualToString:@""] || [[defaults valueForKey:@"iccusername"] isEqualToString:@"g"] || [[defaults valueForKey:@"iccusername"] isEqualToString:@"guest"]) {
			NSLog(@"GUEST");
			[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"games *-T-r-w-L-d-z-e-o\r\n" fromViewController:self];
		}
		else {
			NSLog(@"NON_GUEST");
			[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"games *R-w-L-d-z-e-o\r\n" fromViewController:self];
		}
	}
}

- (void)showBoardView {
# warning 
    //[(MainViewController *)[StreamController sharedStreamController].mainViewController showBoardViewController];
	[self clearCurrentGamesTable];
}

- (void)showInfoView {
# warning 
	//[(MainViewController *)[StreamController sharedStreamController].mainViewController showInfoViewController];
	[self clearCurrentGamesTable];
}

- (void)clearCurrentGamesTable {
	_currentGames = [[NSMutableArray alloc] initWithCapacity:0];
	[activityIndicatorView startAnimating];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark AdMobDelegate methods



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if((indexPath.section == 0) && (indexPath.row == 0)) {
		return 48.0; // this is the height of the AdMob ad
	}
	
	return 44.0; // this is the generic cell height
}

@end
