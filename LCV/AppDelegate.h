//
//  AppDelegate.h
//  LCV
//
//  Created by David Alkire on 12/1/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamController.h"

@class RootViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RootViewController *rootViewController;

@end
