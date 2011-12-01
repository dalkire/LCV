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


@end
