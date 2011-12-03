//
//  PuzzleBoardViewController.h
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"

@interface PuzzleBoardViewController : UIViewController
{
	UIToolbar *toolbar;
	BoardView *board;
	NSMutableString *blackName;
	NSMutableString *whiteName;
}

@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) BoardView *board;
@property (nonatomic, retain) NSMutableString *blackName;
@property (nonatomic, retain) NSMutableString *whiteName;

@end
