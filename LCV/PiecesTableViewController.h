//
//  PiecesTableViewController.h
//  LCV
//
//  Created by David Alkire on 12/15/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Definitions.h"

@interface PiecesTableViewController : UITableViewController
{
    id delegate;
    NSMutableArray *piecesArray;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSMutableArray *piecesArray;

@end
