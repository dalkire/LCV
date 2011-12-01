//
//  MoveListView.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MoveListView : UIView {
	BOOL hasEndLabel;
	NSUInteger firstMoveAbsNum;
}

@property BOOL hasEndLabel;
@property NSUInteger firstMoveAbsNum;

- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated;
- (void)addEndLabel:(NSString *)endLabelText withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber;
- (void)addToMoveListView:(NSString *)move withAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber andLocalFicsNumber:(NSUInteger)localFicsNumber animated:(BOOL)animated;
- (void)highlightMoveWithAbsoluteMoveNumber:(NSUInteger)absoluteMoveNumber animated:(BOOL)animated;
- (void)scrollToEndLabel;

@end
