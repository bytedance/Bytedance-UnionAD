//
//  BUDCustomDislikeViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/12/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDCustomDislikeViewController.h"
#import <BUAdSDK/BUAdSDK.h>
@interface BUDCustomDislikeViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) id<BUDislikeReportorDelegate> dislikeReportor;
@property (nonatomic, strong) UITableView *dislikeTableView;
@end

@implementation BUDCustomDislikeViewController

- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.nativeAd = nativeAd;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    CGFloat width = BUDMINScreenSide - 40.0;
    CGFloat height = 285.0;
    self.dislikeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    
    self.dislikeTableView.contentInset = UIEdgeInsetsMake(5.0, 0, 0, 0);
    self.dislikeTableView.delegate = self;
    self.dislikeTableView.dataSource = self;
    self.dislikeTableView.center = self.view.center;
    self.dislikeTableView.layer.cornerRadius = 15.0;
    self.dislikeTableView.layer.masksToBounds = YES;
    self.dislikeTableView.rowHeight = 35.0;
    
    [self.view addSubview:self.dislikeTableView];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    self.dislikeTableView.frame  = CGRectMake(0, 0, BUDMINScreenSide - 40.0, 320.0);
    self.dislikeTableView.center = CGPointMake(size.width * 0.5, size.height * 0.5);
}

- (void)tapGestureAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)totalSections {
    return self.nativeAd.data.filterWords.count;
}

- (id<BUDislikeReportorDelegate>)dislikeReportor {
    if (!_dislikeReportor) {
        _dislikeReportor = [[BUDislikeReportor alloc] initWithNativeAd:self.nativeAd];
    }
    return _dislikeReportor;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint gesturePoint = [gestureRecognizer locationInView:self.view];
    return !CGRectContainsPoint(self.dislikeTableView.frame, gesturePoint) || self.dislikeTableView.hidden ;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self totalSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray<BUDislikeWords *> *options = self.nativeAd.data.filterWords[section].options;
    return options.count == 0 ? 1 : options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kDislikeWordIdentifier"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kDislikeWordIdentifier"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    NSArray<BUDislikeWords *> *options = self.nativeAd.data.filterWords[indexPath.section].options;
    if (options.count == 0) {
        cell.textLabel.text = self.nativeAd.data.filterWords[indexPath.section].name;
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"     %@", options[indexPath.row].name];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;
}

#pragma mark - UItableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BUDislikeWords *dislikeWord = self.nativeAd.data.filterWords[indexPath.section];
    NSArray<BUDislikeWords *> *options = dislikeWord.options;
    if (options.count > 0) {
        dislikeWord = options[indexPath.row];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(customDislike:withNativeAd:didSelected:)]) {
        [self.delegate customDislike:self withNativeAd:self.nativeAd didSelected:dislikeWord];
    }
    [self.dislikeReportor dislikeDidSelected:@[dislikeWord]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    if ([toVC isKindOfClass:[BUDCustomDislikeViewController class]]) {
        // present
        CGRect finallyFrame = [transitionContext finalFrameForViewController:toVC];
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame = finallyFrame;
        CGRect dislikeRect = self.dislikeTableView.frame;
        dislikeRect.origin.y = finallyFrame.size.height;
        self.dislikeTableView.frame = dislikeRect;
        [containerView addSubview:toView];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.dislikeTableView.center = toView.center;
            toView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.25];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        // dimiss
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect dislikeRect = self.dislikeTableView.frame;
            dislikeRect.origin.y = fromView.bounds.size.height;
            self.dislikeTableView.frame = dislikeRect;
            fromView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}
@end
