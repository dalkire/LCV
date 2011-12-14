//
//  ActionBadgesViewController.m
//  LCV
//
//  Created by David Alkire on 12/9/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#import "ActionBadgesViewController.h"

@implementation ActionBadgesViewController

@synthesize delegate                = _delegate;
@synthesize toolbar                 = _toolbar;
@synthesize bg                      = _bg;
@synthesize watchBadge              = _watchBadge;
@synthesize practiceBadge           = _practiceBadge;
@synthesize reviewBadge             = _reviewBadge;
@synthesize playBadge               = _playBadge;
@synthesize device                  = _device;
@synthesize menuTableViewController = _menuTableViewController;
@synthesize menuPopover             = _menuPopover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        float width = [UIScreen mainScreen].bounds.size.width;
        float height = [UIScreen mainScreen].bounds.size.height - 20; // - 20: status bar
        _device = IPHONE;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            NSLog(@"PAD");
            _device = IPAD;
            width = [UIScreen mainScreen].bounds.size.height;
            height = [UIScreen mainScreen].bounds.size.width - 20;  // - 20: status bar
        }
        
        _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg-red.png"]];
        [_bg setFrame:CGRectMake(0, 0, width, height - 44)]; // - 44: toolbar
        
        _watchBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button-watch.png"]];
        _practiceBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button-practice.png"]];
        _reviewBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button-review.png"]];
        _playBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button-play.png"]];
        
        [_watchBadge setUserInteractionEnabled:YES];
        [_watchBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchWatchBadge)]];
        
        [_practiceBadge setUserInteractionEnabled:YES];
        [_practiceBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchPracticeBadge)]];
        
        [_reviewBadge setUserInteractionEnabled:YES];
        [_reviewBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchReviewBadge)]];
        
        [_playBadge setUserInteractionEnabled:YES];
        [_playBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchPlayBadge)]];
        
        _menuTableViewController  = [[MenuTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [_menuTableViewController setTitle:@"Settings"];
        [_menuTableViewController setDelegate:self];
    }
    return self;
}

- (void)didTouchWatchBadge
{
    NSLog(@"hit watch badge");
    [[StreamController sharedStreamController] setMode:WATCHING];
    [_delegate didTouchWatchBadge];
}

- (void)didTouchPracticeBadge
{
    NSLog(@"hit practice badge");
    [[StreamController sharedStreamController] setMode:PRACTICING];
    [_delegate didTouchPracticeBadge];
}

- (void)didTouchReviewBadge
{
    NSLog(@"hit review badge");
    [_delegate didTouchReviewBadge];
}

- (void)didTouchPlayBadge
{
    NSLog(@"hit play badge");
    [_delegate didTouchPlayBadge];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height - 20;
    _device = IPHONE;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSLog(@"PAD");
        _device = IPAD;
        width = [UIScreen mainScreen].bounds.size.height;
        height = [UIScreen mainScreen].bounds.size.width - 20;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    UIView *container = [[UIView alloc] init];
    
    float badgeWidth = _watchBadge.image.size.width;
    float badgeHeight = _watchBadge.image.size.height;
    
    switch (_device) {
        case IPHONE:
            badgeWidth = _watchBadge.image.size.width/2.2;
            badgeHeight = _watchBadge.image.size.height/2.2;
            
            [_watchBadge setFrame:CGRectMake(0, 0, badgeWidth, badgeHeight)];
            [_practiceBadge setFrame:CGRectMake(0, badgeHeight + 8, badgeWidth, badgeHeight)];
            [_reviewBadge setFrame:CGRectMake(0, (badgeHeight + 8)*2, badgeWidth, badgeHeight)];
            [_playBadge setFrame:CGRectMake(0, (badgeHeight + 8)*3, badgeWidth, badgeHeight)];
            
            [container addSubview:_watchBadge];
            [container addSubview:_practiceBadge];
            [container addSubview:_reviewBadge];
            [container addSubview:_playBadge];
            
            container.frame = CGRectMake(0, 0, badgeWidth, badgeHeight*4 + 8*3);
            container.frame = CGRectMake((width - container.frame.size.width)/2, (height - 44 - container.frame.size.height)/2, container.frame.size.width, container.frame.size.height);
            
            break;
        case IPAD:
            badgeWidth = _watchBadge.image.size.width/1.3;
            badgeHeight = _watchBadge.image.size.height/1.3;
            
            [_watchBadge setFrame:CGRectMake(0, 0, badgeWidth, badgeHeight)];
            [_practiceBadge setFrame:CGRectMake(badgeWidth + 40, 0, badgeWidth, badgeHeight)];
            [_reviewBadge setFrame:CGRectMake(0, badgeHeight + 40, badgeWidth, badgeHeight)];
            [_playBadge setFrame:CGRectMake(badgeWidth + 40, badgeHeight + 40, badgeWidth, badgeHeight)];
            
            [container addSubview:_watchBadge];
            [container addSubview:_practiceBadge];
            [container addSubview:_reviewBadge];
            [container addSubview:_playBadge];
            
            container.frame = CGRectMake(0, 0, badgeWidth*2 + 40, badgeHeight*2 + 40);
            container.frame = CGRectMake((width - container.frame.size.width)/2, (height - 44 - container.frame.size.height)/2, container.frame.size.width, container.frame.size.height);
            
            break;
            
        default:
            break;
    }
    
    
    UIBarButtonItem *menuBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-settings.png"] 
                                                               style:UIBarButtonItemStyleBordered 
                                                              target:self 
                                                              action:@selector(didTouchMenu)];
    
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, height - 44, width, 44)];
    [_toolbar setBarStyle:UIBarStyleBlack];
    [_toolbar setItems:[NSArray arrayWithObjects:flex, menuBtn, nil]];
    
    [view addSubview:_bg];
    [view addSubview:container];
    [view addSubview:_toolbar];
    
    [self setView:view];
    [view release];
}

- (void)didTouchMenu
{
    NSLog(@"Did touch menu");
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_menuTableViewController];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [navigationController.view setFrame:CGRectMake(navigationController.view.frame.origin.x, 
                                                       navigationController.view.frame.origin.y - 20, 
                                                        navigationController.view.frame.size.width, 
                                                        navigationController.view.frame.size.height)];
        [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        [self presentModalViewController:navigationController animated:YES];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        navigationController = [[UINavigationController alloc] initWithRootViewController:_menuTableViewController];
        [navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        
        _menuPopover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
        [_menuPopover presentPopoverFromBarButtonItem:[[_toolbar items] objectAtIndex:1] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}

#pragma mark - delegate functions

- (void)dismissMenu
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [_menuPopover dismissPopoverAnimated:YES];
    }
}

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
