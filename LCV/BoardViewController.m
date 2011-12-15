//
//  BoardViewController.m
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

#import "BoardViewController.h"
#import "StreamController.h"
#import "BoardView.h"
#import "Move.h"
#import "MoveListView.h"
#import "PieceImageView.h"


@implementation BoardViewController

@synthesize rootViewController          = _rootViewController;
@synthesize navController               = _navController;
@synthesize currentGamesViewController  = _currentGamesViewController;
@synthesize currentGamesPopover         = _currentGamesPopover;
@synthesize toolbar                     = _toolbar; 
@synthesize board;
@synthesize blackName;
@synthesize whiteName;
@synthesize blackElo;
@synthesize whiteElo;
@synthesize resultText;
@synthesize iccResultText;
@synthesize flipped;
@synthesize device                      = _device;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _currentGamesViewController  = [[CurrentGamesViewController alloc] initWithStyle:UITableViewStylePlain];
        [_currentGamesViewController setTitle:@"Current Games"];
        [_currentGamesViewController setWatchingViewController:self];
        
        _navController = [[UINavigationController alloc] initWithRootViewController:_currentGamesViewController];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _currentGamesPopover = [[UIPopoverController alloc] initWithContentViewController:_navController];
        }
        NSLog(@"watching view controller self: %@", self);
        [[StreamController sharedStreamController] setCurrentGamesViewController:_currentGamesViewController];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height - 20;
    _device = IPHONE;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSLog(@"PAD");
        _device = IPAD;
        width = [UIScreen mainScreen].bounds.size.height;
        height = [UIScreen mainScreen].bounds.size.width - 20;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, width, height)];
    
	_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height - 44, width, 44)];
	_toolbar.barStyle = UIBarStyleBlack;
	UIBarButtonItem *gamesBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-menu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showCurrentGamesView)];
	UIBarButtonItem *flipBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"flip-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(flipBoard)];
	UIBarButtonItem *emailBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"email-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(sendMail)];
	UIBarButtonItem *backwardBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backward-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goBackward)];
	UIBarButtonItem *forwardBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forward-icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(goForward)];
	UIBarButtonItem *flexibleSpaceBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
	NSArray *barItems = [[NSArray alloc] initWithObjects:gamesBarButton, flexibleSpaceBarButton, flipBarButton, flexibleSpaceBarButton, emailBarButton, flexibleSpaceBarButton, backwardBarButton, flexibleSpaceBarButton, forwardBarButton, nil];
	_toolbar.items = barItems;
	[gamesBarButton release];
	[flexibleSpaceBarButton release];
	[barItems release];
	[view addSubview:_toolbar];
	//[self.view setBackgroundColor:[UIColor blackColor]];
    
	BoardView *boardView = [[BoardView alloc] initForDevice:_device];
	boardView.tag = 1;
	board = boardView;
	[view addSubview:boardView];
	[boardView release];
	
	blackName = [[NSString alloc] initWithString:@""];
	whiteName = [[NSString alloc] initWithString:@""];
	blackElo  = [[NSString alloc] initWithString:@""];
	whiteElo  = [[NSString alloc] initWithString:@""];
	resultText = [[NSString alloc] initWithString:@""];
	iccResultText = [[NSString alloc] initWithString:@""];
	flipped = NO;
    [self setView:view];
    //[self showCurrentGamesView];
    //[view release];
}

- (void)viewDidLoad {   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	_toolbar = nil;
	self.board = nil;
	self.blackName = nil;
	self.whiteName = nil;
	self.blackElo = nil;
	self.whiteElo = nil;
	self.resultText = nil;
	self.iccResultText = nil;
}

- (void)dismissMenu
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [_currentGamesPopover dismissPopoverAnimated:YES];
    }
}


- (void)dealloc {
	[_toolbar release];
	[board release];
	[blackName release];
	[whiteName release];
	[blackElo release];
	[whiteElo release];
	[resultText release];
	[iccResultText release];
    [super dealloc];
}

- (void)commandResult:(NSString *)result fromCommand:(NSInteger *)command {
	//NSArray *arr;// = [NSArray array];
	//arr = [result componentsSeparatedByString:@"\r\n"];
}

- (void)moveList:(NSArray *)moveList {
	NSEnumerator *enumerator = [moveList objectEnumerator];
	NSString *promote;// = [[NSString alloc] initWithString:@"NO"];
	
	Move *move;// = [[Move alloc] init];
	NSUInteger count = 1;
	while (move = [enumerator nextObject]) {		
		if(count %2 == 0) {
			[board setTime:move.timeLeftInSeconds forColor:@"black"];
			board.whitePlayerLabel.textColor = [UIColor whiteColor];
			board.whiteTimeLabel.textColor = [UIColor whiteColor];
			board.blackPlayerLabel.textColor = [UIColor lightTextColor];
			board.blackTimeLabel.textColor = [UIColor lightTextColor];
		}
		else {
			[board setTime:move.timeLeftInSeconds forColor:@"white"];
			board.blackPlayerLabel.textColor = [UIColor whiteColor];
			board.blackTimeLabel.textColor = [UIColor whiteColor];
			board.whitePlayerLabel.textColor = [UIColor lightTextColor];
			board.whiteTimeLabel.textColor = [UIColor lightTextColor];
		}
		
		unichar lastChar = [move.smith characterAtIndex:[move.smith length] - 1];
		if (lastChar == 'N' || lastChar == 'B' || lastChar == 'R' || lastChar == 'Q') {
			promote = [NSString stringWithFormat:@"%c", lastChar];
		}
		else {
			promote = [NSString stringWithString:@"NO"];
		}

		if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'c') {
			//O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e1"] toPoint:[self getPointFromSquare:@"g1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"h1"] toPoint:[self getPointFromSquare:@"f1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e8"] toPoint:[self getPointFromSquare:@"g8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"h8"] toPoint:[self getPointFromSquare:@"f8"] promote:promote];
			}
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'C') {
			//O-O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e1"] toPoint:[self getPointFromSquare:@"c1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"a1"] toPoint:[self getPointFromSquare:@"d1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e8"] toPoint:[self getPointFromSquare:@"c8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"a8"] toPoint:[self getPointFromSquare:@"d8"] promote:promote];
			}
		}
		else {
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] promote:promote];
		}
		
		count++;
	}
}

- (void)setPositionFromStyle12:(NSString *)style12 {
	[(BoardImageView *)[board board] clearBoard];
	NSArray *style12Array = [style12 componentsSeparatedByString:@" "];
	NSString *verboseMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:26]];
	NSString *algebraicMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:28]];
	NSString *colorForNextMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:8]];
	
	for (int i=0; i < 8; i++) {
		NSString *row = [style12Array objectAtIndex:i];
		//NSLog(@"ROW: %@", row);
		for (int j=0; j < 8; j++) {
			if ([row characterAtIndex:j] != '-') {
				NSString *file = [[NSString alloc] initWithString:@""];
				NSString *color;// = [[NSString alloc] initWithString:@""];
				NSString *charAsString = [[NSString alloc] initWithFormat:@"%c", [row characterAtIndex:j]];
				charAsString = [charAsString lowercaseString];
				
				if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[row characterAtIndex:j]]) {
					color = [NSString stringWithString:@"w"];
				}
				else {
					color = [NSString stringWithString:@"b"];
				}
				
				if (j == 0) {
					file = [NSString stringWithString:@"a"];
				}
				else if (j == 1) {
					file = [NSString stringWithString:@"b"];
				}
				else if (j == 2) {
					file = [NSString stringWithString:@"c"];
				}
				else if (j == 3) {
					file = [NSString stringWithString:@"d"];
				}
				else if (j == 4) {
					file = [NSString stringWithString:@"e"];
				}
				else if (j == 5) {
					file = [NSString stringWithString:@"f"];
				}
				else if (j == 6) {
					file = [NSString stringWithString:@"g"];
				}
				else if (j == 7) {
					file = [NSString stringWithString:@"h"];
				}
				//NSLog(@"%@%@ at %@%d", color, charAsString, file, 8-i);
				[(BoardImageView *)[board board] addPiece:[NSString stringWithFormat:@"%@%@", color, charAsString] toSquare:[NSString stringWithFormat:@"%@%d", file, 8-i]];
			}
		}
	}
	
	if ([verboseMove isEqualToString:@"none"]) {
		//none
	}
	else if ([verboseMove isEqualToString:@"o-o"]) {
		//castle short
		if ([colorForNextMove isEqualToString:@"B"]) {
			//white just moved
			[(BoardImageView *)[board board] placeHighlightsForMove:@"e1g1"];
		}
		else if ([colorForNextMove isEqualToString:@"W"]) {
			//black just moved
			[(BoardImageView *)[board board] placeHighlightsForMove:@"e8g8"];
		} 
	}
	else if ([verboseMove isEqualToString:@"o-o-o"]) {
		//castle long
		if ([colorForNextMove isEqualToString:@"B"]) {
			//white just moved
			[(BoardImageView *)[board board] placeHighlightsForMove:@"e1c1"];
		}
		else if ([colorForNextMove isEqualToString:@"W"]) {
			//black just moved
			[(BoardImageView *)[board board] placeHighlightsForMove:@"e8c8"];
		} 
	}
	else {
		[(BoardImageView *)[board board] placeHighlightsForMove:[NSString stringWithFormat:@"%@%@", [verboseMove substringWithRange:NSMakeRange(2, 2)], [verboseMove substringWithRange:NSMakeRange(5, 2)]]];
	}
	
	NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
	NSNumber *whiteTime = [nf numberFromString:[style12Array objectAtIndex:23]];
	NSNumber *blackTime = [nf numberFromString:[style12Array objectAtIndex:24]];
	NSNumber *standardMoveNum = [nf numberFromString:[style12Array objectAtIndex:25]];
	NSNumber *absMoveNum = [[NSNumber alloc] initWithInteger:[standardMoveNum integerValue]*2];
	if ([colorForNextMove isEqualToString:@"B"]) {
		absMoveNum = [NSNumber numberWithInt:[absMoveNum intValue]-1];
	}
	else if ([colorForNextMove isEqualToString:@"W"]) {
		absMoveNum = [NSNumber numberWithInt:[absMoveNum intValue]-2];
	}

	//[StreamController sharedStreamController].absoluteMoveNumber = [absMoveNum integerValue];*/
	NSLog(@"CMN=%d | AMN=%d", [StreamController sharedStreamController].currentMoveNumber, [StreamController sharedStreamController].absoluteMoveNumber);
	
	if ([StreamController sharedStreamController].currentMoveNumber == [StreamController sharedStreamController].absoluteMoveNumber) {
		[self addToMoveListView:algebraicMove withAbsoluteMoveNumber:[absMoveNum intValue] andLocalFicsNumber:[StreamController sharedStreamController].currentFicsLocalMoveNumber animated:YES];
	}
	[board setTime:blackTime forColor:@"black"];
	[board setTime:whiteTime forColor:@"white"];
	
	
    if([colorForNextMove isEqualToString:@"W"]) {
        board.whitePlayerLabel.textColor = [UIColor whiteColor];
        board.whiteTimeLabel.textColor = [UIColor whiteColor];
        board.blackPlayerLabel.textColor = [UIColor lightTextColor];
        board.blackTimeLabel.textColor = [UIColor lightTextColor];
    }
    else {
        board.blackPlayerLabel.textColor = [UIColor whiteColor];
        board.blackTimeLabel.textColor = [UIColor whiteColor];
        board.whitePlayerLabel.textColor = [UIColor lightTextColor];
        board.whiteTimeLabel.textColor = [UIColor lightTextColor];
    }
}

- (void)move:(Move *)move direction:(NSString *)direction {
	NSString *promote = [[NSString alloc] initWithString:@"NO"];
	unichar lastChar = [move.smith characterAtIndex:[move.smith length] - 1];
	if (lastChar == 'N' || lastChar == 'B' || lastChar == 'R' || lastChar == 'Q') {
		promote = [NSString stringWithFormat:@"%c", lastChar];
	}
	
	if ([direction isEqualToString:@"forward"]) {
		if([StreamController sharedStreamController].currentMoveNumber %2 == 0) {
			[board setTime:move.timeLeftInSeconds forColor:@"black"];
			board.whitePlayerLabel.textColor = [UIColor whiteColor];
			board.whiteTimeLabel.textColor = [UIColor whiteColor];
			board.blackPlayerLabel.textColor = [UIColor lightTextColor];
			board.blackTimeLabel.textColor = [UIColor lightTextColor];
		}
		else {
			[board setTime:move.timeLeftInSeconds forColor:@"white"];
			board.blackPlayerLabel.textColor = [UIColor whiteColor];
			board.blackTimeLabel.textColor = [UIColor whiteColor];
			board.whitePlayerLabel.textColor = [UIColor lightTextColor];
			board.whiteTimeLabel.textColor = [UIColor lightTextColor];
		}
		if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'c') {
			//O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"h1"] toPoint:[self getPointFromSquare:@"f1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e1"] toPoint:[self getPointFromSquare:@"g1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"h8"] toPoint:[self getPointFromSquare:@"f8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e8"] toPoint:[self getPointFromSquare:@"g8"] promote:promote];
			}
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'C') {
			//O-O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"a1"] toPoint:[self getPointFromSquare:@"d1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e1"] toPoint:[self getPointFromSquare:@"c1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"a8"] toPoint:[self getPointFromSquare:@"d8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"e8"] toPoint:[self getPointFromSquare:@"c8"] promote:promote];
			}
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'E') {
			//En-Passant
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:1]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] promote:promote];
			[(BoardImageView *)[board board] removePieceFromSquare:square];
			[square release];
		}
		else {
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] promote:promote];
		}
	}
	else if ([direction isEqualToString:@"backward"]) {
		Move *m1 = [[StreamController sharedStreamController].moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber-1];
		if([StreamController sharedStreamController].currentMoveNumber %2 == 0) {
			[board setTime:m1.timeLeftInSeconds forColor:@"black"];
			if ([StreamController sharedStreamController].currentMoveNumber > 2) {
				Move *m2 = [[StreamController sharedStreamController].moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber-2];
				[board setTime:m2.timeLeftInSeconds forColor:@"white"];
			}
			board.whitePlayerLabel.textColor = [UIColor whiteColor];
			board.whiteTimeLabel.textColor = [UIColor whiteColor];
			board.blackPlayerLabel.textColor = [UIColor lightTextColor];
			board.blackTimeLabel.textColor = [UIColor lightTextColor];
		}
		else {
			[board setTime:m1.timeLeftInSeconds forColor:@"white"];
			if ([StreamController sharedStreamController].currentMoveNumber > 2) {
				Move *m2 = [[StreamController sharedStreamController].moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber-2];
				[board setTime:m2.timeLeftInSeconds forColor:@"black"];
			}
			board.blackPlayerLabel.textColor = [UIColor whiteColor];
			board.blackTimeLabel.textColor = [UIColor whiteColor];
			board.whitePlayerLabel.textColor = [UIColor lightTextColor];
			board.whiteTimeLabel.textColor = [UIColor lightTextColor];
		}
		if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'c') {
			//O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"g1"] toPoint:[self getPointFromSquare:@"e1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"f1"] toPoint:[self getPointFromSquare:@"h1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"g8"] toPoint:[self getPointFromSquare:@"e8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"f8"] toPoint:[self getPointFromSquare:@"h8"] promote:promote];
			}
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'C') {
			//O-O-O
			if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e1"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"c1"] toPoint:[self getPointFromSquare:@"e1"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"d1"] toPoint:[self getPointFromSquare:@"a1"] promote:promote];
			}
			else if ([[move.smith substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"e8"]) {
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"c8"] toPoint:[self getPointFromSquare:@"e8"] promote:promote];
				[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:@"d8"] toPoint:[self getPointFromSquare:@"a8"] promote:promote];
			}
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'E') {
			//En-Passant
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"bp" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wp" toSquare:square];
			}
			[square release];
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'p') {
			//Pawn Capture
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"bp" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wp" toSquare:square];
			}
			[square release];
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'n') {
			//Knight Capture
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"bn" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wn" toSquare:square];
			}
			[square release];
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'b') {
			//Bishop Capture
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"bb" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wb" toSquare:square];
			}
			[square release];
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'r') {
			//Rook Capture
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"br" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wr" toSquare:square];
			}
			[square release];
		}
		else if ([move.smith length] > 4 && [move.smith characterAtIndex:4] == 'q') {
			//Queen Capture
			NSString *square = [[NSString alloc] initWithFormat:@"%c%c", [move.smith characterAtIndex:2], [move.smith characterAtIndex:3]];
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
			if ([StreamController sharedStreamController].currentMoveNumber % 2 == 0) {
				[(BoardImageView *)[board board] addPiece:@"bq" toSquare:square];
			}
			else {
				[(BoardImageView *)[board board] addPiece:@"wq" toSquare:square];
			}
			[square release];
		}
		else {
			[(BoardImageView *)[board board] moveFromPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(2, 2)]] toPoint:[self getPointFromSquare:[move.smith substringWithRange:NSMakeRange(0, 2)]] promote:promote];
		}
		
		Move *prevMove = (Move *)[[StreamController sharedStreamController].moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber-1];
		[(BoardImageView *)[board board] placeHighlightsForMove:prevMove.smith];
	}
}

- (CGPoint)getPointFromSquare:(NSString *)square {
	if ([square isEqualToString:@"a1"]) {
		return CGPointMake(20.0, 300.0);
	}
	if ([square isEqualToString:@"a2"]) {
		return CGPointMake(20.0, 260.0);
	}
	if ([square isEqualToString:@"a3"]) {
		return CGPointMake(20.0, 220.0);
	}
	if ([square isEqualToString:@"a4"]) {
		return CGPointMake(20.0, 180.0);
	}
	if ([square isEqualToString:@"a5"]) {
		return CGPointMake(20.0, 140.0);
	}
	if ([square isEqualToString:@"a6"]) {
		return CGPointMake(20.0, 100.0);
	}
	if ([square isEqualToString:@"a7"]) {
		return CGPointMake(20.0, 60.0);
	}
	if ([square isEqualToString:@"a8"]) {
		return CGPointMake(20.0, 20.0);
	}
	
	if ([square isEqualToString:@"b1"]) {
		return CGPointMake(60.0, 300.0);
	}
	if ([square isEqualToString:@"b2"]) {
		return CGPointMake(60.0, 260.0);
	}
	if ([square isEqualToString:@"b3"]) {
		return CGPointMake(60.0, 220.0);
	}
	if ([square isEqualToString:@"b4"]) {
		return CGPointMake(60.0, 180.0);
	}
	if ([square isEqualToString:@"b5"]) {
		return CGPointMake(60.0, 140.0);
	}
	if ([square isEqualToString:@"b6"]) {
		return CGPointMake(60.0, 100.0);
	}
	if ([square isEqualToString:@"b7"]) {
		return CGPointMake(60.0, 60.0);
	}
	if ([square isEqualToString:@"b8"]) {
		return CGPointMake(60.0, 20.0);
	}
	
	if ([square isEqualToString:@"c1"]) {
		return CGPointMake(100.0, 300.0);
	}
	if ([square isEqualToString:@"c2"]) {
		return CGPointMake(100.0, 260.0);
	}
	if ([square isEqualToString:@"c3"]) {
		return CGPointMake(100.0, 220.0);
	}
	if ([square isEqualToString:@"c4"]) {
		return CGPointMake(100.0, 180.0);
	}
	if ([square isEqualToString:@"c5"]) {
		return CGPointMake(100.0, 140.0);
	}
	if ([square isEqualToString:@"c6"]) {
		return CGPointMake(100.0, 100.0);
	}
	if ([square isEqualToString:@"c7"]) {
		return CGPointMake(100.0, 60.0);
	}
	if ([square isEqualToString:@"c8"]) {
		return CGPointMake(100.0, 20.0);
	}
	
	if ([square isEqualToString:@"d1"]) {
		return CGPointMake(140.0, 300.0);
	}
	if ([square isEqualToString:@"d2"]) {
		return CGPointMake(140.0, 260.0);
	}
	if ([square isEqualToString:@"d3"]) {
		return CGPointMake(140.0, 220.0);
	}
	if ([square isEqualToString:@"d4"]) {
		return CGPointMake(140.0, 180.0);
	}
	if ([square isEqualToString:@"d5"]) {
		return CGPointMake(140.0, 140.0);
	}
	if ([square isEqualToString:@"d6"]) {
		return CGPointMake(140.0, 100.0);
	}
	if ([square isEqualToString:@"d7"]) {
		return CGPointMake(140.0, 60.0);
	}
	if ([square isEqualToString:@"d8"]) {
		return CGPointMake(140.0, 20.0);
	}
	
	if ([square isEqualToString:@"e1"]) {
		return CGPointMake(180.0, 300.0);
	}
	if ([square isEqualToString:@"e2"]) {
		return CGPointMake(180.0, 260.0);
	}
	if ([square isEqualToString:@"e3"]) {
		return CGPointMake(180.0, 220.0);
	}
	if ([square isEqualToString:@"e4"]) {
		return CGPointMake(180.0, 180.0);
	}
	if ([square isEqualToString:@"e5"]) {
		return CGPointMake(180.0, 140.0);
	}
	if ([square isEqualToString:@"e6"]) {
		return CGPointMake(180.0, 100.0);
	}
	if ([square isEqualToString:@"e7"]) {
		return CGPointMake(180.0, 60.0);
	}
	if ([square isEqualToString:@"e8"]) {
		return CGPointMake(180.0, 20.0);
	}
	
	if ([square isEqualToString:@"f1"]) {
		return CGPointMake(220.0, 300.0);
	}
	if ([square isEqualToString:@"f2"]) {
		return CGPointMake(220.0, 260.0);
	}
	if ([square isEqualToString:@"f3"]) {
		return CGPointMake(220.0, 220.0);
	}
	if ([square isEqualToString:@"f4"]) {
		return CGPointMake(220.0, 180.0);
	}
	if ([square isEqualToString:@"f5"]) {
		return CGPointMake(220.0, 140.0);
	}
	if ([square isEqualToString:@"f6"]) {
		return CGPointMake(220.0, 100.0);
	}
	if ([square isEqualToString:@"f7"]) {
		return CGPointMake(220.0, 60.0);
	}
	if ([square isEqualToString:@"f8"]) {
		return CGPointMake(220.0, 20.0);
	}
	
	if ([square isEqualToString:@"g1"]) {
		return CGPointMake(260.0, 300.0);
	}
	if ([square isEqualToString:@"g2"]) {
		return CGPointMake(260.0, 260.0);
	}
	if ([square isEqualToString:@"g3"]) {
		return CGPointMake(260.0, 220.0);
	}
	if ([square isEqualToString:@"g4"]) {
		return CGPointMake(260.0, 180.0);
	}
	if ([square isEqualToString:@"g5"]) {
		return CGPointMake(260.0, 140.0);
	}
	if ([square isEqualToString:@"g6"]) {
		return CGPointMake(260.0, 100.0);
	}
	if ([square isEqualToString:@"g7"]) {
		return CGPointMake(260.0, 60.0);
	}
	if ([square isEqualToString:@"g8"]) {
		return CGPointMake(260.0, 20.0);
	}
	
	if ([square isEqualToString:@"h1"]) {
		return CGPointMake(300.0, 300.0);
	}
	if ([square isEqualToString:@"h2"]) {
		return CGPointMake(300.0, 260.0);
	}
	if ([square isEqualToString:@"h3"]) {
		return CGPointMake(300.0, 220.0);
	}
	if ([square isEqualToString:@"h4"]) {
		return CGPointMake(300.0, 180.0);
	}
	if ([square isEqualToString:@"h5"]) {
		return CGPointMake(300.0, 140.0);
	}
	if ([square isEqualToString:@"h6"]) {
		return CGPointMake(300.0, 100.0);
	}
	if ([square isEqualToString:@"h7"]) {
		return CGPointMake(300.0, 60.0);
	}
	if ([square isEqualToString:@"h8"]) {
		return CGPointMake(300.0, 20.0);
	}
	return CGPointMake(0.0, 0.0);
}

- (void)showCurrentGamesView {
	if ([StreamController sharedStreamController].server == FICS) {
		[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"~~startgames\r\ngames /b\r\n~~endgames\r\n" fromViewController:_currentGamesViewController];
	}
	else {
		[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"games *-T-r-w-L-d-z-e-o\r\n" fromViewController:_currentGamesViewController];
	}
    
    NSLog(@"Did touch menu");
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [_navController.view setFrame:CGRectMake(_navController.view.frame.origin.x, 
                                                       _navController.view.frame.origin.y - 20, 
                                                       _navController.view.frame.size.width, 
                                                       _navController.view.frame.size.height)];
        [_navController.navigationBar setBarStyle:UIBarStyleBlack];
        [self presentModalViewController:_navController animated:YES];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _navController = [[UINavigationController alloc] initWithRootViewController:_currentGamesViewController];
        [_navController.navigationBar setBarStyle:UIBarStyleBlack];
        
        [_currentGamesPopover presentPopoverFromBarButtonItem:[[_toolbar items] objectAtIndex:0] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}

- (void)setPlayerLabel:(NSString *)name forColor:(NSString *)color {
	if ([color isEqualToString:@"white"]) {
		board.whitePlayerLabel.text = name;
	}
	else if ([color isEqualToString:@"black"]) {
		board.blackPlayerLabel.text = name;
	}
}

- (void)decrementTimeForColor:(NSString *)color {
	if ([color isEqualToString:@"black"] && board.blackTimeInSeconds > 0) {
		[board setTime:[NSNumber numberWithUnsignedInteger:board.blackTimeInSeconds-1] forColor:@"black"];
	}
	else if ([color isEqualToString:@"white"] && board.whiteTimeInSeconds > 0) {
		[board setTime:[NSNumber numberWithUnsignedInteger:board.whiteTimeInSeconds-1] forColor:@"white"];
	}
}

- (void)resetBoard {
	[(BoardImageView *)[board board] setBoard];
}

- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated {
	[[board moveListView] addToMoveListView:move withAbsoluteMoveNumber:absoluteMoveNumber animated:animated];
}

- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber andLocalFicsNumber:(NSUInteger)localFicsNumber animated:(BOOL)animated {
	[[board moveListView] addToMoveListView:move withAbsoluteMoveNumber:absoluteMoveNumber andLocalFicsNumber:localFicsNumber animated:animated];
}

- (void)resetMoveListView {
	[board resetMoveListView];
}

- (void)addEndLabelResult:(NSString *)resText iccResult:(NSString *)iccResText absoluteMoveNumber:(NSUInteger)absoluteMoveNumber {
	resultText = resText;
	iccResultText = iccResText;
	[(MoveListView *)board.moveListView addEndLabel:[NSString stringWithFormat:@"%@ %@", resText, iccResText] withAbsoluteMoveNumber:absoluteMoveNumber];
}

- (void)sendMail {
	if ([StreamController sharedStreamController].server == FICS) {
		NSEnumerator *enumerator = [[StreamController sharedStreamController].moveList objectEnumerator];
		Move *m;// = [[Move alloc] init];
		NSMutableString *pgnString = [[NSMutableString alloc] initWithString:@""];
		
		[pgnString appendString:@"[Site \"Free Internet Chess Server\"]\r\n"];
		[pgnString appendFormat:@"[White \"%@\"]\r\n", whiteName];
		[pgnString appendFormat:@"[Black \"%@\"]\r\n", blackName];
		[pgnString appendFormat:@"[Result \"%@\"]\r\n", [StreamController sharedStreamController].resultText];
		[pgnString appendFormat:@"[FICSResult \"%@\"]\r\n", [StreamController sharedStreamController].iccResultText];
		[pgnString appendFormat:@"[WhiteElo \"%@\"]\r\n", whiteElo];
		[pgnString appendFormat:@"[BlackElo \"%@\"]\r\n", blackElo];
		[pgnString appendFormat:@"[SetUp \"1\"]\r\n"];
		
		int count = 1;
		while (m = [enumerator nextObject]) {
			NSArray *arr = [(NSString *)m componentsSeparatedByString:@" "];
			if (count %2 == 1) {
				[pgnString appendFormat:@"%d. %@ ", (count+1)/2, [arr objectAtIndex:28]];
			}	
			else {
				[pgnString appendFormat:@"%@ ", [arr objectAtIndex:28]];
			}
			
			count++;
		}
		
		[pgnString appendFormat:@"{%@} %@", iccResultText, resultText];
		
		/*MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
		mailComposeController.mailComposeDelegate = self;
		
		[mailComposeController setSubject:[NSString stringWithFormat:@"%@ vs %@ %@", whiteName, blackName, [NSDate date]]];
		[mailComposeController setMessageBody:pgnString isHTML:NO];
		[mailComposeController addAttachmentData:[[NSString stringWithString:pgnString] dataUsingEncoding:NSASCIIStringEncoding] mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"%@ vs %@ %@.pgn", whiteName, blackName, [NSDate date]]];
		
		[self presentModalViewController:mailComposeController animated:YES];
		[mailComposeController release];*/
		
		NSLog(@"%@", pgnString);
		[pgnString release];
	}
	else {
		NSEnumerator *enumerator = [[StreamController sharedStreamController].moveList objectEnumerator];
		Move *m;// = [[Move alloc] init];
		NSMutableString *pgnString = [[NSMutableString alloc] initWithString:@""];
		
		[pgnString appendString:@"[Site \"Internet Chess Club\"]\r\n"];
		[pgnString appendFormat:@"[White \"%@\"]\r\n", whiteName];
		[pgnString appendFormat:@"[Black \"%@\"]\r\n", blackName];
		[pgnString appendFormat:@"[Result \"%@\"]\r\n", [StreamController sharedStreamController].resultText];
		[pgnString appendFormat:@"[ICCResult \"%@\"]\r\n", [StreamController sharedStreamController].iccResultText];
		[pgnString appendFormat:@"[WhiteElo \"%@\"]\r\n", whiteElo];
		[pgnString appendFormat:@"[BlackElo \"%@\"]\r\n", blackElo];
		
		int count = 1;
		while (m = [enumerator nextObject]) {
			if (count %2 == 1) {
				[pgnString appendFormat:@"%d. %@ ", (count+1)/2, m.algebraic];
			}	
			else {
				[pgnString appendFormat:@"%@ ", m.algebraic];
			}

			count++;
		}
	
		[pgnString appendFormat:@"{%@} %@", iccResultText, resultText];
		
		MFMailComposeViewController *mailComposeController = [[MFMailComposeViewController alloc] init];
		mailComposeController.mailComposeDelegate = self;
	
		[mailComposeController setSubject:[NSString stringWithFormat:@"%@ vs %@ %@", whiteName, blackName, [NSDate date]]];
		[mailComposeController setMessageBody:pgnString isHTML:NO];
		[mailComposeController addAttachmentData:[[NSString stringWithString:pgnString] dataUsingEncoding:NSASCIIStringEncoding] mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"%@ vs %@ %@.pgn", whiteName, blackName, [NSDate date]]];
	
		[self presentModalViewController:mailComposeController animated:YES];
		[mailComposeController release];
	
		[pgnString release];
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)goBackward {
	if ([StreamController sharedStreamController].server == FICS) {
		if([StreamController sharedStreamController].currentMoveNumber > 1) {
			[StreamController sharedStreamController].currentMoveNumber--;
			NSMutableArray *moveList = [StreamController sharedStreamController].moveList;
			NSString *style12string = (NSString *)[moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber - 1];
			[self setPositionFromStyle12:style12string];
			
			NSLog(@"MOVE NUM: %d, BACKWARD: %@", [StreamController sharedStreamController].currentMoveNumber, style12string);
			
			[board.moveListView highlightMoveWithAbsoluteMoveNumber:[StreamController sharedStreamController].currentMoveNumber animated:YES];
		}
	}
	else {
		if([StreamController sharedStreamController].currentMoveNumber > 1) {
			[StreamController sharedStreamController].currentMoveNumber--;
			NSMutableArray *moveList = [StreamController sharedStreamController].moveList;
			Move *move = (Move *)[moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber];
			[self move:move direction:@"backward"];
			
			[board.moveListView highlightMoveWithAbsoluteMoveNumber:[StreamController sharedStreamController].currentMoveNumber animated:YES];
		}
	}
}

- (void)goForward {
	if ([StreamController sharedStreamController].server == FICS) {
		if([StreamController sharedStreamController].currentMoveNumber < [StreamController sharedStreamController].absoluteMoveNumber) {
			NSMutableArray *moveList = [StreamController sharedStreamController].moveList;
			[StreamController sharedStreamController].currentMoveNumber++;
			NSString *style12string = (NSString *)[moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber - 1];
			[self setPositionFromStyle12:style12string];
			
			[board.moveListView highlightMoveWithAbsoluteMoveNumber:[StreamController sharedStreamController].currentMoveNumber animated:YES];
		}
		else {
			//MoveListView *mlv = board.moveListView
			if (board.moveListView.hasEndLabel) {
				[board.moveListView scrollToEndLabel];
			}
			else {
				NSEnumerator *enumerator = [[board.moveListView subviews] objectEnumerator];
				UILabel *tempView;// = [[UILabel alloc] init];
				while (tempView = [enumerator nextObject]) {
					if ([tempView isKindOfClass:[UILabel class]]) {
						if (tempView.tag == [StreamController sharedStreamController].absoluteMoveNumber) {
							tempView.textColor = [UIColor colorWithRed:0.7 green:0 blue:0 alpha:1];
						}
						else {
							tempView.textColor = [UIColor lightTextColor];
						}
					}
				}
			}
		}
	}
	else {
		if([StreamController sharedStreamController].currentMoveNumber < [StreamController sharedStreamController].absoluteMoveNumber) {
			[StreamController sharedStreamController].currentMoveNumber++;
			NSMutableArray *moveList = [StreamController sharedStreamController].moveList;
			Move *move = (Move *)[moveList objectAtIndex:[StreamController sharedStreamController].currentMoveNumber - 1];
			[self move:move direction:@"forward"];
			
			[board.moveListView highlightMoveWithAbsoluteMoveNumber:[StreamController sharedStreamController].currentMoveNumber animated:YES];
		}
		else {
			//MoveListView *mlv = board.moveListView
			if (board.moveListView.hasEndLabel) {
				[board.moveListView scrollToEndLabel];
			}
			else {
				NSEnumerator *enumerator = [[board.moveListView subviews] objectEnumerator];
				UILabel *tempView;// = [[UILabel alloc] init];
				while (tempView = [enumerator nextObject]) {
					if ([tempView isKindOfClass:[UILabel class]]) {
						if (tempView.tag == [StreamController sharedStreamController].absoluteMoveNumber) {
							tempView.textColor = [UIColor colorWithRed:0.7 green:0 blue:0 alpha:1];
						}
						else {
							tempView.textColor = [UIColor lightTextColor];
						}
					}
				}
			}
		}
	}
}

- (void)flipBoard {
	CGAffineTransform transform=CGAffineTransformIdentity;
	if (!flipped) {
		transform=CGAffineTransformRotate(transform, (180.0f*22.0f)/(180.0f*7.0f));
		flipped = YES;
		
		board.blackPlayerLabel.frame = CGRectMake(10, 350, 225, 18);
		board.whitePlayerLabel.frame = CGRectMake(10, 4, 225, 18);
		
		board.blackTimeLabel.frame = CGRectMake(240, 350, 70, 18);
		board.whiteTimeLabel.frame = CGRectMake(240, 4, 70, 18);
	}
	else {
		transform=CGAffineTransformRotate(transform, (0.0f*22.0f)/(180.0f*7.0f));
		flipped = NO;
		
		board.blackPlayerLabel.frame = CGRectMake(10, 4, 225, 18);
		board.whitePlayerLabel.frame = CGRectMake(10, 350, 225, 18);
		
		board.blackTimeLabel.frame = CGRectMake(240, 4, 70, 18);
		board.whiteTimeLabel.frame = CGRectMake(240, 350, 70, 18);
	}
	
	[board.board setTransform:transform];
	
	for (UIView *piece in [board.board subviews]) {
		if ([piece isKindOfClass:[PieceImageView class]]) {
			[piece setTransform:transform];
		}
	}
}

- (void)resetResults {
	resultText = @"";
	iccResultText = @"";
}

- (void)setResultText:(NSString *)resText {
	resultText = resText;
}

- (void)setIccResultText:(NSString *)iccResText {
	iccResultText = iccResText;
}

@end
