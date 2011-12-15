//
//  BoardViewController.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "CurrentGamesViewController.h"

@class BoardView, Move;
@class RootViewController;

@interface BoardViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    RootViewController *rootViewController;
    UINavigationController *navController;
    CurrentGamesViewController *currentGamesViewController;
    UIPopoverController *currentGamesPopover;
	UIToolbar *toolbar;
	BoardView *board;
	NSString *blackName;
	NSString *whiteName;
	NSString *blackElo;
	NSString *whiteElo;
	NSString *resultText;
	NSString *iccResultText;
	BOOL flipped;
    int device;
    UISegmentedControl *actionsSegmentedControl;
    UISegmentedControl *directionSegmentedControl;
}

@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) CurrentGamesViewController *currentGamesViewController;
@property (nonatomic, retain) UIPopoverController *currentGamesPopover;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) BoardView *board;
@property (nonatomic, retain) NSString *blackName;
@property (nonatomic, retain) NSString *whiteName;
@property (nonatomic, retain) NSString *blackElo;
@property (nonatomic, retain) NSString *whiteElo;
@property (nonatomic, retain) NSString *resultText;
@property (nonatomic, retain) NSString *iccResultText;
@property BOOL flipped;
@property int device;
@property (nonatomic, retain) UISegmentedControl *actionsSegmentedControl;
@property (nonatomic, retain) UISegmentedControl *directionSegmentedControl;

- (void)commandResult:(NSString *)result fromCommand:(NSInteger *)command;
- (void)moveList:(NSArray *)moveList;
- (void)setPositionFromStyle12:(NSString *)style12;
- (void)move:(Move *)move direction:(NSString *)direction;
- (CGPoint)getPointFromSquare:(NSString *)square;
- (void)showCurrentGamesView;
- (void)setPlayerLabel:(NSString *)name forColor:(NSString *)color;
- (void)decrementTimeForColor:(NSString *)color;
- (void)resetBoard;
- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated;
- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber andLocalFicsNumber:(NSUInteger)localFicsNumber animated:(BOOL)animated;
- (void)resetMoveListView;
- (void)addEndLabelResult:(NSString *)resultText iccResult:(NSString *)iccResultText absoluteMoveNumber:(NSUInteger)absoluteMoveNumber;
- (void)sendMail;
- (void)resetResults;
- (void)setResultText:(NSString *)resText;
- (void)setIccResultText:(NSString *)iccResText;
- (void)goBackward;
- (void)goForward;
- (void)flipBoard;

@end
