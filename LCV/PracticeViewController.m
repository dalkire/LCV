//
//  PuzzleBoardViewController.m
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#define TRAINING    201

#import "PracticeViewController.h"

@implementation PracticeViewController

@synthesize toolbar             = _toolbar;
@synthesize trainingView        = _trainingView;
@synthesize blackName           = _blackName;
@synthesize whiteName           = _whiteName;
@synthesize inStartingPosition  = _inStartingPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)loadView
{    
    float width = 0;
    float height = 0;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            width = [UIScreen mainScreen].bounds.size.height;
            height = [UIScreen mainScreen].bounds.size.width;
            break;
            
        default:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    UIBarButtonItem *menuBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-menu.png"] 
                                                               style:UIBarButtonItemStyleBordered 
                                                              target:self 
                                                              action:@selector(didTouchMenu)];
    /*UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                               target:self 
                               action:@selector(didTouchEdit)];
    UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-add.png"] 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(addCourseModal)];*/
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
    _toolbar = [[UIToolbar alloc] init];
    [_toolbar setBarStyle:UIBarStyleBlack];
    [_toolbar sizeToFit];
    [_toolbar setItems:[NSArray arrayWithObjects:menuBtn, flex, nil]];
    
    [view addSubview:_toolbar];
    [view setBackgroundColor:[UIColor yellowColor]];
    
    _trainingView = [[PracticeView alloc] initWithFrame:CGRectMake(0, 44, 320, 420)];
    [[_trainingView board] setUserInteractionEnabled:YES];
    [view addSubview:_trainingView];
    [self setInStartingPosition:YES];
    
    [self setView:view];
    [_toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view release];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)processServerReply:(NSString *)reply
{
    NSLog(@"SERVER REPLY: %@", reply);
}

- (void)didTouchMenu
{
    [[StreamController sharedStreamController] setMode:TRAINING];
    [[StreamController sharedStreamController] setTrainingViewController:self];
    [[StreamController sharedStreamController] sendCommand:[NSMutableString stringWithString:@"tell puzzlebot gm2\r\n"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - board functions


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

- (void)setPositionFromStyle12:(NSString *)style12 {
    NSLog(@"IN SET 12: %@", style12);
	[[_trainingView board] clearBoard];
	NSArray *style12Array = [style12 componentsSeparatedByString:@" "];
	NSString *verboseMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:26]];
	//NSString *algebraicMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:28]];
	NSString *colorForNextMove = [[NSString alloc] initWithString:(NSString *)[style12Array objectAtIndex:8]];
	[[StreamController sharedStreamController] setCanMoveColor:colorForNextMove];
    
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
				[[_trainingView board] addPiece:[NSString stringWithFormat:@"%@%@", color, charAsString] toSquare:[NSString stringWithFormat:@"%@%d", file, 8-i]];
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
			[[_trainingView board] placeHighlightsForMove:@"e1g1"];
		}
		else if ([colorForNextMove isEqualToString:@"W"]) {
			//black just moved
			[[_trainingView board] placeHighlightsForMove:@"e8g8"];
		} 
	}
	else if ([verboseMove isEqualToString:@"o-o-o"]) {
		//castle long
		if ([colorForNextMove isEqualToString:@"B"]) {
			//white just moved
			[[_trainingView board] placeHighlightsForMove:@"e1c1"];
		}
		else if ([colorForNextMove isEqualToString:@"W"]) {
			//black just moved
			[[_trainingView board] placeHighlightsForMove:@"e8c8"];
		} 
	}
	else {
		[[_trainingView board] placeHighlightsForMove:[NSString stringWithFormat:@"%@%@", [verboseMove substringWithRange:NSMakeRange(2, 2)], [verboseMove substringWithRange:NSMakeRange(5, 2)]]];
	}
	
	NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
	NSNumber *standardMoveNum = [nf numberFromString:[style12Array objectAtIndex:25]];
	NSNumber *absMoveNum = [[NSNumber alloc] initWithInteger:[standardMoveNum integerValue]*2];
	if ([colorForNextMove isEqualToString:@"B"]) {
		absMoveNum = [NSNumber numberWithInt:[absMoveNum intValue]-1];
	}
	else if ([colorForNextMove isEqualToString:@"W"]) {
		absMoveNum = [NSNumber numberWithInt:[absMoveNum intValue]-2];
	}
}

- (void)movePieceFromSquare:(NSString *)fromSquare toSquare:(NSString *)toSquare
{
    NSLog(@"movePieceFromSquare:%@ toSquare:%@", fromSquare, toSquare);
    [[StreamController sharedStreamController] sendCommand:[NSString stringWithFormat:@"%@%@\r\n", fromSquare, toSquare]];
    [[_trainingView board] placeHighlightsForMove:[NSString stringWithFormat:@"%@%@", fromSquare, toSquare]];
}

@end
