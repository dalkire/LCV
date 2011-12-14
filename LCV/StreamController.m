//
//  StreamController.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "StreamController.h"
#import "Definitions.h"
#import "BoardViewController.h"
#import "CurrentGamesViewController.h"
#import "Move.h"

// This is a singleton class, see below
static StreamController *sharedStreamControllerDelegate = nil;

@implementation StreamController

@synthesize delegate = _delegate;
@synthesize sentConnectMessage = _sentConnectMessage;
@synthesize testString;
@synthesize iStream;
@synthesize oStream;
@synthesize currentGames;
@synthesize observeString;
@synthesize prevStyle12String;
@synthesize currStyle12String;
@synthesize moveString;
@synthesize level1Command;
@synthesize level2Command;
@synthesize moveList;
@synthesize ficsMoveList;
@synthesize level1Depth;
@synthesize absoluteMoveNumber, currentMoveNumber, currentFicsLocalMoveNumber, observing;
@synthesize firstPass;
@synthesize firstStyle12;
@synthesize streamFirstReady;
@synthesize spaceAvailable;
@synthesize readingCurrentGames;
@synthesize inLevel2;
@synthesize clockRunning;
@synthesize currentLevel1Command;
@synthesize currentLevel2Command;
@synthesize caller;
@synthesize boardViewController;
@synthesize currentGamesViewController = _currentGamesViewController;
@synthesize watchingViewController = _watchingViewController;
@synthesize practiceViewController = _practiceViewController;
@synthesize mainViewController;
@synthesize resultText, iccResultText;
@synthesize server = _server;
@synthesize mode = _mode;
@synthesize canMoveColor = _canMoveColor;
@synthesize puzzleGameNumber = _puzzleGameNumber;

#pragma mark ---- singleton object methods ----

+ (StreamController *)sharedStreamController {
	@synchronized(self) {
		if (sharedStreamControllerDelegate == nil) {
			[[self alloc] init];
		}
	}
	return sharedStreamControllerDelegate;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedStreamControllerDelegate == nil) {
			sharedStreamControllerDelegate = [super allocWithZone:zone];
			return sharedStreamControllerDelegate;
		}
	}
	return nil;
}

- (id)init {
    _delegate = nil;
    _sentConnectMessage = NO;
	NSTimer *timer;
    //[[timer alloc] init];
	//timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	firstPass = YES;
	spaceAvailable = NO;
	clockRunning = NO;
	firstStyle12 = YES;
	streamFirstReady = YES;
	currentLevel1Command = CN_NONE;
	currentLevel2Command = CN_NONE;
	level1Depth = 0;
	absoluteMoveNumber = 0;
	currentFicsLocalMoveNumber = 0;
	observing = 0;
	level1Command = [NSMutableString new];
	caller = nil;
	currentGames = [NSMutableString new];
	observeString = [NSMutableString new];
	testString = [NSMutableString new];
	prevStyle12String = [[NSMutableString alloc] initWithString:@""];
	currStyle12String = [[NSMutableString alloc] initWithString:@""];
	moveString = [[NSMutableString alloc] initWithString:@""];
	moveList = [NSMutableArray new];
	ficsMoveList = [NSMutableArray new];
	resultText = [[NSString alloc] initWithString:@""];
	iccResultText = [[NSString alloc] initWithString:@""];
	[self setServer:NONE];
	readingCurrentGames = NO;
    _practiceViewController = (PracticeViewController *)NULL;
    _canMoveColor = [[NSString alloc] initWithString:@""];
    _puzzleGameNumber = 0;
    
	
	/*SInt32 port = 5000;
	CFReadStreamRef readStream = NULL;
	CFWriteStreamRef writeStream = NULL;
	
	CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, CFSTR("chessclub.com"), port, &readStream, &writeStream);
	
	iStream = (NSInputStream *)readStream;
	oStream = (NSOutputStream *)writeStream;
	
	[iStream setDelegate:self];
	[oStream setDelegate:self];
	[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream open];
	[oStream open];*/
	return self;
}

- (void)connect {
	CFStringRef serverAddress = CFSTR("chessclub.com");
	NSMutableString *firstCommand;// = [[NSString alloc] initWithString:@""];
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *iccusername = [[defaults valueForKey:@"iccusername"] isEqualToString:@""] || [defaults valueForKey:@"iccusername"] == NULL ? @"guest" : [defaults valueForKey:@"iccusername"];
	NSString *iccpassword = [defaults valueForKey:@"iccpassword"];
	if ([iccusername isEqualToString:@"g"] || [iccusername isEqualToString:@"guest"]) {
		[self setServer:FICS];
		serverAddress = CFSTR("freechess.org");
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Guest Account" 
							  message:@"You are being logged in as a guest.\n To log in with your ICC or FICS account enter your account information in Application Settings." 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil]; 
		//[alert show]; 
		[alert release];
		firstCommand = [[NSMutableString alloc] initWithFormat:@"guest\r\n\r\n\r\nstyle 12\r\n"];
	}
	else {
		[self setServer:ICC];
		serverAddress = CFSTR("chessclub.com");
		firstCommand = [[NSMutableString alloc] initWithFormat:@"level1=1\r\n%@\r\n%@\r\nset-2 16 1\r\nset-2 24 1\r\nset-2 25 1\r\nset-2 33 1\r\nset-2 34 1\r\nset-2 36 1\r\n", iccusername, iccpassword];
	}

	
	SInt32 port = 5000;
	CFReadStreamRef readStream = NULL;
	CFWriteStreamRef writeStream = NULL;
	
	CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, serverAddress, port, &readStream, &writeStream);
	
	iStream = (NSInputStream *)readStream;
	oStream = (NSOutputStream *)writeStream;
	
	[iStream setDelegate:self];
	[oStream setDelegate:self];
	[oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream open];
	[oStream open];
	
	
	[self sendCommand:firstCommand];
}

- (void)disconnect {
	[oStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [iStream close];
	[oStream close];
}

- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

- (id)retain {
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;
}

- (id)autorelease {
	return self;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
	if (spaceAvailable == YES) {
	}
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
			if (stream == iStream) {
                if (!_sentConnectMessage) {
                    [_delegate didConnect];
                    _sentConnectMessage = YES;
                }
                
				UInt8 rbuf[1024];
				int bytesRead = CFReadStreamRead((CFReadStreamRef)stream, rbuf, 1000);
				rbuf[bytesRead] = 0;
				CFMutableStringRef cfReplyContent = CFStringCreateMutable(kCFAllocatorDefault, 0);
				CFStringAppendCString(cfReplyContent, (const char *)rbuf, kCFStringEncodingASCII);
				NSLog(@"%@", (NSMutableString *)cfReplyContent);
                if (_server == FICS) {
                    if ([self mode] == PRACTICING && _practiceViewController) {
                        
                        if ([(NSMutableString *)cfReplyContent rangeOfString:@"\r<12>"].location != NSNotFound) {
                            NSMutableArray *contentArray = [[NSMutableArray alloc] initWithArray:[(NSMutableString *)cfReplyContent componentsSeparatedByString:@"\r"]];
                            for (int i=0; i < [contentArray count]; i++) {
                                if([(NSString *)[contentArray objectAtIndex:i] length] > 4 && [[[contentArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"<12>"]) {
                                    [ficsMoveList addObject:[[contentArray objectAtIndex:i] substringFromIndex:5]];
                                    currentFicsLocalMoveNumber++;
                                    prevStyle12String = currStyle12String;
                                    currStyle12String = (NSMutableString *)[[contentArray objectAtIndex:i] substringFromIndex:5];
                                
                                    clockRunning = YES;
                                    [moveList addObject:currStyle12String];
                                
                                    /*if (currentMoveNumber == absoluteMoveNumber) {
                                        [(BoardViewController *)boardViewController setPositionFromStyle12:currStyle12String direction:@"forward"];
                                        currentMoveNumber++;
                                    }*/
                                    absoluteMoveNumber++;
                                    NSLog(@"CLF=%d, CUR=%d, ABS=%d", currentFicsLocalMoveNumber, currentMoveNumber, absoluteMoveNumber);
                                
                                    NSLog(@"%@", (NSMutableString *)cfReplyContent);
                                    [(PracticeViewController *)_practiceViewController setPositionFromStyle12:currStyle12String];
                                }
                            }
                        }
                        
                        NSError *error = NULL;
                        NSRegularExpression *practiceKibitz = [NSRegularExpression regularExpressionWithPattern:@"\\rpuzzlebot.*kibitzes: (.*)\\n" options:NSRegularExpressionCaseInsensitive error:&error];
                        NSArray *practiceKibitzMatches = [practiceKibitz matchesInString:(NSMutableString *)cfReplyContent options:0 range:NSMakeRange(0, [(NSMutableString *)cfReplyContent length])];
                        
                        for (NSTextCheckingResult *practiceKibitzMatch in practiceKibitzMatches) {
                            //NSRange matchRange = [practiceKibitzMatch range];
                            NSRange firstMatchRange = [practiceKibitzMatch rangeAtIndex:1];
                            NSLog(@"MATCH: %@", [(NSMutableString *)cfReplyContent substringWithRange:firstMatchRange]);
                            NSString *kText = [NSString stringWithString:[[[_practiceViewController practiceView] kibitzTextView] text]];
                            NSString *kibitzText = [NSString stringWithFormat:@"%@\n\n%@", kText, [(NSMutableString *)cfReplyContent substringWithRange:firstMatchRange]];
                            [[[_practiceViewController practiceView] kibitzTextView] setText:kibitzText];
                            [[[_practiceViewController practiceView] kibitzTextView] scrollRangeToVisible:NSMakeRange([kibitzText length], 0)];
                        }
                    } //PRACTICE
                    else if ([self mode] == WATCHING && _watchingViewController) {
                        if ([(NSMutableString *)cfReplyContent rangeOfString:@"~~startgames"].location != NSNotFound) {
                            readingCurrentGames = YES;
                        }
                        if (readingCurrentGames) {
                            [currentGames appendFormat:@"%@", (NSMutableString *)cfReplyContent];
                        }				
                        if ([(NSMutableString *)cfReplyContent rangeOfString:@"~~endgames"].location != NSNotFound) {
                            readingCurrentGames = NO;
                            NSArray *myarr = [currentGames componentsSeparatedByString:@"\n"];
                            NSMutableString *fullGames = [[NSMutableString alloc] initWithString:@""];
                            for (int i = [myarr count] - 1; i >= 0; i--) {
                                NSArray *mya = [[myarr objectAtIndex:i] componentsSeparatedByString:@"\r"];
                                if ([mya count] > 1 && [[mya objectAtIndex:1] rangeOfString:@"++++"].location == NSNotFound && [[mya objectAtIndex:1] rangeOfString:@"----"].location == NSNotFound && [[mya objectAtIndex:1] rangeOfString:@"(Exam."].location == NSNotFound) {
                                    NSLog(@"%@", [mya objectAtIndex:1]);
                                    [fullGames appendFormat:@"%@\r\n", [mya objectAtIndex:1]];
                                }
                            }
                            [(CurrentGamesViewController *)_currentGamesViewController commandResult:(NSString *)fullGames fromCommand:155];
                        }	
                        if ([(NSMutableString *)cfReplyContent rangeOfString:@"\r<12>"].location != NSNotFound) {
                            NSMutableArray *contentArray = [[NSMutableArray alloc] initWithArray:[(NSMutableString *)cfReplyContent componentsSeparatedByString:@"\r"]];
                            for (int i=0; i < [contentArray count]; i++) {
                                if([(NSString *)[contentArray objectAtIndex:i] length] > 4 && [[[contentArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"<12>"]) {
                                    [ficsMoveList addObject:[[contentArray objectAtIndex:i] substringFromIndex:5]];
                                    currentFicsLocalMoveNumber++;
                                    prevStyle12String = currStyle12String;
                                    currStyle12String = (NSMutableString *)[[contentArray objectAtIndex:i] substringFromIndex:5];
                                    
                                    clockRunning = YES;
                                    [moveList addObject:currStyle12String];
                                    
                                    if (currentMoveNumber == absoluteMoveNumber) {
                                     [_watchingViewController setPositionFromStyle12:currStyle12String];
                                     currentMoveNumber++;
                                     }
                                    absoluteMoveNumber++;
                                    NSLog(@"CLF=%d, CUR=%d, ABS=%d", currentFicsLocalMoveNumber, currentMoveNumber, absoluteMoveNumber);
                                }
                            }
                        }
                    }
                }
                else if (_server == ICC) {
                    //NSLog(@"SERVER is ICC");
                }
				
				/*if ([(NSMutableString *)cfReplyContent rangeOfString:@"\rfics%"].location != NSNotFound && streamFirstReady) {
					if ([[StreamController sharedStreamController].server isEqualToString:@"fics"]) {
						[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"~~startgames\r\ngames /b\r\n~~endgames\r\n" fromViewController:(UITableViewController *)self];
					}
					streamFirstReady = NO;
				}
				NSLog(@"%@", (NSMutableString *)cfReplyContent);
				if ([(NSMutableString *)cfReplyContent rangeOfString:@"~~startgames"].location != NSNotFound) {
					readingCurrentGames = YES;
				}
				if (readingCurrentGames) {
					[currentGames appendFormat:@"%@", (NSMutableString *)cfReplyContent];
				}				
				if ([(NSMutableString *)cfReplyContent rangeOfString:@"~~endgames"].location != NSNotFound) {
					readingCurrentGames = NO;
					NSArray *myarr = [currentGames componentsSeparatedByString:@"\n"];
					NSMutableString *fullGames = [[NSMutableString alloc] initWithString:@""];
					for (int i = [myarr count] - 1; i >= 0; i--) {
						NSArray *mya = [[myarr objectAtIndex:i] componentsSeparatedByString:@"\r"];
						if ([mya count] > 1 && [[mya objectAtIndex:1] rangeOfString:@"++++"].location == NSNotFound && [[mya objectAtIndex:1] rangeOfString:@"----"].location == NSNotFound && [[mya objectAtIndex:1] rangeOfString:@"(Exam."].location == NSNotFound) {
							NSLog(@"%@", [mya objectAtIndex:1]);
							[fullGames appendFormat:@"%@\r\n", [mya objectAtIndex:1]];
						}
					}
					[(CurrentGamesViewController *)currentGamesViewController commandResult:(NSString *)fullGames fromCommand:155];
				}	
				
				if ([(NSMutableString *)cfReplyContent rangeOfString:@"\r<12>"].location != NSNotFound) {
					
					NSMutableArray *contentArray = [[NSMutableArray alloc] initWithArray:[(NSMutableString *)cfReplyContent componentsSeparatedByString:@"\r"]];
					for (int i=0; i < [contentArray count]; i++) {
						if([(NSString *)[contentArray objectAtIndex:i] length] > 4 && [[[contentArray objectAtIndex:i] substringWithRange:NSMakeRange(0, 4)] isEqualToString:@"<12>"]) {
							[ficsMoveList addObject:[[contentArray objectAtIndex:i] substringFromIndex:5]];
							currentFicsLocalMoveNumber++;
							prevStyle12String = currStyle12String;
							currStyle12String = (NSMutableString *)[[contentArray objectAtIndex:i] substringFromIndex:5];
							//moveString = [NSMutableString stringWithString:[[contentArray objectAtIndex:i] substringFromIndex:5]];
							//if (firstStyle12) {
							clockRunning = YES;
							[moveList addObject:currStyle12String];
							NSLog(@"%@", currStyle12String);
							if (currentMoveNumber == absoluteMoveNumber) {
								[(BoardViewController *)boardViewController setPositionFromStyle12:currStyle12String direction:@"forward"];
								currentMoveNumber++;
							}
							absoluteMoveNumber++;
							NSLog(@"CLF=%d, CUR=%d, ABS=%d", currentFicsLocalMoveNumber, currentMoveNumber, absoluteMoveNumber);
								//firstStyle12 = NO;
							//}
							//else {
								
								//NSLog(@"SMITH: %@", [self toSmithFromPreviousStyle12:prevStyle12String andCurrentStyle12:currStyle12String]);
							//}
							//NSLog(@"FML = %d", currentFicsLocalMoveNumber);
							//for (int j=0; j < [ficsMoveList count]; j++) {
								//NSLog(@"FML** %@", [ficsMoveList objectAtIndex:j]);
							//}
						}
					}
					
				}
				CurrentGamesViewController *cgvc = (CurrentGamesViewController *)currentGamesViewController;
				if ([(NSMutableString *)cfReplyContent rangeOfString:[NSString stringWithFormat:@"\r{Game %@", cgvc.observing]].location != NSNotFound) {
					
					NSUInteger begin = [(NSMutableString *)cfReplyContent rangeOfString:[NSString stringWithFormat:@"\r{Game %@", cgvc.observing]].location;
					NSArray *resultArr = [[(NSMutableString *)cfReplyContent substringFromIndex:begin + 1] componentsSeparatedByString:@"\r"];
					NSString *gameEndString = [resultArr objectAtIndex:0];
					
					NSArray *commandComponents = [gameEndString componentsSeparatedByString:@" "];
					NSMutableString *msg = [[NSMutableString alloc] initWithString:@""];
					
					for (int i=5; i<[commandComponents count] - 1; i++) {
						[msg appendFormat:@" %@", [commandComponents objectAtIndex:i]];
					}
					msg = (NSMutableString *)[msg substringWithRange:NSMakeRange(1, [msg length] - 2)];
					NSLog(@"|%@|", msg);
					UIAlertView *alert = [[UIAlertView alloc] 
										  initWithTitle:[NSString stringWithFormat:@"Game Ended: %@", [commandComponents lastObject]]
										  message:msg 
										  delegate:self 
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
					
					[(BoardViewController *)boardViewController addEndLabelResult:[commandComponents lastObject] iccResult:msg absoluteMoveNumber:absoluteMoveNumber];
					self.resultText = [commandComponents lastObject];
					self.iccResultText = msg;
					[alert show]; 
					[alert release];
					//[title release];
					//[msg release];
					//[lev2 release];
					clockRunning = NO;
					CurrentGamesViewController *gvc = (CurrentGamesViewController *)self.currentGamesViewController;
					gvc.observing = NULL;
				}
				
				for (int i=0; i<[(NSMutableString *)cfReplyContent length]; i++) {
					[testString appendFormat:@"%c", [(NSMutableString *)cfReplyContent characterAtIndex:i]];
					
					if (prev == '\031' && [(NSMutableString *)cfReplyContent characterAtIndex:i] == '[') {
						level1Depth++;
						//NSLog(@"LEVEL 1 Depth: %d", level1Depth);
					}
					else if (prev == '\031' && [(NSMutableString *)cfReplyContent characterAtIndex:i] == ']') {
						level1Depth--;
						//NSLog(@"LEVEL 1 Depth: %d", level1Depth);
						if (level1Depth == 0) {
							//NSLog(@"TEST STRING:\n%@", testString);
							[self delegateLevel1Command:testString];
							[testString setString:@""];
						}
					}
					prev = [(NSMutableString *)cfReplyContent characterAtIndex:i];
				}*/
			}
            break;
		case NSStreamEventHasSpaceAvailable:
			spaceAvailable = YES;
			break;
		case NSStreamEventEndEncountered:
			//NSLog(@"Stream event end encountered");
            [stream close];
			
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
			 
							  forMode:NSDefaultRunLoopMode];
			
            [stream release];
			
            stream = nil; // stream is ivar, so reinit it
			spaceAvailable = NO;
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Error:" 
								  message:@"Connection has been lost." 
								  delegate:self 
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil]; 
			[alert show]; 
			[alert release]; 
            break;
		case NSStreamEventErrorOccurred: {
            //NSError *theError = [stream streamError];
			
            //NSLog(@"Error reading stream!");
			
            //NSLog(@"Error %i: %@", [theError code], [theError localizedDescription]);
            [stream close];
			
            [stream release];
			spaceAvailable = NO;
			UIAlertView *alert = [[UIAlertView alloc] 
								  initWithTitle:@"Error:" 
								  message:@"Connection has been lost." 
								  delegate:self 
								  cancelButtonTitle:@"OK"
								  otherButtonTitles:nil]; 
			[alert show]; 
			[alert release]; 
            //[self connect];
            break;
		}
	}
}

- (void)sendCommand:(NSMutableString *)command fromViewController:(UITableViewController *)viewController {
	while(!spaceAvailable) {
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSData *data = [command dataUsingEncoding:NSASCIIStringEncoding];
	[oStream write:[data bytes] maxLength:[data length]];

	caller = viewController;
}

- (void)sendCommand:(NSMutableString *)command {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSData *data = [command dataUsingEncoding:NSASCIIStringEncoding];
	[oStream write:[data bytes] maxLength:[data length]];
}

- (void)delegateLevel1Command:(NSMutableString *)command {
	//NSLog(@"FULL LEVEL 1 COMMAND:\n%@", command);
	if ([command rangeOfString:@"\031[20 *\r\nInvalid username"].location != NSNotFound) {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Invalid Username" 
							  message:@"Verify your account in\nApplication Settings" 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil]; 
		[alert show]; 
		[alert release]; 
		return;
	}	
	
	if ([command rangeOfString:@"\031[21 *\r\n"].location != NSNotFound && [command rangeOfString:@"\r\nInvalid password.\r\n"].location != NSNotFound) {
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"Invalid Password" 
							  message:@"Verify your account in\nApplication Settings" 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil]; 
		[alert show]; 
		[alert release]; 
		return;
	}
	
	if ([command rangeOfString:@"\031[137 *\r\nThere is no such game"].location != NSNotFound) {
		NSLog(@"No Such Game COMMAND:\n%@", command);
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:@"No Such Game" 
							  message:@"The game is no longer being played." 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil]; 
		[alert show]; 
		[alert release]; 
		return;
	}
	
	if ([command rangeOfString:@"\031[155 *\r\n"].location != NSNotFound) {
		NSUInteger startLocation = ([command rangeOfString:@"\031[155 *\r\n"].location != NSNotFound) ? [command rangeOfString:@"\031[155 *\r\n"].location : 0;
		NSRange range = NSMakeRange(startLocation, [command rangeOfString:@"\031]"].location + 2);
		[currentGames appendString:[command substringWithRange:range]];
		[(CurrentGamesViewController *)_currentGamesViewController commandResult:currentGames fromCommand:155];
		
	}
	else {
		[currentGames setString:@""];
	}
	
	if ([command rangeOfString:@"[12 *"].location != NSNotFound) {
		NSLog(@"MY [12 * !!!");
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		if ([defaults valueForKey:@"iccusername"] == NULL || [[defaults valueForKey:@"iccusername"] isEqualToString:@""] || [[defaults valueForKey:@"iccusername"] isEqualToString:@"g"] || [[defaults valueForKey:@"iccusername"] isEqualToString:@"guest"]) {
			//NSLog(@"GUEST");
			[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"games *-T-r-w-L-d-z-e-o\r\n" fromViewController:(UITableViewController *)_currentGamesViewController];
		}
		else {
			//NSLog(@"NON_GUEST");
			[[StreamController sharedStreamController] sendCommand:(NSMutableString *)@"games *R-w-L-d-z-e-o\r\n" fromViewController:(UITableViewController *)_currentGamesViewController];
		}
	}
	
	if ([command rangeOfString:@"\031[137 *\r\n"].location != NSNotFound) {
		if ([command rangeOfString:@"\031]"].location != NSNotFound) {
			currentLevel1Command = CN_NONE;
			NSUInteger startLocation = ([command rangeOfString:@"\031[137 *\r\n"].location != NSNotFound) ? [command rangeOfString:@"\031[137 *\r\n"].location : 0;
			NSRange range = NSMakeRange(startLocation, [command rangeOfString:@"\031]"].location + 2);
			[observeString appendString:[command substringWithRange:range]];
			if ([observeString rangeOfString:@"\031(25"].location != NSNotFound) {
				NSRange command25Range = NSMakeRange([observeString rangeOfString:@"\031(25"].location + 2, [observeString rangeOfString:@"\031)"].location - [observeString rangeOfString:@"\031(25"].location - 2);
				[self delegateLevel2Command:(NSMutableString *)[observeString substringWithRange:command25Range]];
			}
		}
	}
	else {
		[observeString setString:@""];
	}
	
	if ([command rangeOfString:@"\031[2 "].location != NSNotFound || currentLevel1Command == 2) {
		currentLevel1Command = 2;
		if ([command rangeOfString:@"\031]"].location != NSNotFound) {
			currentLevel1Command = CN_NONE;
			[self delegateLevel2Command:(NSMutableString *)[command substringWithRange:NSMakeRange([command rangeOfString:@"\031(24"].location + 2, [command rangeOfString:@"\031)"].location - [command rangeOfString:@"\031(24"].location - 2)]];
		}
	}
	else {
		[moveString setString:@""];
	}
	
	if ([command rangeOfString:@"\031(16 "].location != NSNotFound && [command rangeOfString:@"\031)"].location != NSNotFound) {
		NSString *gameEndString = [command substringWithRange:NSMakeRange([command rangeOfString:@"\031(16 "].location + 2, [command rangeOfString:@"\031)" options:NSBackwardsSearch].location - [command rangeOfString:@"\031(16 "].location - 1)];
		NSLog(@"gameEndString: %@", gameEndString);
		NSArray *commandComponents = [gameEndString componentsSeparatedByString:@" "];
		
		NSString *lev2 = [[NSString alloc] initWithFormat:@"%@", [command substringWithRange:NSMakeRange([command rangeOfString:@"\031(16 "].location, [command rangeOfString:@"\031)" options:NSBackwardsSearch].location - [command rangeOfString:@"\031(16 "].location)]];
		NSString *msg = [[NSString alloc] initWithFormat:@"%@", [lev2 substringWithRange:NSMakeRange([lev2 rangeOfString:@"{"].location + 1, [lev2 rangeOfString:@"}"].location - [lev2 rangeOfString:@"{"].location - 1)]];
		UIAlertView *alert = [[UIAlertView alloc] 
							  initWithTitle:[NSString stringWithFormat:@"Game Ended: %@", [commandComponents objectAtIndex:4]]
							  message:msg 
							  delegate:self 
							  cancelButtonTitle:@"OK" 
							  otherButtonTitles:nil];
		
		[(BoardViewController *)boardViewController addEndLabelResult:[commandComponents objectAtIndex:4] iccResult:msg absoluteMoveNumber:absoluteMoveNumber];
		self.resultText = [commandComponents objectAtIndex:4];
		self.iccResultText = msg;
		[alert show]; 
		[alert release];
		//[title release];
		//[msg release];
		//[lev2 release];
		clockRunning = NO;
		CurrentGamesViewController *gvc = (CurrentGamesViewController *)_currentGamesViewController;
		gvc.observing = NULL;
	}
}

- (void)delegateLevel2Command:(NSMutableString *)command {
	NSInteger level2CommandNumber = [self getLevel2CommandNumber:command];
	//NSLog(@"Level2CommandNumber: %d", level2CommandNumber);
	
	if (level2CommandNumber == DG_SEND_MOVES) {
		NSArray *commandComponents = [command componentsSeparatedByString:@" "];
		NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
		Move *move = [[Move alloc] init];
		move.algebraic = [commandComponents objectAtIndex:2];
		move.smith = [commandComponents objectAtIndex:3];
		move.timeLeftInSeconds = [nf numberFromString:[commandComponents objectAtIndex:4]];
		
		[moveList addObject:move];
		if (currentMoveNumber == absoluteMoveNumber) {
			currentMoveNumber++;
		}
		absoluteMoveNumber++;
		
		if (currentMoveNumber == absoluteMoveNumber) {
			[(BoardViewController *)boardViewController move:move direction:@"forward"];
		}
		[(BoardViewController *)boardViewController addToMoveListView:move.algebraic withAbsoluteMoveNumber:absoluteMoveNumber animated:YES];
	}
	else if (level2CommandNumber == DG_MOVE_LIST) {
		clockRunning = YES;
		moveString = [NSMutableString stringWithFormat:@""];
		moveList = [NSMutableArray new];
		absoluteMoveNumber = 0;
		currentMoveNumber = 0;
		
		NSRange range;
		range = NSMakeRange([command rangeOfString:@"{"].location + 1, [command rangeOfString:@"}" options:NSBackwardsSearch].location - [command rangeOfString:@"{"].location - 1);
		command = (NSMutableString *)[command substringWithRange:range];
		NSArray *moveArray = [command componentsSeparatedByString:@"}{"];
		[(BoardViewController *)boardViewController resetBoard];
		
		NSEnumerator *enumerator = [moveArray objectEnumerator];
		NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
		while (moveString = [enumerator nextObject]) {
			NSArray *moveComponents = [moveString componentsSeparatedByString:@" "];
			Move *move = [[Move alloc] init];
			move.algebraic = [moveComponents objectAtIndex:0];
			move.smith = [moveComponents objectAtIndex:1];
			move.timeLeftInSeconds = [nf numberFromString:[moveComponents objectAtIndex:2]];
			[moveList addObject:move];
			absoluteMoveNumber++;
			currentMoveNumber++;
			
			[(BoardViewController *)boardViewController addToMoveListView:move.algebraic withAbsoluteMoveNumber:absoluteMoveNumber animated:NO];
		}
		
		[(BoardViewController *)boardViewController moveList:moveList];
	}
}

- (NSInteger)getLevel2CommandNumber:(NSMutableString *)command {
	NSRange range = NSMakeRange(0, [command rangeOfString:@" "].location);
	return [[command substringWithRange:range] integerValue];
}

- (void)registerViewController:(UIViewController *)controller {	
	if ([controller.title isEqualToString:@"BoardViewController"]) {
		self.boardViewController = controller;
	}
	else if ([controller.title isEqualToString:@"CurrentGamesViewController"]) {
		_currentGamesViewController = controller;
	}
}

- (void)gameEndedWithCode:(NSString *)rawCode {
	//NSLog(@"GameEndedWithRawCode: %@", rawCode);
}

- (void)timerFireMethod:(NSTimer *)theTimer {
	if (_server == ICC) {
		if (clockRunning) {
			if (absoluteMoveNumber %2 == 0 && absoluteMoveNumber > 0 && currentMoveNumber == absoluteMoveNumber) {
				[(BoardViewController *)boardViewController decrementTimeForColor:@"white"];
			}
			else if (absoluteMoveNumber %2 == 1 && absoluteMoveNumber > 0 && currentMoveNumber == absoluteMoveNumber) {
				[(BoardViewController *)boardViewController decrementTimeForColor:@"black"];
			}
		}
	}
	else if (_server == FICS) {
		if (clockRunning) {
			NSArray *moveArray = [(NSString *)[ficsMoveList objectAtIndex:currentFicsLocalMoveNumber-1] componentsSeparatedByString:@" "];
			if ([(NSString *)[moveArray objectAtIndex:8] isEqualToString:@"W"]) {
				[(BoardViewController *)boardViewController decrementTimeForColor:@"white"];
			}
			else if ([(NSString *)[moveArray objectAtIndex:8] isEqualToString:@"B"]) {
				[(BoardViewController *)boardViewController decrementTimeForColor:@"black"];
			}
		}
	}
}

- (NSString *)toSmithFromPreviousStyle12:(NSMutableString *)previousStyle12 andCurrentStyle12:(NSMutableString *)currentStyle12 {
	//NSArray *prevStyle12Array = [previousStyle12 componentsSeparatedByString:@" "];
	//NSArray *currStyle12Array = [currentStyle12 componentsSeparatedByString:@" "];
	
	//for (int i = 0; i < [prevStyle12Array count]; i++) {
		//NSLog(@"| %@ |", [prevStyle12Array objectAtIndex:i]);
	//}
	
	return [NSString stringWithFormat:@"%@\n%@", previousStyle12, currentStyle12];//[NSString stringWithFormat:@"%@ %@", [prevStyle12Array objectAtIndex:26], [currStyle12Array objectAtIndex:26]];
}

- (void)delegateStyle12:(NSString *)style12 {
	NSLog(@"\n12::%@\n", style12);
}

@end
