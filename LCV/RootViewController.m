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
#define VIEW_LOADING_VIEW               104


#import "RootViewController.h"

@implementation RootViewController

@synthesize toolbar                     = _toolbar;
@synthesize streamController            = _streamController;
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
        _streamController = [StreamController sharedStreamController];
        [_streamController setDelegate:self];
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
    float width = 0;
    float height = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        NSLog(@"PHONE");
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSLog(@"PAD");
        width = [UIScreen mainScreen].bounds.size.height;
        height = [UIScreen mainScreen].bounds.size.width;
    }
    
    NSLog(@"width: %f, height: %f", width, height);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    UIView *viewInner = [[UIView alloc] initWithFrame:CGRectMake(0, 20, width, height - 20)];
    
    UIBarButtonItem *menuBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-settings.png"] 
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
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    [_toolbar setBarStyle:UIBarStyleBlack];
    [_toolbar setItems:[NSArray arrayWithObjects:menuBtn, nil]];
    
    [viewInner addSubview:_toolbar];
    
    LoadingView *loadingView = [[LoadingView alloc] init];
    [loadingView setTag:VIEW_LOADING_VIEW];
    
    [view addSubview:viewInner];
    [view addSubview:loadingView];
    
    [self setView:view];
    [view release];
	[[StreamController sharedStreamController] connect];
}

- (void)didConnect
{
    [[self.view viewWithTag:VIEW_LOADING_VIEW] removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
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
    /*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:_menuTableViewController];
        [_navigationController.view setFrame:CGRectMake(_navigationController.view.frame.origin.x, 
                                                        _navigationController.view.frame.origin.y - 20, 
                                                        _navigationController.view.frame.size.width, 
                                                        _navigationController.view.frame.size.height)];
        [_navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        [self presentModalViewController:_navigationController animated:YES];
    }*/
    
    ActionBadgesViewController *actionBadgesViewController = [[ActionBadgesViewController alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:actionBadgesViewController.view];
}

#pragma mark - delegate functions

- (void)dismissMenu
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)loadTrainingView
{
    TrainingViewController *trainingViewController = [[TrainingViewController alloc] initWithNibName:nil bundle:nil];
    [self dismissMenu];
    int len = [[self.view subviews] count];
    for (int i = 0; i < len; i++) {
        [[[self.view subviews] objectAtIndex:i] removeFromSuperview];
    }
    [self.view insertSubview:trainingViewController.view atIndex:0];
}

@end
