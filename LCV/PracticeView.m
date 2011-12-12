//
//  PracticeView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "PracticeView.h"

@implementation PracticeView

@synthesize board           = _board;
@synthesize kibitzTextView  = _kibitzTextView;
@synthesize device          = _device;

- (id)initForDevice:(int)dvc {
    _device = dvc;
    int width = 0;
    int height = 0;
    switch (dvc) {
        case IPHONE_OLD:
            width = 320;
            height = 320;
            break;
        case IPHONE_RETINA:
        case IPAD:
            width = 640;
            height = 640;
            break;
            
        default:
            break;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 44, width, height)]) {
        _board = [[BoardImageView alloc] initForDevice:_device];
        [_board setBackgroundColor:[UIColor purpleColor]];
		
		_kibitzTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, height, width, 96)];
        [_kibitzTextView setBackgroundColor:[UIColor blackColor]];
		[_kibitzTextView setFont:[UIFont systemFontOfSize:14]];
        [_kibitzTextView setTextColor:[UIColor whiteColor]];
        
        [_kibitzTextView setText:@""];
        [_kibitzTextView setEditable:NO];
		
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
