//
//  UIViewController+MiniModal.h
//
//  Created by Josh Justice on 11/23/13.
//  Copyright (c) 2013 NeedBee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBMiniModal.h"

@interface UIViewController (MiniModal)

-(void)displayMiniModal:(NBMiniModal *)modal;
-(void)dismissMiniModal;

@property (nonatomic,retain) NBMiniModal *miniModal;
@property (nonatomic,retain) UIView *miniModalMask;

@end
