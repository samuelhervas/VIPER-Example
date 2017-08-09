//
//  SHFilterPresentationTransition.m
//  r2r
//
//  Created by Samuel Hervás on 6/4/17.
//  Copyright © 2017 Samuel Hervas. All rights reserved.
//

#import "SHFilterPresentationTransition.h"

@interface SHFilterPresentationTransition()<CAAnimationDelegate>

@property (nonatomic, strong) id <UIViewControllerContextTransitioning> context;
@property (nonatomic, assign) CGPoint finalCenter;

@end

@implementation SHFilterPresentationTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.context = transitionContext;
    
    if (!self.isDissmisTransition) {
        [self animatePresentingFrom:fromVC to:toVC];
    } else {
        [self animateDismissFrom:fromVC to:toVC];
    }
}

- (void)animateDismissFrom:(UIViewController*)fromVC to:(UIViewController*)toVC
{
    self.finalCenter = fromVC.view.center;
    
    [UIView
     animateWithDuration:[self transitionDuration:self.context]
     delay:0.0f
     usingSpringWithDamping:0.6f
     initialSpringVelocity:0.8f
     options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
     animations:^{
         fromVC.view.center = CGPointMake(self.finalCenter.x, self.finalCenter.y + 1000.0f);
     } completion:^(BOOL finished) {
         
     }];
    CABasicAnimation *posAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint center = toVC.view.center;
    posAnimation.toValue = [NSValue valueWithCGPoint:center];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithDouble:1.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 0.4f;
    animationGroup.repeatCount = 0.f;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation, nil]];
    animationGroup.delegate = self;
    [toVC.view.layer addAnimation:animationGroup forKey:nil];
    
    
    fromVC.view.center = CGPointMake(self.finalCenter.x, self.finalCenter.y + 1000.0f);
    
}

- (void)animatePresentingFrom:(UIViewController*)fromVC to:(UIViewController*)toVC
{
    self.finalCenter = fromVC.view.center;
    toVC.view.center = CGPointMake(self.finalCenter.x, self.finalCenter.y + 1000.0f);
    UIView *containerView = [self.context containerView];
    [containerView addSubview:toVC.view];
    
    CABasicAnimation *posAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    CGPoint center = fromVC.view.center;
    posAnimation.toValue = [NSValue valueWithCGPoint:center];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithDouble:0.8f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = .5f;
    animationGroup.repeatCount = 0.f;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animationGroup setAnimations:[NSArray arrayWithObjects:scaleAnimation, nil]];
    animationGroup.delegate = self;
    [fromVC.view.layer addAnimation:animationGroup forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    UIViewController *toVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if (self.isDissmisTransition) {
        [self.context completeTransition:flag];
        return;
    }
    
    if (flag) {
        [UIView
         animateWithDuration:[self transitionDuration:self.context]
         delay:0.0f
         usingSpringWithDamping:0.6f
         initialSpringVelocity:0.8f
         options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowAnimatedContent
         animations:^{
             toVC.view.center = CGPointMake(self.finalCenter.x, self.finalCenter.y + 100.0f);
         } completion:^(BOOL finished) {
             [self.context completeTransition:flag];
             toVC.view.center = CGPointMake(self.finalCenter.x, self.finalCenter.y + 100.0f);
             toVC.view.frame = CGRectMake(toVC.view.frame.origin.x, toVC.view.frame.origin.y, toVC.view.frame.size.width, toVC.view.frame.size.height-toVC.view.frame.origin.y);
             
         }];
        
    }
    
}

@end
