//
//  RootViewController.h
//  LCV
//
//  Created by David Alkire on 12/1/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StreamController.h"
#import "MenuTableViewController.h"
#import "PracticeViewController.h"
#import "CurrentGamesViewController.h"
#import "BoardViewController.h"
#import "LoadingView.h"
#import "ActionBadgesViewController.h"

@interface RootViewController : UIViewController <MenuTableViewControllerDelegate, StreamControllerDelegate, ActionBadgesViewControllerDelegate>
{
    //UIToolbar *toolbar;
    StreamController *streamController;
    int currentViewController;
    UINavigationController *navigationController;
    CurrentGamesViewController *currentGamesViewController;
    BoardViewController *watchingViewController;
}

//@property (nonatomic, retain) UIToolbar *toolbar;
@property (nonatomic, retain) StreamController *streamController;
@property int currentViewController;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) CurrentGamesViewController *currentGamesViewController;
@property (nonatomic, retain) BoardViewController *watchingViewController;

- (void)loadPracticeView;
- (void)loadWatchView;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end