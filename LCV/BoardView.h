//
//  BoardView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardImageView.h"
@class MoveListView;

@interface BoardView : UIView {
	BoardImageView *board;
	UIScrollView *movesScrollView;
	MoveListView *moveListView;
	UILabel *blackPlayerLabel;
	UILabel *whitePlayerLabel;
	UILabel *blackTimeLabel;
	UILabel *whiteTimeLabel;
	NSUInteger blackTimeInSeconds;
	NSUInteger whiteTimeInSeconds;
}

@property (nonatomic, retain) BoardImageView *board;
@property (nonatomic, retain) UIScrollView *movesScrollView;
@property (nonatomic, retain) MoveListView *moveListView;
@property (nonatomic, retain) IBOutlet UILabel *blackPlayerLabel;
@property (nonatomic, retain) IBOutlet UILabel *whitePlayerLabel;
@property (nonatomic, retain) IBOutlet UILabel *blackTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *whiteTimeLabel;
@property NSUInteger blackTimeInSeconds;
@property NSUInteger whiteTimeInSeconds;

- (void)setTime:(NSNumber *)seconds forColor:(NSString *)color;
- (void)clearTime;
- (void)resetMoveListView;

@end
