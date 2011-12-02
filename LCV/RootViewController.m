//
//  ViewController.m
//  LCV
//
//  Created by David Alkire on 12/1/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#define VIEW_CONTROLLER_MENU            100
#define VIEW_CONTROLLER_CURRENT_GAMES   101
#define VIEW_CONTROLLER_WATCH_BOARD     102
#define VIEW_CONTROLLER_PRACTICE_BOARD  103


#import "RootViewController.h"

@implementation RootViewController

@synthesize toolbar                     = _toolbar;
@synthesize navigationController        = _navigationController;
@synthesize currentViewController       = _currentViewController;
@synthesize menuTableViewController     = _menuTableViewController;
@synthesize currentGamesViewController  = _currentGamesViewController;
@synthesize boardViewController         = _boardViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"init");
        _currentViewController = 0;
        _navigationController = nil;
        _menuTableViewController  = [[MenuTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [_menuTableViewController setDelegate:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    NSLog(@"loadview");
    [super loadView];
    float width = 0;
    float height = 0;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            width = [UIScreen mainScreen].bounds.size.height;
            height = [UIScreen mainScreen].bounds.size.width;
            break;
            
        default:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    UIBarButtonItem *menuBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-menu.png"] 
                                                                   style:UIBarButtonItemStyleBordered 
                                                                  target:self 
                                                                  action:@selector(didTouchMenu)];
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                               target:self 
                               action:@selector(didTouchEdit)];
    UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-add.png"] 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(addCourseModal)];
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    _toolbar = [[UIToolbar alloc] init];
    [_toolbar setBarStyle:UIBarStyleBlack];
    [_toolbar sizeToFit];
    [_toolbar setItems:[NSArray arrayWithObjects:menuBtn, nil]];
    
    [view addSubview:_toolbar];
    [self setView:view];
    [_toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation != UIInterfaceOrientationLandscapeLeft && interfaceOrientation != UIInterfaceOrientationLandscapeRight);
    } else {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && interfaceOrientation != UIInterfaceOrientationPortrait);
    }
}

#pragma mark - toolbar actions

- (void)didTouchMenu
{
    NSLog(@"Did touch menu");
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:_menuTableViewController];
        [_navigationController.view setFrame:CGRectMake(_navigationController.view.frame.origin.x, 
                                                        _navigationController.view.frame.origin.y - 20, 
                                                        _navigationController.view.frame.size.width, 
                                                        _navigationController.view.frame.size.height)];
        [self.toolbar setHidden:YES];
        [self presentModalViewController:_navigationController animated:YES];
    }
}

#pragma mark - delegate functions

- (void)dismissMenu
{
    [self dismissModalViewControllerAnimated:YES];
    [self.toolbar setHidden:NO];
}

@end
