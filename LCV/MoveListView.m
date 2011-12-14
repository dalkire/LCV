//
//  MoveListView.m
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import "MoveListView.h"
#import "StreamController.h"
#define END_LABEL -99

@implementation MoveListView

@synthesize hasEndLabel;
@synthesize firstMoveAbsNum;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		hasEndLabel = NO;
        firstMoveAbsNum = 0;
    }
	
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}

- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated {
	NSUInteger regularMoveNumber = (absoluteMoveNumber + 1)/2;
	
	if (absoluteMoveNumber %2 == 1) {
		UILabel *moveNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (regularMoveNumber-1)*13, 25, 13)];
		moveNumberLabel.backgroundColor = [UIColor blackColor];
		moveNumberLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveNumberLabel.textColor = [UIColor lightTextColor];
		moveNumberLabel.textAlignment = UITextAlignmentRight;
		moveNumberLabel.text = [NSString stringWithFormat:@"%d.", regularMoveNumber];
		[self addSubview:moveNumberLabel];
		
		UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, (regularMoveNumber-1)*13, 60, 13)];
		moveLabel.tag = absoluteMoveNumber;
		moveLabel.backgroundColor = [UIColor blackColor];
		moveLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveLabel.textColor = [UIColor lightTextColor];
		moveLabel.text = move;
		[self addSubview:moveLabel];
	}
	else {
		UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, (regularMoveNumber-1)*13, 60, 13)];
		moveLabel.tag = absoluteMoveNumber;
		moveLabel.backgroundColor = [UIColor blackColor];
		moveLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveLabel.textColor = [UIColor lightTextColor];
		moveLabel.text = move;
		[self addSubview:moveLabel];
	}
	
	self.frame = CGRectMake(0, 0, 300, regularMoveNumber*13);
	[(UIScrollView *)[self superview] setContentSize:self.frame.size];
	if ([StreamController sharedStreamController].currentMoveNumber == absoluteMoveNumber) {
		[self highlightMoveWithAbsoluteMoveNumber:absoluteMoveNumber animated:animated];
	}
}

- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber andLocalFicsNumber:(NSUInteger)localFicsNumber animated:(BOOL)animated {
	NSUInteger regularMoveNumber = (absoluteMoveNumber + 1)/2;
	NSUInteger regFicsNumber = (localFicsNumber + 1)/2;
	
	NSLog(@"MOVE: %@, ABSMN=%d, REGMN=%d, REGFN=%d, localFICS=%d", move, absoluteMoveNumber, regularMoveNumber, regFicsNumber, localFicsNumber);
	
	if(!firstMoveAbsNum) {
		firstMoveAbsNum = absoluteMoveNumber;
	}
	
	if (absoluteMoveNumber % 2 == 1 && firstMoveAbsNum %2 == 0) {
		regFicsNumber++;
	}
	
	if (absoluteMoveNumber %2 == 1) {
		UILabel *moveNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (regFicsNumber-1)*13, 25, 13)];
		moveNumberLabel.backgroundColor = [UIColor blackColor];
		moveNumberLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveNumberLabel.textColor = [UIColor lightTextColor];
		moveNumberLabel.textAlignment = UITextAlignmentRight;
		moveNumberLabel.text = [NSString stringWithFormat:@"%d.", regularMoveNumber];
		[self addSubview:moveNumberLabel];
		
		UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, (regFicsNumber-1)*13, 60, 13)];
		moveLabel.tag = absoluteMoveNumber;
		moveLabel.backgroundColor = [UIColor blackColor];
		moveLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveLabel.textColor = [UIColor lightTextColor];
		moveLabel.text = move;
		[self addSubview:moveLabel];
	}
	else {
		UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, (regFicsNumber-1)*13, 60, 13)];
		moveLabel.tag = absoluteMoveNumber;
		moveLabel.backgroundColor = [UIColor blackColor];
		moveLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
		moveLabel.textColor = [UIColor lightTextColor];
		moveLabel.text = move;
		[self addSubview:moveLabel];
	}
	
	self.frame = CGRectMake(0, 0, 300, regFicsNumber*13);
	[(UIScrollView *)[self superview] setContentSize:self.frame.size];
	//NSLog(@"currentMoveNumber=%d, absoluteMoveNumber=%d", [StreamController sharedStreamController].currentMoveNumber, [StreamController sharedStreamController].absoluteMoveNumber);
	if ([StreamController sharedStreamController].currentMoveNumber == [StreamController sharedStreamController].absoluteMoveNumber) {
		[self highlightMoveWithAbsoluteMoveNumber:absoluteMoveNumber animated:animated];
	}
}

- (void)addEndLabel:(NSString *)endLabelText withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber {
	NSUInteger regularMoveNumber = (absoluteMoveNumber + 1)/2;
	UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, regularMoveNumber*13, 270, 13)];
	endLabel.backgroundColor = [UIColor blackColor];
	endLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:10];
	endLabel.textColor = [UIColor whiteColor];
	endLabel.text = endLabelText;
	endLabel.tag = END_LABEL;
	[self addSubview:endLabel];
	[endLabel release];
	
	self.frame = CGRectMake(0, 0, 300, regularMoveNumber*13+13);
	[(UIScrollView *)[self superview] setContentSize:self.frame.size];
	if (regularMoveNumber > 3) {
		[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, regularMoveNumber*13, 300, 39) animated:YES];
	}
	hasEndLabel = YES;
}

- (void)highlightMoveWithAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated {
	//NSLog(@"highlight move with absnum=%d", absoluteMoveNumber);
	NSUInteger regularMoveNumber = (absoluteMoveNumber + 1)/2;
	NSEnumerator *enumerator = [[self subviews] objectEnumerator];
	UILabel *tempView;// = [[UILabel alloc] init];
	while (tempView = [enumerator nextObject]) {
		if ([tempView isKindOfClass:[UILabel class]]) {
			if (tempView.tag == absoluteMoveNumber) {
				tempView.textColor = [UIColor whiteColor];
			}
			else {
				if (tempView.tag != END_LABEL) {
					tempView.textColor = [UIColor lightTextColor];
				}
			}
		}
	}
	
	if ([StreamController sharedStreamController].server == FICS) {
		if (regularMoveNumber > 3) {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, [StreamController sharedStreamController].currentMoveNumber*13-39, 300, 39) animated:animated];
		}
		else {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, 0, 300, 39) animated:animated];
		}
	}
	else if ([StreamController sharedStreamController].server == ICC) {
		if (regularMoveNumber > 3) {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, regularMoveNumber*13-39, 300, 39) animated:animated];
		}
		else {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, 0, 300, 39) animated:animated];
		}
	}
}

- (void)scrollToEndLabel {
	if(hasEndLabel) {
		NSUInteger regularMoveNumber = ([StreamController sharedStreamController].absoluteMoveNumber + 1)/2;
		
		if (regularMoveNumber > 2) {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, regularMoveNumber*13-26, 300, 39) animated:YES];
		}
		else {
			[(UIScrollView *)[self superview] scrollRectToVisible:CGRectMake(0, 0, 300, 39) animated:YES];
		}
	}
}

@end
