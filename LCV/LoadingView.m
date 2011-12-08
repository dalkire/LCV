//
//  LoadingView.m
//  LCV
//
//  Created by David Alkire on 12/7/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#define IPHONE  0
#define IPAD    1

#import "LoadingView.h"

@implementation LoadingView

@synthesize device = _device;

- (id)init
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        _device = IPHONE;
        frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _device = IPAD;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default@2x.png"]];
        if (_device == IPHONE) {
            if (frame.size.width < 600) {  //old iphone
                splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
            }
        }
        else if (_device == IPAD) {
            splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]];
        }
        
        [self addSubview:splash];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(frame.size.width/2, frame.size.height/2, 20, 20)];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [activityIndicator startAnimating];
        [self addSubview:activityIndicator];
        [self bringSubviewToFront:activityIndicator];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
