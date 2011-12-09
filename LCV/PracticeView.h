//
//  PracticeView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardImageView.h"

@interface PracticeView : UIView {
	BoardImageView *board;
	UITextView *kibitzTextView;
}

@property (nonatomic, retain) BoardImageView *board;
@property (nonatomic, retain) UITextView *kibitzTextView;

@end
