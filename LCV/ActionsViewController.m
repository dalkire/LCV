//
//  ActionsViewController.m
//  LCV
//
//  Created by David Alkire on 12/9/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import "ActionsViewController.h"

@implementation ActionsViewController

@synthesize watchBadge      = _watchBadge;
@synthesize practiceBadge   = _practiceBadge;
@synthesize playBadge       = _playBadge;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _watchBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watch-badge.png"]];
        _practiceBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"practice-badge.png"]];
        _playBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-badge.png"]];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
