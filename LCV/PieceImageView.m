//
//  PieceImageView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#define WATCHING    200
#define TRAINING    201

#import "PieceImageView.h"
#import "StreamController.h"
#import "TrainingViewController.h"


@implementation PieceImageView

@synthesize piece = _piece;
@synthesize color = _color;
@synthesize fromSquare = _fromSquare;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]) == nil) {
        return nil;
    }
	[self setUserInteractionEnabled:YES];
    _piece = [[NSMutableString alloc] initWithString:@""];
    _fromSquare = [[NSMutableString alloc] initWithString:@""];
    
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
    NSMutableString *canMoveColor = [NSMutableString stringWithString:[[[StreamController sharedStreamController] canMoveColor] lowercaseString]];
    
    if ([canMoveColor characterAtIndex:0] == [_color characterAtIndex:0]) {
        NSMutableString *sq = [[NSMutableString alloc] initWithString:[self getSquareForPoint:CGPointMake(self.center.x, self.center.y)]];
        _fromSquare = sq;
    
        CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
        CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
    
        y = y - 40 < 0 + 20 ? 0 + 20    : y - 40;
        y = y > 320 - 20    ? 320 - 20  : y;
        x = x < 0 + 20      ? 0 + 20    : x;
        x = x > 320 - 20    ? 320 - 20  : x;
    
        self.center = CGPointMake(x, y);
        [[self superview] bringSubviewToFront:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableString *canMoveColor = [NSMutableString stringWithString:[[[StreamController sharedStreamController] canMoveColor] lowercaseString]];
    
    if ([canMoveColor characterAtIndex:0] == [_color characterAtIndex:0]) {
        CGFloat x = [[touches anyObject] locationInView:[self superview]].x;
        CGFloat y = [[touches anyObject] locationInView:[self superview]].y;
    
        y = y - 40 < 0 + 20 ? 0 + 20    : y - 40;
        y = y > 320 - 20    ? 320 - 20  : y;
        x = x < 0 + 20      ? 0 + 20    : x;
        x = x > 320 - 20    ? 320 - 20  : x;
    
        self.center = CGPointMake(x, y);
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableString *canMoveColor = [NSMutableString stringWithString:[[[StreamController sharedStreamController] canMoveColor] lowercaseString]];
    
    if ([canMoveColor characterAtIndex:0] == [_color characterAtIndex:0]) {
        NSString *square = [self getSquareForPoint:CGPointMake(self.center.x, self.center.y)];
        CGPoint squareOrigin = [self getPointForSquare:square];
    
        self.center = CGPointMake(squareOrigin.x + 20, squareOrigin.y + 20);
    
        if ([[StreamController sharedStreamController] mode] == TRAINING && [[StreamController sharedStreamController] trainingViewController]) {
            [(TrainingViewController *)[[StreamController sharedStreamController] trainingViewController] movePiece:_piece 
                                                                                                     fromSquare:_fromSquare 
                                                                                                       toSquare:square];
        }
    }
}

- (NSString *)getSquareForPoint:(CGPoint)point
{
    int x = (int)point.x/40;
    int y = (int)point.y/40;
    
    NSString *rank = @"";
    NSString *file = @"";
    
    NSArray *ranks = [[NSArray alloc] initWithObjects:@"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", nil];
    NSArray *files = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", nil];
    
    rank = [ranks objectAtIndex:y];
    file = [files objectAtIndex:x];
    
    return [NSString stringWithFormat:@"%@%@", file, rank];
}

- (CGPoint)getPointForSquare:(NSString *)square {
    int x;
    int y;
    
    NSArray *numbers = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    
    NSArray *ranks = [[NSArray alloc] initWithObjects:@"8", @"7", @"6", @"5", @"4", @"3", @"2", @"1", nil];
    NSArray *files = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", nil];
    
    NSDictionary *ranksDictionary = [NSDictionary dictionaryWithObjects:numbers forKeys:ranks];
    NSDictionary *filesDictionary = [NSDictionary dictionaryWithObjects:numbers forKeys:files];
    
    NSString *rank = [NSString stringWithFormat:@"%c", [square characterAtIndex:1]];
    NSString *file = [NSString stringWithFormat:@"%c", [square characterAtIndex:0]];
    
    x = [[filesDictionary objectForKey:file] intValue];
    y = [[ranksDictionary objectForKey:rank] intValue];
    
    return CGPointMake(x*40, y*40);
}

@end
