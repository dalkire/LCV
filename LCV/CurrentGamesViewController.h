//
//  CurrentGamesViewController.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentGamesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSArray *currentGames;
	//IBOutlet UIToolbar *toolbar;
	NSString *observing;
	BOOL toBeCleared;
	UIActivityIndicatorView *activityIndicatorView;
}

@property (nonatomic, retain) NSArray *currentGames;
//@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) NSString *observing;
@property BOOL toBeCleared;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

- (void)commandResult:(NSString *)result fromCommand:(NSInteger)command;
- (NSArray *)parseCurrentGamesFromCommandResult:(NSString *)result;
- (void)refresh;
- (void)showBoardView;
- (void)showInfoView;
- (void)clearCurrentGamesTable;

@end
