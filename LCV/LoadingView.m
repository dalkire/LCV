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
        CGPoint labelViewOrigin = CGPointMake(frame.size.width/2 - 60, 570); //iPad
        UIImageView *splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default@2x.png"]];
        if (_device == IPHONE) { //iPhone
            labelViewOrigin = CGPointMake(frame.size.width/2 - 70, 800);
            if (frame.size.width < 600) {  //Old iPhone
                splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]];
                labelViewOrigin = CGPointMake(frame.size.width/2 - 70, 700);
            }
        }
        else if (_device == IPAD) {
            splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]];
        }
        
        [self addSubview:splash];
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [activityIndicator startAnimating];
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 120, 24)];
        [loadingLabel setText:@"Connecting..."];
        [loadingLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [loadingLabel setBackgroundColor:[UIColor clearColor]];
        [loadingLabel setTextColor:[UIColor whiteColor]];
        
        [loadingLabel setShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.35]];
        [loadingLabel setShadowOffset:CGSizeMake(0, -1.0)];
        
        UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(labelViewOrigin.x, labelViewOrigin.y, 140, 30)];
        [labelView addSubview:activityIndicator];
        [labelView addSubview:loadingLabel];
        //[labelView setBackgroundColor:[UIColor blueColor]];
        
        [self addSubview:labelView];
        [self bringSubviewToFront:labelView];
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
