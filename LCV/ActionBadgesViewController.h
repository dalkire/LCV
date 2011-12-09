//
//  ActionBadgesViewController.h
//  LCV
//
//  Created by David Alkire on 12/9/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionBadgesViewController : UIViewController {
    UIImageView *watchBadge;
    UIImageView *practiceBadge;
    UIImageView *reviewBadge;
    UIImageView *playBadge;
    int device;
}

@property (nonatomic, retain) UIImageView *watchBadge;
@property (nonatomic, retain) UIImageView *practiceBadge;
@property (nonatomic, retain) UIImageView *reviewBadge;
@property (nonatomic, retain) UIImageView *playBadge;
@property int device;

@end
