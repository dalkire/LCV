//
//  PracticeViewController.h
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"
#import "StreamController.h"
#import "PracticeView.h"

@interface PracticeViewController : UIViewController
{
	UIToolbar *toolbar;
	PracticeView *practiceView;
	NSMutableString *blackName;
	NSMutableString *whiteName;
    BOOL inStartingPosition;
    int device;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) PracticeView *practiceView;
@property (nonatomic, retain) NSMutableString *blackName;
@property (nonatomic, retain) NSMutableString *whiteName;
@property BOOL inStartingPosition;
@property int device;

- (void)setPositionFromStyle12:(NSString *)style12;
- (void)movePieceFromSquare:(NSString *)fromSquare toSquare:(NSString *)toSquare;

@end

@protocol PracticeViewControllerDelegate <NSObject>

//- (void)

@end
