//
//  ActionBadgesViewController.h
//  LCV
//
//  Created by David Alkire on 12/9/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionBadgesViewController : UIViewController {
    id delegate;
    UIImageView *bg;
    UIImageView *watchBadge;
    UIImageView *practiceBadge;
    UIImageView *reviewBadge;
    UIImageView *playBadge;
    int device;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UIImageView *bg;
@property (nonatomic, retain) UIImageView *watchBadge;
@property (nonatomic, retain) UIImageView *practiceBadge;
@property (nonatomic, retain) UIImageView *reviewBadge;
@property (nonatomic, retain) UIImageView *playBadge;
@property int device;

@end

@protocol ActionBadgesViewControllerDelegate <NSObject>

- (void)didTouchWatchBadge;
- (void)didTouchPracticeBadge;
- (void)didTouchReviewBadge;
- (void)didTouchPlayBadge;

@end
