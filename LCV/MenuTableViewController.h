//
//  MenuTableViewController.h
//  LCV
//
//  Created by David Alkire on 12/2/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewController : UITableViewController
{
    id delegate;
    NSMutableArray *sections;
    NSMutableArray *accounts;
    NSMutableArray *preferences;
    NSMutableArray *about;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSMutableArray *accounts;
@property (nonatomic, retain) NSMutableArray *preferences;
@property (nonatomic, retain) NSMutableArray *about;

- (void)didTouchDone;

@end

@protocol MenuTableViewControllerDelegate <NSObject>

- (void)dismissMenu;
- (void)loadTrainingView;

@end
