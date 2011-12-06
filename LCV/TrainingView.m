//
//  TrainingView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "TrainingView.h"

@implementation TrainingView

@synthesize board = _board;
@synthesize kibitzTextView = _kibitzTextView;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _board = [[BoardImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
		
		_kibitzTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 320, 320, 96)];
        [_kibitzTextView setBackgroundColor:[UIColor blackColor]];
		[_kibitzTextView setFont:[UIFont systemFontOfSize:14]];
        [_kibitzTextView setTextColor:[UIColor whiteColor]];
        
        [_kibitzTextView setText:@"hello"];
        [_kibitzTextView setText:[NSString stringWithFormat:@"%@\n%@", [_kibitzTextView text], @"again"]];
		
		[self addSubview:_board];
		[self addSubview:_kibitzTextView];
    }
    return self;
}

- (void)dealloc {
	[_board release];
	[_kibitzTextView release];
    [super dealloc];
}


@end
