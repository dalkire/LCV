//
//  CurrentGamesViewController.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BoardViewController.h"

@class RootViewController;
@class BoardViewController;

@interface CurrentGamesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    RootViewController *rootViewController;
    BoardViewController *watchingViewController;
	NSMutableArray *currentGames;
	UIToolbar *toolbar;
	NSString *observing;
	BOOL toBeCleared;
	UIActivityIndicatorView *activityIndicatorView;
}

@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) BoardViewController *watchingViewController;
@property (nonatomic, retain) NSMutableArray *currentGames;
@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) NSString *observing;
@property BOOL toBeCleared;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (void)commandResult:(NSString *)result fromCommand:(NSInteger)command;
- (NSMutableArray *)parseCurrentGamesFromCommandResult:(NSString *)result;
- (void)refresh;
- (void)showBoardView;
- (void)showInfoView;
- (void)clearCurrentGamesTable;

@end
