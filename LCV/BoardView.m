//
//  BoardView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "BoardView.h"
#import "MoveListView.h"

@implementation BoardView

@synthesize board, blackPlayerLabel, whitePlayerLabel, blackTimeLabel, whiteTimeLabel, blackTimeInSeconds, whiteTimeInSeconds, moveListView, movesScrollView;
@synthesize device = _device;


- (id)initForDevice:(int)dvc {    
    _device = dvc;
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height - 20;
    
    if (_device == IPAD) {
        NSLog(@"PAD");
        width = [UIScreen mainScreen].bounds.size.height;
        height = [UIScreen mainScreen].bounds.size.width - 20;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 0, width, height - 44)]) {
        board = [[BoardImageView alloc] initForDevice:_device];
		blackPlayerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 225, 18)];
		whitePlayerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, 225, 18)];
		blackPlayerLabel.backgroundColor = [UIColor blackColor];
		blackPlayerLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14];
		whitePlayerLabel.backgroundColor = [UIColor blackColor];
		whitePlayerLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14];
		blackPlayerLabel.textColor = [UIColor lightTextColor];
		whitePlayerLabel.textColor = [UIColor lightTextColor];
		blackPlayerLabel.text = @"---";
		whitePlayerLabel.text = @"---";
		blackTimeInSeconds = 0;
		whiteTimeInSeconds = 0;
		
		blackTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 4, 70, 18)];
		whiteTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 350, 70, 18)];
		blackTimeLabel.backgroundColor = [UIColor blackColor];
		blackTimeLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14];
		blackTimeLabel.textAlignment = UITextAlignmentRight;
		whiteTimeLabel.backgroundColor = [UIColor blackColor];
		whiteTimeLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:14];
		whiteTimeLabel.textAlignment = UITextAlignmentRight;
		blackTimeLabel.textColor = [UIColor lightTextColor];
		whiteTimeLabel.textColor = [UIColor lightTextColor];
		blackTimeLabel.text = @"---";
		whiteTimeLabel.text = @"---";
		
		movesScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 374, 300, 39)];
		moveListView = [[MoveListView alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
		[movesScrollView setContentSize:moveListView.frame.size];
		moveListView.backgroundColor = [UIColor blackColor];
		[movesScrollView addSubview:moveListView];
        
        board.frame = CGRectMake(board.frame.origin.x, 
                                 board.frame.origin.y + 26, 
                                 board.frame.size.width, 
                                 board.frame.size.height);
		
		[self addSubview:board];
		[self addSubview:blackPlayerLabel];
		[self addSubview:whitePlayerLabel];
		[self addSubview:blackTimeLabel];
		[self addSubview:whiteTimeLabel];
		//[self addSubview:movesScrollView];
    }
    return self;
}

- (void)setTime:(NSNumber *)seconds forColor:(NSString *)color {
	NSNumber *m = [NSNumber numberWithFloat:[seconds floatValue]/60.0];
	NSNumber *s = [NSNumber numberWithInteger:[seconds intValue]%60];
	if ([color isEqualToString:@"black"]) {
		blackTimeInSeconds = [seconds unsignedIntegerValue];
		NSString *blackTimeText = [s intValue] < 10 ? [[NSString alloc] initWithFormat:@"%d:0%d", [m intValue], [s intValue]] : [[NSString alloc] initWithFormat:@"%d:%d", [m intValue], [s intValue]];
		blackTimeLabel.text = blackTimeText;
		[blackTimeText release];
	}
	else if([color isEqualToString:@"white"]) {
		whiteTimeInSeconds = [seconds unsignedIntegerValue];
		NSString *whiteTimeText = [s intValue] < 10 ? [[NSString alloc] initWithFormat:@"%d:0%d", [m intValue], [s intValue]] : [[NSString alloc] initWithFormat:@"%d:%d", [m intValue], [s intValue]];
		whiteTimeLabel.text = whiteTimeText;
		[whiteTimeText release];
	}
}

- (void)clearTime {
	blackTimeLabel.text = whiteTimeLabel.text = @"---";
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)resetMoveListView {
	[moveListView removeFromSuperview];
	moveListView = [[MoveListView alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
	[movesScrollView setContentSize:moveListView.frame.size];
	moveListView.backgroundColor = [UIColor blackColor];
	[movesScrollView addSubview:moveListView];
}

- (void)dealloc {
	[board release];
	[blackPlayerLabel release];
	[whitePlayerLabel release];
	[blackTimeLabel release];
	[whiteTimeLabel release];
	[moveListView release];
	[movesScrollView release];
    [super dealloc];
}


@end
