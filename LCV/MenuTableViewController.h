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
    NSMutableArray *actions;
    NSMutableArray *accounts;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableArray *sections;
@property (nonatomic, retain) NSMutableArray *actions;
@property (nonatomic, retain) NSMutableArray *accounts;

- (void)didTouchDone;

@end

@protocol MenuTableViewControllerDelegate <NSObject>

- (void)dismissMenu;
- (void)loadTrainingView;

@end
