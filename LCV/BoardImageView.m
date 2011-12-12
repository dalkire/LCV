//
//  BoardImageView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "Definitions.h"
#import "BoardView.h"
#import "BoardImageView.h"
#import "PieceImageView.h"
#import "StreamController.h"
#import "BoardViewController.h"
#import "PracticeViewController.h"
#import "Move.h"
#import "MoveListView.h"


@implementation BoardImageView

@synthesize board, wpImg, wrImg, wnImg, wbImg, wqImg, wkImg, bpImg, brImg, bnImg, bbImg, bqImg, bkImg;
@synthesize gesturePoint, overlay;
@synthesize fromSquare  = _fromSquare;
@synthesize device      = _device;
@synthesize squareSize  = _squareSize;

- (id)initForDevice:(int)dvc {
    int width = 0;
    int height = 0;
    _squareSize = 40;
    switch (dvc) {
        case IPHONE_OLD:
            width = 320;
            height = 320;
            _squareSize = 40;
            break;
        case IPHONE_RETINA:
        case IPAD:
            width = 640;
            height = 640;
            _squareSize = 80;
            break;
            
        default:
            break;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 0, width, height)]) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		NSString *boardStyle = [defaults valueForKey:@"board"] ? [[NSString alloc] initWithFormat:@"board_%@.png", [defaults valueForKey:@"board"]] : [[NSString alloc] initWithString:@"board_pinstripes.png"];
		
		board = [UIImage imageNamed:boardStyle];
		
		self.image = board;
		self.userInteractionEnabled = YES;
		[self setBoard];
		[boardStyle release];
		
		overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
		[self addSubview:overlay];
        _fromSquare = [[NSString alloc] initWithString:@""];
    }
	
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[board release];
	[wpImg release];
	[wrImg release];
	[wnImg release];
	[wbImg release];
	[wqImg release];
	[wkImg release];
	[bpImg release];
	[brImg release];
	[bnImg release];
	[bbImg release];
	[bqImg release];
	[bkImg release];
	[overlay release];
    [super dealloc];
}

- (void)setBoard {
	NSLog(@"SETBOARD CALLED");
	[StreamController sharedStreamController].absoluteMoveNumber = 0;
	[StreamController sharedStreamController].currentMoveNumber = 0;
	[(BoardView *)[self superview] clearTime];
	for (UIView *piece in [self subviews]) {
		[piece removeFromSuperview];
	}
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *ps = [defaults valueForKey:@"pieces"] ? [[NSString alloc] initWithString:[[defaults valueForKey:@"pieces"] stringByAppendingString:@"_"]] : [[NSString alloc] initWithString:@"usual_"];
	NSString *pieceStyle = [[NSString alloc] initWithString:ps];
	
	UIImage *bg1Img = [UIImage imageNamed:@"bg.png"];
    CGRect imageRect = CGRectMake(_squareSize, 0.0, _squareSize, _squareSize);
    UIImageView *bg1ImageView = [[UIImageView alloc] initWithFrame:imageRect];
    bg1ImageView.image = bg1Img;
	bg1ImageView.hidden = YES;
    [self addSubview:bg1ImageView];
    [bg1ImageView release];
	
	UIImage *bg2Img = [UIImage imageNamed:@"bg.png"];
    imageRect = CGRectMake(_squareSize, 0.0, _squareSize, _squareSize);
    UIImageView *bg2ImageView = [[UIImageView alloc] initWithFrame:imageRect];
    bg2ImageView.image = bg2Img;
	bg2ImageView.hidden = YES;
    [self addSubview:bg2ImageView];
    [bg2ImageView release];
	
	bnImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bn.png", pieceStyle]];
    imageRect = CGRectMake(_squareSize, 0.0, _squareSize, _squareSize);
    PieceImageView *pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bnImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bn2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bn.png", pieceStyle]];
    imageRect = CGRectMake(6*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bnImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	bbImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bb.png", pieceStyle]];
    imageRect = CGRectMake(2*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bbImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bb2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bb.png", pieceStyle]];
    imageRect = CGRectMake(5*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bbImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	bqImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bq.png", pieceStyle]];
    imageRect = CGRectMake(3*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bqImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	bkImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bk.png", pieceStyle]];
    imageRect = CGRectMake(4*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bkImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	brImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@br.png", pieceStyle]];
    imageRect = CGRectMake(0.0, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = brImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *br2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@br.png", pieceStyle]];
    imageRect = CGRectMake(7*_squareSize, 0.0, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = brImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	bpImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(0.0, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp3Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(2*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp4Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(3*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp5Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(4*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp6Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(5*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp7Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(6*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *bp8Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@bp.png", pieceStyle]];
    imageRect = CGRectMake(7*_squareSize, _squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = bpImg;
    pieceImageView.color = @"black";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wnImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wn.png", pieceStyle]];
    imageRect = CGRectMake(_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wnImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wn2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wn.png", pieceStyle]];
    imageRect = CGRectMake(6*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wnImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wbImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wb.png", pieceStyle]];
    imageRect = CGRectMake(2*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wbImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wb2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wb.png", pieceStyle]];
    imageRect = CGRectMake(5*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wbImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wqImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wq.png", pieceStyle]];
    imageRect = CGRectMake(3*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wqImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wkImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wk.png", pieceStyle]];
    imageRect = CGRectMake(4*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wkImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wrImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wr.png", pieceStyle]];
    imageRect = CGRectMake(0.0, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wrImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wr2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wr.png", pieceStyle]];
    imageRect = CGRectMake(7*_squareSize, 7*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wrImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	wpImg = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(0.0, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp2Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp3Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(2*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp4Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(3*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp5Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(4*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp6Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(5*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp7Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(6*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	//UIImage *wp8Img = [UIImage imageNamed:[NSString stringWithFormat:@"%@wp.png", pieceStyle]];
    imageRect = CGRectMake(7*_squareSize, 6*_squareSize, _squareSize, _squareSize);
    pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
    pieceImageView.image = wpImg;
    pieceImageView.color = @"white";
    [self addSubview:pieceImageView];
    [pieceImageView release];
	
	BoardViewController *bvc = (BoardViewController *)[StreamController sharedStreamController].boardViewController;
	if (bvc.flipped) {
		CGAffineTransform transform=CGAffineTransformIdentity;
		transform=CGAffineTransformRotate(transform, (180.0f*22.0f)/(180.0f*7.0f));
		
		for (UIView *piece in [self subviews]) {
			if ([piece isKindOfClass:[PieceImageView class]]) {
				[piece setTransform:transform];
			}
		}	
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//self.center = CGPointMake(x - 20, y - 60);
	//[[self superview] bringSubviewToFront:self];
}

/*- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
	CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
	self.center = CGPointMake(x - 20, y - 60);
}*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	CGFloat x = [[touches anyObject] locationInView:self].x;
	CGFloat y = [[touches anyObject] locationInView:self].y;
	NSLog(@"Touch in BIV: (%f, %f) = %@", x, y, [self getSquareForPoint:CGPointMake(x, y)]);
    
    if ([_fromSquare isEqualToString:@""]) { //This will be the first square selected
        _fromSquare = [[NSString alloc] initWithString:[self getSquareForPoint:CGPointMake(x, y)]];
        [self hideHighlights];
        [self placeHighlightForSquare:_fromSquare];
    }
    else {
        [(TrainingViewController *)[[StreamController sharedStreamController] trainingViewController] movePieceFromSquare:_fromSquare toSquare:[self getSquareForPoint:CGPointMake(x, y)]];
        _fromSquare = [[NSString alloc] initWithString:@""];
    }
}

- (void)moveFromPoint:(CGPoint)src toPoint:(CGPoint)dest promote:(NSString *)promote {
	//NSInteger source_x, source_y;
	//source_x = src.x + 20;
	//source_y = src.y + 20;
	
	//NSInteger destination_x, destination_y;
	//destination_x = dest.x + 20;
	//destination_y = dest.y + 20;
	BOOL setFirst = FALSE;
	for (PieceImageView *piece in [self subviews]) {
		if ([piece isKindOfClass:[PieceImageView class]]) {
			if ((NSInteger)piece.center.x == (NSInteger)dest.x && (NSInteger)piece.center.y == (NSInteger)dest.y) {
				piece.hidden = YES;
			}
			if ((NSInteger)piece.center.x == (NSInteger)src.x && (NSInteger)piece.center.y == (NSInteger)src.y) {
				piece.center = CGPointMake(dest.x, dest.y);
				if ([promote isEqualToString:@"N"]) {
					if ([piece.color isEqualToString:@"white"]) {
						piece.image = wnImg;
					}
					else if ([piece.color isEqualToString:@"black"]) {
						piece.image = bnImg;
					}
				}
				else if ([promote isEqualToString:@"B"]) {
					if ([piece.color isEqualToString:@"white"]) {
						piece.image = wbImg;
					}
					else if ([piece.color isEqualToString:@"black"]) {
						piece.image = bbImg;
					}
				}
				else if ([promote isEqualToString:@"R"]) {
					if ([piece.color isEqualToString:@"white"]) {
						piece.image = wrImg;
					}
					else if ([piece.color isEqualToString:@"black"]) {
						piece.image = brImg;
					}
				}
				else if ([promote isEqualToString:@"Q"]) {
					if ([piece.color isEqualToString:@"white"]) {
						piece.image = wqImg;
					}
					else if ([piece.color isEqualToString:@"black"]) {
						piece.image = bqImg;
					}
				}
				[self playBoardSound];
			}
		}
		else if ([piece isKindOfClass:[UIImageView class]]) {
			piece.hidden = NO;
			if (!setFirst) {
				piece.center = CGPointMake(src.x, src.y);
				setFirst = YES;
			}
			else {
				piece.center = CGPointMake(dest.x, dest.y);
				setFirst = NO;
			}

		}
		//NSLog(@"found piece over (220,260): %@", [piece description]);
	}
}

- (void)playBoardSound { 
    NSString *path = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], @"/knock.wav"];
	//NSLog(@"sound path: %@", path);
    SystemSoundID soundID; 
    AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &soundID); 
    //AudioServicesPlaySystemSound(soundID);
}

- (void)removePieceFromSquare:(NSString *)square {
	CGPoint dest = [self getPointFromSquare:square];
	
	for (PieceImageView *piece in [self subviews]) {
		if ((NSInteger)piece.center.x == (NSInteger)dest.x && (NSInteger)piece.center.y == (NSInteger)dest.y) {
			piece.hidden = YES;
			//[piece release];
		}
	}
}

- (void)addPiece:(NSString *)piece toSquare:(NSString *)square {
    NSLog(@"AddPiece: %@ toSquare: %@", piece, square);
	CGPoint dest = [self getPointFromSquare:square];
	CGRect imageRect = CGRectMake(dest.x - _squareSize/2, dest.y - _squareSize/2, _squareSize, _squareSize);
	PieceImageView *pieceImageView = [[PieceImageView alloc] initWithFrame:imageRect];
	
	if ([piece isEqualToString:@"bn"]) {
		pieceImageView.image = bnImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"bn"]];
	}
	else if ([piece isEqualToString:@"bb"]) {
		pieceImageView.image = bbImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"bb"]];
	}
	else if ([piece isEqualToString:@"bq"]) {
		pieceImageView.image = bqImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"bq"]];
	}
	else if ([piece isEqualToString:@"bk"]) {
		pieceImageView.image = bkImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"bk"]];
	}
	else if ([piece isEqualToString:@"br"]) {
		pieceImageView.image = brImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"br"]];
	}
	else if ([piece isEqualToString:@"bp"]) {
		pieceImageView.image = bpImg;
		pieceImageView.color = @"black";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"bp"]];
	}
	else if ([piece isEqualToString:@"wn"]) {
		pieceImageView.image = wnImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wn"]];
	}
	else if ([piece isEqualToString:@"wb"]) {
		pieceImageView.image = wbImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wb"]];
	}
	else if ([piece isEqualToString:@"wq"]) {
		pieceImageView.image = wqImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wq"]];
	}
	else if ([piece isEqualToString:@"wk"]) {
		pieceImageView.image = wkImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wk"]];
	}
	else if ([piece isEqualToString:@"wr"]) {
		pieceImageView.image = wrImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wr"]];
	}
	else if ([piece isEqualToString:@"wp"]) {
		pieceImageView.image = wpImg;
		pieceImageView.color = @"white";
        [pieceImageView setPiece:[NSMutableString stringWithString:@"wp"]];
	}
	
	BoardViewController *bvc = (BoardViewController *)[StreamController sharedStreamController].boardViewController;
	if (bvc.flipped) {
		CGAffineTransform transform=CGAffineTransformIdentity;
		transform=CGAffineTransformRotate(transform, (180.0f*22.0f)/(180.0f*7.0f));
		[pieceImageView setTransform:transform];
	}
	
	[self addSubview:pieceImageView];
	[pieceImageView release];
}

- (NSString *)getSquareForPoint:(CGPoint)point
{
    int x = (int)point.x/_squareSize;
    int y = (int)point.y/_squareSize;
    
    NSString *rank = @"";
    NSString *file = @"";
    
    NSArray *ranks = [[NSArray alloc] initWithObjects:@"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", nil];
    NSArray *files = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", nil];
    
    rank = [ranks objectAtIndex:y];
    file = [files objectAtIndex:x];
    
    return [NSString stringWithFormat:@"%@%@", file, rank];
}

- (CGPoint)getPointFromSquare:(NSString *)square {
	if ([square isEqualToString:@"a1"]) {
		return CGPointMake(_squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a2"]) {
		return CGPointMake(_squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a3"]) {
		return CGPointMake(_squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a4"]) {
		return CGPointMake(_squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a5"]) {
		return CGPointMake(_squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a6"]) {
		return CGPointMake(_squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a7"]) {
		return CGPointMake(_squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"a8"]) {
		return CGPointMake(_squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"b1"]) {
		return CGPointMake(_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b2"]) {
		return CGPointMake(_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b3"]) {
		return CGPointMake(_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b4"]) {
		return CGPointMake(_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b5"]) {
		return CGPointMake(_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b6"]) {
		return CGPointMake(_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b7"]) {
		return CGPointMake(_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"b8"]) {
		return CGPointMake(_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"c1"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c2"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c3"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c4"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c5"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c6"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c7"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"c8"]) {
		return CGPointMake(2*_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"d1"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d2"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d3"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d4"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d5"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d6"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d7"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"d8"]) {
		return CGPointMake(3*_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"e1"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e2"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e3"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e4"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e5"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e6"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e7"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"e8"]) {
		return CGPointMake(4*_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"f1"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f2"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f3"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f4"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f5"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f6"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f7"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"f8"]) {
		return CGPointMake(5*_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"g1"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g2"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g3"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g4"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g5"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g6"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g7"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"g8"]) {
		return CGPointMake(6*_squareSize + _squareSize/2, _squareSize/2);
	}
	
	if ([square isEqualToString:@"h1"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 7*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h2"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 6*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h3"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 5*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h4"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 4*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h5"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 3*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h6"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, 2*_squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h7"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, _squareSize + _squareSize/2);
	}
	if ([square isEqualToString:@"h8"]) {
		return CGPointMake(7*_squareSize + _squareSize/2, _squareSize/2);
	}
	return CGPointMake(0.0, 0.0);
}

- (void)hideHighlights {
    for (UIView *piece in [self subviews]) {
		if (![piece isKindOfClass:[PieceImageView class]] && [piece isKindOfClass:[UIImageView class]]) {
            [piece setHidden:YES];
		}
	}
}

- (void)placeHighlightForSquare:(NSString *)square {
	CGPoint firstPoint = [self getPointFromSquare:square];
    
    for (UIView *piece in [self subviews]) {
		if (![piece isKindOfClass:[PieceImageView class]] && [piece isKindOfClass:[UIImageView class]]) {
            piece.center = CGPointMake(firstPoint.x, firstPoint.y);
            [piece setHidden:NO];
            return;
		}
	}
}

- (void)placeHighlightsForMove:(NSString *)moveSmith {
	CGPoint firstPoint = [self getPointFromSquare:[moveSmith substringWithRange:NSMakeRange(0, 2)]];
	CGPoint secondPoint = [self getPointFromSquare:[moveSmith substringWithRange:NSMakeRange(2, 2)]];
	BOOL setFirst = NO;

	for (UIView *piece in [self subviews]) {
		if (![piece isKindOfClass:[PieceImageView class]] && [piece isKindOfClass:[UIImageView class]]) {
			piece.hidden = NO;
			if (!setFirst) {
				piece.center = CGPointMake(firstPoint.x, firstPoint.y);
				setFirst = YES;
			}
			else {
				piece.center = CGPointMake(secondPoint.x, secondPoint.y);
				setFirst = NO;
			}
		}
	}
}

- (void)clearBoard {
	[self removePieceFromSquare:@"a1"];
	[self removePieceFromSquare:@"a2"];
	[self removePieceFromSquare:@"a3"];
	[self removePieceFromSquare:@"a4"];
	[self removePieceFromSquare:@"a5"];
	[self removePieceFromSquare:@"a6"];
	[self removePieceFromSquare:@"a7"];
	[self removePieceFromSquare:@"a8"];
	
	[self removePieceFromSquare:@"b1"];
	[self removePieceFromSquare:@"b2"];
	[self removePieceFromSquare:@"b3"];
	[self removePieceFromSquare:@"b4"];
	[self removePieceFromSquare:@"b5"];
	[self removePieceFromSquare:@"b6"];
	[self removePieceFromSquare:@"b7"];
	[self removePieceFromSquare:@"b8"];
	
	[self removePieceFromSquare:@"c1"];
	[self removePieceFromSquare:@"c2"];
	[self removePieceFromSquare:@"c3"];
	[self removePieceFromSquare:@"c4"];
	[self removePieceFromSquare:@"c5"];
	[self removePieceFromSquare:@"c6"];
	[self removePieceFromSquare:@"c7"];
	[self removePieceFromSquare:@"c8"];
	
	[self removePieceFromSquare:@"d1"];
	[self removePieceFromSquare:@"d2"];
	[self removePieceFromSquare:@"d3"];
	[self removePieceFromSquare:@"d4"];
	[self removePieceFromSquare:@"d5"];
	[self removePieceFromSquare:@"d6"];
	[self removePieceFromSquare:@"d7"];
	[self removePieceFromSquare:@"d8"];
	
	[self removePieceFromSquare:@"e1"];
	[self removePieceFromSquare:@"e2"];
	[self removePieceFromSquare:@"e3"];
	[self removePieceFromSquare:@"e4"];
	[self removePieceFromSquare:@"e5"];
	[self removePieceFromSquare:@"e6"];
	[self removePieceFromSquare:@"e7"];
	[self removePieceFromSquare:@"e8"];
	
	[self removePieceFromSquare:@"f1"];
	[self removePieceFromSquare:@"f2"];
	[self removePieceFromSquare:@"f3"];
	[self removePieceFromSquare:@"f4"];
	[self removePieceFromSquare:@"f5"];
	[self removePieceFromSquare:@"f6"];
	[self removePieceFromSquare:@"f7"];
	[self removePieceFromSquare:@"f8"];
	
	[self removePieceFromSquare:@"g1"];
	[self removePieceFromSquare:@"g2"];
	[self removePieceFromSquare:@"g3"];
	[self removePieceFromSquare:@"g4"];
	[self removePieceFromSquare:@"g5"];
	[self removePieceFromSquare:@"g6"];
	[self removePieceFromSquare:@"g7"];
	[self removePieceFromSquare:@"g8"];
	
	[self removePieceFromSquare:@"h1"];
	[self removePieceFromSquare:@"h2"];
	[self removePieceFromSquare:@"h3"];
	[self removePieceFromSquare:@"h4"];
	[self removePieceFromSquare:@"h5"];
	[self removePieceFromSquare:@"h6"];
	[self removePieceFromSquare:@"h7"];
	[self removePieceFromSquare:@"h8"];
}

@end
