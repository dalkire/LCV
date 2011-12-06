//
//  PuzzleBoardViewController.h
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamController.h"
#import "TrainingView.h"

@interface TrainingViewController : UIViewController
{
	UIToolbar *toolbar;
	TrainingView *trainingView;
	NSMutableString *blackName;
	NSMutableString *whiteName;
    BOOL inStartingPosition;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) TrainingView *trainingView;
@property (nonatomic, retain) NSMutableString *blackName;
@property (nonatomic, retain) NSMutableString *whiteName;
@property BOOL inStartingPosition;

- (void)setPositionFromStyle12:(NSString *)style12;
- (void)movePieceFromSquare:(NSString *)fromSquare toSquare:(NSString *)toSquare;

@end

@protocol TrainingViewControllerDelegate <NSObject>

//- (void)

@end
