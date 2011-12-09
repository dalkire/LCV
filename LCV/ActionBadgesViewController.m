//
//  ActionBadgesViewController.m
//  LCV
//
//  Created by David Alkire on 12/9/11.
//  Copyright (c) 2011 PixelSift Studios. All rights reserved.
//

#define IPHONE_OLD      1
#define IPHONE_RETINA   2
#define IPAD            3

#import "ActionBadgesViewController.h"

@implementation ActionBadgesViewController

@synthesize delegate        = _delegate;
@synthesize watchBadge      = _watchBadge;
@synthesize practiceBadge   = _practiceBadge;
@synthesize reviewBadge     = _reviewBadge;
@synthesize playBadge       = _playBadge;
@synthesize device          = _device;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self.view setUserInteractionEnabled:YES];
        _watchBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watch-badge"]];
        _practiceBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"practice-badge"]];
        //_reviewBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"review-badge"]];
        _playBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play-badge"]];
        
        [_watchBadge setUserInteractionEnabled:YES];
        [_watchBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchWatchBadge)]];
        
        [_practiceBadge setUserInteractionEnabled:YES];
        [_practiceBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchPracticeBadge)]];
        
        //[_reviewBadge setUserInteractionEnabled:YES];
        //[_reviewBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchReviewBadge)]];
        
        [_playBadge setUserInteractionEnabled:YES];
        [_playBadge addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchPlayBadge)]];
    }
    return self;
}

- (void)didTouchWatchBadge
{
    NSLog(@"hit watch badge");
    [_delegate didTouchWatchBadge];
}

- (void)didTouchPracticeBadge
{
    NSLog(@"hit practice badge");
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
    float width = 0;
    float height = 0;
    _device = IPHONE_RETINA;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        NSLog(@"PHONE");
        width = [UIScreen mainScreen].bounds.size.width;
        height = [UIScreen mainScreen].bounds.size.height;
        
        if (width < 600) {
            _device = IPHONE_OLD;
        }
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSLog(@"PAD");
        _device = IPAD;
        width = [UIScreen mainScreen].bounds.size.height;
        height = [UIScreen mainScreen].bounds.size.width;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    switch (_device) {
        case IPHONE_OLD:
        case IPHONE_RETINA:
            [_watchBadge setFrame:CGRectMake(20, _watchBadge.image.size.height/2 + 20, _watchBadge.image.size.width/2, _watchBadge.image.size.height/2)];
            [_practiceBadge setFrame:CGRectMake(20, (_practiceBadge.image.size.height/2 + 20)*2, _practiceBadge.image.size.width/2, _practiceBadge.image.size.height/2)];
            [_playBadge setFrame:CGRectMake(20, (_playBadge.image.size.height/2 + 20)*3, _playBadge.image.size.width/2, _playBadge.image.size.height/2)];
            break;
        case IPAD:
            [_watchBadge setFrame:CGRectMake(_watchBadge.image.size.width + 20, height/2 - _watchBadge.image.size.height, _watchBadge.image.size.width, _watchBadge.image.size.height)];
            [_practiceBadge setFrame:CGRectMake((_practiceBadge.image.size.width + 20)*2, height/2 - _practiceBadge.image.size.height, _practiceBadge.image.size.width, _practiceBadge.image.size.height)];
            [_playBadge setFrame:CGRectMake((_playBadge.image.size.width + 20)*3, height/2 - _playBadge.image.size.height, _playBadge.image.size.width, _playBadge.image.size.height)];
            break;
            
        default:
            break;
    }
    
    [view addSubview:_watchBadge];
    [view addSubview:_practiceBadge];
    [view addSubview:_playBadge];
    
    [self setView:view];
    [view release];
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
