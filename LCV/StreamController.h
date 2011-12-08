//
//  StreamController.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrainingViewController.h"

@class TrainingViewController;

@interface StreamController : NSObject <NSStreamDelegate> {
    id delegate;
    BOOL sentConnectMessage;
	NSMutableString *testString;
	NSInputStream *iStream;
	NSOutputStream *oStream;
	NSMutableString *currentGames;
	NSMutableString *observeString;
	NSMutableString *prevStyle12String;
	NSMutableString *currStyle12String;
	NSMutableString *moveString;
	NSMutableString *level1Command;
	NSMutableString *level2Command;
	NSMutableArray *moveList;
	NSMutableArray *ficsMoveList;
	BOOL firstPass;
	BOOL spaceAvailable;	
	BOOL readingCurrentGames;
	BOOL inLevel2;
	BOOL clockRunning;
	BOOL firstStyle12;
	BOOL streamFirstReady;
	NSInteger currentLevel1Command;
	NSInteger currentLevel2Command;
	NSInteger level1Depth;
	NSUInteger absoluteMoveNumber;
	NSUInteger currentMoveNumber;
	NSUInteger currentFicsLocalMoveNumber;
	NSUInteger observing;
	UIViewController *caller;
	UIViewController *boardViewController;
	UIViewController *currentGamesViewController;
    TrainingViewController *trainingViewController;
	UIViewController *mainViewController;
	NSString *resultText;
	NSString *iccResultText;
	int server;
    int mode;
    NSString *canMoveColor;
}

@property (nonatomic, retain) id delegate;
@property BOOL sentConnectMessage;
@property (nonatomic, retain) NSMutableString *testString;
@property (nonatomic, retain) NSInputStream *iStream;
@property (nonatomic, retain) NSOutputStream *oStream;
@property (nonatomic, retain) NSMutableString *currentGames;
@property (nonatomic, retain) NSMutableString *observeString;
@property (nonatomic, retain) NSMutableString *prevStyle12String;
@property (nonatomic, retain) NSMutableString *currStyle12String;
@property (nonatomic, retain) NSMutableString *moveString;
@property (nonatomic, retain) NSMutableString *level1Command;
@property (nonatomic, retain) NSMutableString *level2Command;
@property (nonatomic, retain) NSMutableArray *moveList;
@property (nonatomic, retain) NSMutableArray *ficsMoveList;
@property (nonatomic, retain) UIViewController *caller;
@property (nonatomic, retain) UIViewController *boardViewController;
@property (nonatomic, retain) UIViewController *currentGamesViewController;
@property (nonatomic, retain) TrainingViewController *trainingViewController;
@property (nonatomic, retain) UIViewController *mainViewController;
@property BOOL firstPass;
@property BOOL spaceAvailable;
@property BOOL readingCurrentGames;
@property BOOL inLevel2;
@property BOOL clockRunning;
@property BOOL firstStyle12;
@property BOOL streamFirstReady;
@property NSInteger currentLevel1Command;
@property NSInteger currentLevel2Command;
@property NSInteger level1Depth;
@property NSUInteger absoluteMoveNumber;
@property NSUInteger currentMoveNumber;
@property NSUInteger currentFicsLocalMoveNumber;
@property NSUInteger observing;
@property (nonatomic, retain) NSString *resultText;
@property (nonatomic, retain) NSString *iccResultText;
@property int server;
@property int mode;
@property (nonatomic, retain) NSString *canMoveColor;

+ (StreamController *)sharedStreamController;
- (void)sendCommand:(NSMutableString *)command fromViewController:(UITableViewController *)viewController;
- (void)sendCommand:(NSMutableString *)command;
- (void)delegateLevel1Command:(NSMutableString *)command;
- (void)delegateLevel2Command:(NSMutableString *)command;
- (NSInteger)getLevel2CommandNumber:(NSMutableString *)command;
- (void)registerViewController:(UIViewController *)controller;
- (void)gameEndedWithCode:(NSString *)rawCode;
- (void)timerFireMethod:(NSTimer*)theTimer;
- (void)connect;
- (void)disconnect;
- (NSString *)toSmithFromPreviousStyle12:(NSMutableString *)previousStyle12 andCurrentStyle12:(NSMutableString *)currentStyle12;

@end

@protocol StreamControllerDelegate <NSObject>

- (void)didConnect;

@end
