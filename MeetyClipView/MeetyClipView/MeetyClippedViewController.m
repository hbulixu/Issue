//
//  MeetyClippedViewController.m
//  MeetyClipView
//
//  Created by 최건우 on 12. 10. 10..
//  Copyright (c) 2012년 최건우. All rights reserved.
//

#import "MeetyClippedViewController.h"
#import "MeetyClippingAnimationViewController.h"
#import "UIView+RectConverting.h"

@interface MeetyClippedViewController ()

@property (nonatomic, strong) UIView* topClipAnimationView;
@property (nonatomic, strong) UIView* bottomClipAnimationView;
@property (nonatomic, strong) UIView* leftClipAnimationView;
@property (nonatomic, strong) UIView* rightClipAnimationView;
@property (nonatomic, strong) UIViewController* viewController;
@property (nonatomic) BOOL lastStatusbarHidden;

@property (nonatomic) BOOL shouldAnimate;

@end

@implementation MeetyClippedViewController
@synthesize clipView=_clipView;
@synthesize maskColor=_maskColor;
@synthesize topClipAnimationView=_topClipAnimationView;
@synthesize bottomClipAnimationView=_bottomClipAnimationView;
@synthesize leftClipAnimationView=_leftClipAnimationView;
@synthesize rightClipAnimationView=_rightClipAnimationView;
@synthesize viewController=_viewController;
@synthesize lastStatusbarHidden=_lastStatusbarHidden;

#pragma mark - Private methods

- (MeetyClippingAnimationViewController*)createAnimationVieController{
    MeetyClippingAnimationViewController* vc = [[MeetyClippingAnimationViewController alloc] init];
    vc.view.backgroundColor = self.maskColor;
    vc.view.frame = [[[UIApplication sharedApplication] keyWindow] bounds];
    vc.viewController = self;
    return vc;
}

- (void)showClipAnimationViewsWithFrame:(CGRect)frame animationViewController:(MeetyClippingAnimationViewController*)animationViewController{
    
    self.topClipAnimationView = [[UIView alloc] init];
    self.bottomClipAnimationView = [[UIView alloc] init];
    self.leftClipAnimationView = [[UIView alloc] init];
    self.rightClipAnimationView = [[UIView alloc] init];
    
    self.topClipAnimationView.backgroundColor = self.maskColor;
    self.bottomClipAnimationView.backgroundColor = self.maskColor;
    self.leftClipAnimationView.backgroundColor = self.maskColor;
    self.rightClipAnimationView.backgroundColor = self.maskColor;
    
    /*
     self.topClipAnimationView.backgroundColor = [UIColor redColor];
     self.bottomClipAnimationView.backgroundColor = [UIColor greenColor];
     self.leftClipAnimationView.backgroundColor = [UIColor blueColor];
     self.rightClipAnimationView.backgroundColor = [UIColor yellowColor];*/
    
    
    [self moveClipAnimationViewsToFrame:frame animationViewController:animationViewController];
    
    [animationViewController.view addSubview:self.topClipAnimationView];
    [animationViewController.view addSubview:self.leftClipAnimationView];
    [animationViewController.view addSubview:self.rightClipAnimationView];
    [animationViewController.view addSubview:self.bottomClipAnimationView];
}

- (void)moveClipAnimationViewsToFrame:(CGRect)frame animationViewController:(MeetyClippingAnimationViewController*)animationViewController{
    CGRect bounds = [animationViewController.view bounds];
    // Top
    self.topClipAnimationView.frame
    = CGRectMake(bounds.origin.x,
                 bounds.origin.y,
                 bounds.size.width,
                 frame.origin.y - bounds.origin.y);
    
    // Bottom
    self.bottomClipAnimationView.frame
    = CGRectMake(bounds.origin.x,
                 bounds.origin.y + frame.size.height + frame.origin.y,
                 bounds.size.width,
                 bounds.origin.y + bounds.size.height - frame.size.height - frame.origin.y);
    
    // Left
    self.leftClipAnimationView.frame
    = CGRectMake(bounds.origin.x,
                 self.topClipAnimationView.frame.origin.y + self.topClipAnimationView.frame.size.height,
                 bounds.origin.x + frame.origin.x,
                 bounds.size.height - (self.topClipAnimationView.frame.origin.y + self.topClipAnimationView.frame.size.height) - (self.bottomClipAnimationView.frame.size.height));
    
    // Right
    self.rightClipAnimationView.frame
    = CGRectMake(bounds.origin.x + frame.origin.x + frame.size.width,
                 self.topClipAnimationView.frame.origin.y + self.topClipAnimationView.frame.size.height,
                 bounds.origin.x + bounds.size.width - frame.size.width - frame.origin.x,
                 bounds.size.height - (self.topClipAnimationView.frame.origin.y + self.topClipAnimationView.frame.size.height) - (self.bottomClipAnimationView.frame.size.height));
}

- (void)removeClipAnimationViews{
    [self.topClipAnimationView removeFromSuperview];
    [self.bottomClipAnimationView removeFromSuperview];
    [self.leftClipAnimationView removeFromSuperview];
    [self.rightClipAnimationView removeFromSuperview];
    
    self.topClipAnimationView = nil;
    self.bottomClipAnimationView = nil;
    self.leftClipAnimationView = nil;
    self.rightClipAnimationView = nil;
}

#pragma mark - Initializers

- (id)initWitClipView:(MeetyClipView *)clipView{
    self = [super init];
    if (self) {
        self.clipView = clipView;
        self.contentView = self.clipView.contentView;
        self.maskColor = [UIColor blackColor];
        self.animationDuration = 0.6;
        self.shouldAnimate = NO;
    }
    return self;
}

#pragma mark - Public methods

- (UIView *)superviewForContentView:(UIView *)contentView{
    return self.view;
}

- (CGRect)frameForContentViewInItsSuperview:(UIView *)superview contentView:(UIView *)contentView{
    CGRect frame = [self.view bounds];
    CGRect contentFrame = contentView.frame;
    
    // Fitting height
    CGFloat ratio = frame.size.width / contentFrame.size.width;
    if (frame.size.height < contentFrame.size.height * ratio) {
        // Fitting width
        ratio = frame.size.height / contentFrame.size.height;
    }
    CGFloat width = floorf(contentFrame.size.width * ratio);
    CGFloat height = floorf(contentFrame.size.height * ratio);
    
    // Origin
    CGFloat x = (frame.size.width - width) / 2;
    CGFloat y = (frame.size.height - height) / 2;
    
    return CGRectMake(x, y, width, height);
}

- (void)presentWithViewController:(UIViewController*)viewController animated:(BOOL)animated{
    self.shouldAnimate = animated;
    self.viewController = viewController;
    
    self.lastStatusbarHidden = [[UIApplication sharedApplication] isStatusBarHidden];
    UIStatusBarAnimation animation;
    if (animated) {
        animation = UIStatusBarAnimationFade;
    } else{
        animation = UIStatusBarAnimationNone;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animation];
    
    [viewController presentViewController:self animated:NO completion:nil];
    if (!animated) {
        [self appearingWillStart];
        [self layoutContentView:self.contentView animated:NO];
        return;
    }
}

- (void)dismissClippedViewControllerAnimated:(BOOL)animated{
    if (!animated) {
        [self disAppearingWillStart];
        [self dismissViewControllerAnimated:NO completion:^{
            self.clipView.contentView = self.contentView;
            [self disAppearingDidFinish];
        }];
        return;
    }
    
    MeetyClippingAnimationViewController* animationViewController = [self createAnimationVieController];
    [animationViewController setViewDidAppearBlock:^(MeetyClippingAnimationViewController* animationViewController) {
        animationViewController.viewDidDisappearBlock = nil;
        CGRect contentFrame = [animationViewController.view convertRectThroughWindow:self.contentView.frame fromView:[self.contentView superview]];
        [self.contentView removeFromSuperview];
        self.contentView.frame = contentFrame;
        [self showClipAnimationViewsWithFrame:contentFrame animationViewController:animationViewController];
        [animationViewController.view insertSubview:self.contentView belowSubview:self.topClipAnimationView];
        [self appearingWillStart];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView animateWithDuration:self.animationDuration animations:^{
            CGRect contentFrame = [animationViewController.view convertRectThroughWindow:[self.clipView frameForContentView] fromView:self.clipView];
            self.contentView.frame = contentFrame;
            [self moveClipAnimationViewsToFrame:[animationViewController.view convertRectThroughWindow:[self.clipView bounds] fromView:self.clipView] animationViewController:animationViewController];
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
            self.clipView.contentView = self.contentView;
            [self dismissViewControllerAnimated:NO completion:nil];
            [self removeClipAnimationViews];
            [self appearingDidFinish];
        }];
    }];
    [self presentViewController:animationViewController animated:NO completion:nil];
}

- (void)layoutContentView:(UIView*)contentView animated:(BOOL)animated{
    UIView* superview = [self superviewForContentView:contentView];
    contentView.frame = [self frameForContentViewInItsSuperview:superview contentView:contentView];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [superview addSubview:contentView];
}

- (void)appearingWillStart{
    
}
- (void)appearingDidFinish{
    
}
- (void)disAppearingWillStart{
    
}
- (void)disAppearingDidFinish{
    
}

#pragma mark - Overrides

#pragma mark UIViewController overrides

- (void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIStatusBarAnimation animation;
    if (animated) {
        animation = UIStatusBarAnimationFade;
    } else{
        animation = UIStatusBarAnimationNone;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIStatusBarAnimation animation;
    if (animated) {
        animation = UIStatusBarAnimationFade;
    } else{
        animation = UIStatusBarAnimationNone;
    }
    [[UIApplication sharedApplication] setStatusBarHidden:self.lastStatusbarHidden withAnimation:animation];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.shouldAnimate) {
        self.shouldAnimate = NO;
        MeetyClippingAnimationViewController* animationViewController = [self createAnimationVieController];
        [self presentViewController:animationViewController animated:NO completion:nil];
        CGRect contentFrame = [animationViewController.view convertRectThroughWindow:self.contentView.frame fromView:self.clipView];
        self.view.alpha = 0;
        
        // Before present
        [self showClipAnimationViewsWithFrame:[animationViewController.view convertRectThroughWindow:[self.clipView bounds] fromView:self.clipView] animationViewController:animationViewController];
        [animationViewController.view insertSubview:self.contentView belowSubview:self.topClipAnimationView];
        self.contentView.frame = contentFrame;
        
        [self appearingWillStart];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView animateWithDuration:self.animationDuration animations:^{
            UIView* superview = [self superviewForContentView:self.contentView];
            CGRect frameInSuperview = [self frameForContentViewInItsSuperview:superview contentView:self.contentView];
            CGRect frame = [animationViewController.view convertRectThroughWindow:frameInSuperview fromView:superview];
            self.contentView.frame = frame;
            self.view.alpha = 1;
            [self moveClipAnimationViewsToFrame:frame animationViewController:animationViewController];
        } completion:^(BOOL finished) {
            [self removeClipAnimationViews];
            [self dismissViewControllerAnimated:NO completion:nil];
            [self layoutContentView:self.contentView animated:YES];
            [self appearingDidFinish];
        }];
    } else{
        [self appearingDidFinish];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return [self.viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (NSUInteger)supportedInterfaceOrientations{
    return [self.viewController supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
