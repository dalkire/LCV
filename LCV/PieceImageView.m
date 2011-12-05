//
//  PieceImageView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "PieceImageView.h"


@implementation PieceImageView

@synthesize color;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]) == nil) {
        return nil;
    }
	[self setUserInteractionEnabled:YES];
    return self;
}

- (void)moveToPoint:(CGPoint)point {
	
}

- (NSInteger)getFrame {
	return self.center.x;
}

- (void)dealloc {
	[color release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"Touched Piece");
	CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
	CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
	self.center = CGPointMake(x, y - 40);
	[[self superview] bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
	CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
    
    y = y - 40 < 20 ? 20 : y - 40;
    x = x < 20 ? 20 : x;
    
	self.center = CGPointMake(x, y);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
	CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
	self.center = CGPointMake((int)x - ((int)x-20)%40, (int)y - ((int)y-60)%40 - 40);
}

@end
