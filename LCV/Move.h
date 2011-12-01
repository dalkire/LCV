//
//  Move.h
//  Live Chess Viewer
//
//  Created by David Alkire on 6/08/10.
//  Copyright PixelSift Studios 2010. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Move : NSObject {
	NSNumber *moveNumber;
	NSNumber *absoluteMoveNumber;
	NSNumber *timeLeftInSeconds;
	NSString *color;
	NSString *algebraic;
	NSString *smith;
}

@property (nonatomic, retain) NSNumber *moveNumber;
@property (nonatomic, retain) NSNumber *absoluteMoveNumber;
@property (nonatomic, retain) NSNumber *timeLeftInSeconds;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSString *algebraic;
@property (nonatomic, retain) NSString *smith;

@end
