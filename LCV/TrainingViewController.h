//
//  PuzzleBoardViewController.h
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamController.h"
#import "BoardView.h"

@interface TrainingViewController : UIViewController
{
	UIToolbar *toolbar;
	BoardView *board;
	NSMutableString *blackName;
	NSMutableString *whiteName;
    BOOL inStartingPosition;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) BoardView *board;
@property (nonatomic, retain) NSMutableString *blackName;
@property (nonatomic, retain) NSMutableString *whiteName;
@property BOOL inStartingPosition;

- (void)setPositionFromStyle12:(NSString *)style12;
- (void)movePiece:(NSString *)piece fromSquare:(NSString *)fromSquare toSquare:(NSString *)toSquare;

@end

@protocol TrainingViewControllerDelegate <NSObject>

//- (void)

@end
