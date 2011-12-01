//
//  PieceImageView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PieceImageView : UIImageView {
	NSString *color;
}

@property (nonatomic, retain) NSString *color;

- (void)moveToPoint:(CGPoint)point;
- (NSInteger)getFrame;

@end
