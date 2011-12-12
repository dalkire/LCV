//
//  BoardImageView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#define kMinimumGestureLength	50
#define kMaximumVariance		25

@interface BoardImageView : UIImageView {
	UIImage *board;
	UIImage *wpImg;
	UIImage *wrImg;
	UIImage *wnImg;
	UIImage *wbImg;
	UIImage *wqImg;
	UIImage *wkImg;
	UIImage *bpImg;
	UIImage *brImg;
	UIImage *bnImg;
	UIImage *bbImg;
	UIImage *bqImg;
	UIImage *bkImg;
	UIView *overlay;
	CGPoint gesturePoint;
    NSString *fromSquare;
    int device;
    int squareSize;
}

@property (nonatomic, retain) UIImage *board;
@property (nonatomic, retain) UIImage *wpImg;
@property (nonatomic, retain) UIImage *wrImg;
@property (nonatomic, retain) UIImage *wnImg;
@property (nonatomic, retain) UIImage *wbImg;
@property (nonatomic, retain) UIImage *wqImg;
@property (nonatomic, retain) UIImage *wkImg;
@property (nonatomic, retain) UIImage *bpImg;
@property (nonatomic, retain) UIImage *brImg;
@property (nonatomic, retain) UIImage *bnImg;
@property (nonatomic, retain) UIImage *bbImg;
@property (nonatomic, retain) UIImage *bqImg;
@property (nonatomic, retain) UIImage *bkImg;
@property (nonatomic, retain) UIView *overlay;
@property CGPoint gesturePoint;
@property (nonatomic, retain) NSString *fromSquare;
@property int device;
@property int squareSize;

- (id)initForDevice:(int)dvc;
- (void)setBoard;
- (void)moveFromPoint:(CGPoint)src toPoint:(CGPoint)dest promote:(NSString *)promote;
- (void)playBoardSound;
- (void)removePieceFromSquare:(NSString *)square;
- (void)addPiece:(NSString *)piece toSquare:(NSString *)square;
- (NSString *)getSquareForPoint:(CGPoint)point;
- (CGPoint)getPointFromSquare:(NSString *)square;
- (void)hideHighlights;
- (void)placeHighlightForSquare:(NSString *)square;
- (void)placeHighlightsForMove:(NSString *)moveSmith;
- (void)clearBoard;

@end
