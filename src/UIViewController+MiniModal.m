//
//  UIViewController+MiniModal.m
//
//  Created by Josh Justice on 11/23/13.
//  Copyright (c) 2013 NeedBee. All rights reserved.
//

#import "UIViewController+MiniModal.h"
#import <objc/runtime.h>

#define MINI_MODAL_KEY @"miniModal"
#define MINI_MODAL_MASK_KEY @"miniModalMask"

@implementation UIViewController (MiniModal)

-(NBMiniModal *)miniModal
{
    return objc_getAssociatedObject(self, MINI_MODAL_KEY);
}

-(void)setMiniModal:(NBMiniModal *)miniModal
{
    objc_setAssociatedObject(self, MINI_MODAL_KEY, miniModal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)miniModalMask
{
    return objc_getAssociatedObject(self, MINI_MODAL_MASK_KEY);
}

-(void)setMiniModalMask:(UIView *)mask
{
    objc_setAssociatedObject(self, MINI_MODAL_MASK_KEY, mask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)displayMiniModal:(NBMiniModal *)modal
{
    self.miniModal = modal;
    
    // size mask
    self.miniModalMask = [[UIView alloc] initWithFrame:self.view.bounds];
    self.miniModalMask.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    UIGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detectMaskTap:)];
    [self.miniModalMask addGestureRecognizer:gr];
    self.miniModalMask.alpha = 0.0;
    
    // place modal
    CGSize parentSize = self.view.bounds.size;
    CGSize modalSize = modal.frame.size;
    modal.frame = CGRectMake(
                             (parentSize.width - modalSize.width) / 2,
                             (parentSize.height - modalSize.height) / 2,
                             modalSize.width, modalSize.height);
    modal.layer.shadowColor = [UIColor blackColor].CGColor;
    modal.layer.shadowOpacity = 0.5;
    modal.layer.shadowRadius = 5.0;
    modal.layer.shadowOffset = CGSizeMake(0.0, 5.0);
    
    // add parallax
    if( nil != NSClassFromString(@"UIInterpolatingMotionEffect") ) {
        /* has display issues with the translucent mask
         UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
         verticalMotionEffect.minimumRelativeValue = @(-25);
         verticalMotionEffect.maximumRelativeValue = @(25);
         */
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-25);
        horizontalMotionEffect.maximumRelativeValue = @(25);
        
        UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        shadowEffect.minimumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(-12.5, 5)];
        shadowEffect.maximumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(12.5, 5)];
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, shadowEffect];
        [modal addMotionEffect:group];
        
    }
    
    // add views
    [self.miniModalMask addSubview:modal];
    [self.view addSubview:self.miniModalMask];
    //    [self.view addSubview:modal];
    
    // animate alpha
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    self.miniModalMask.alpha = 1.0;
    [UIView commitAnimations];
}

-(void)detectMaskTap:(UIGestureRecognizer *)gesture
{
    UIView *mask = self.miniModalMask;
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gesture;
    CGPoint point = [tap locationInView:mask];
    if( !CGRectContainsPoint(self.miniModal.frame, point) ) {
        [self dismissMiniModal];
    }
}

-(void)dismissMiniModal
{
    UIView *mask = self.miniModalMask;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    mask.alpha = 0.0;
    [UIView setAnimationDidStopSelector:@selector(dismissMiniModalCallback)];
    [UIView commitAnimations];
    
    [self setMiniModal:nil];
}

-(void)dismissMiniModalCallback
{
    [self.miniModalMask removeFromSuperview];
    [self.miniModal removeFromSuperview];
    self.miniModal = nil;
}

@end
