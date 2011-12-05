//
//  PieceImageView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PieceImageView : UIImageView {
    NSMutableString *piece;
	NSString *color;
    NSMutableString *fromSquare;
}

@property (nonatomic, retain) NSMutableString *piece;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSMutableString *fromSquare;

- (void)moveToPoint:(CGPoint)point;
- (NSInteger)getFrame;
- (NSString *)getSquareForPoint:(CGPoint)point;
- (CGPoint)getPointForSquare:(NSString *)square;

@end
