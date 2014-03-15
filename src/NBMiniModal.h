//
//  NBMiniModal.h
//
//  Created by Josh Justice on 11/21/13.
//  Copyright (c) 2013 NeedBee. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NBMiniModalDelegate;

@interface NBMiniModal : UIView

@property (nonatomic,retain) id<NBMiniModalDelegate> delegate;

@end

@protocol NBMiniModalDelegate

-(void)completedMiniModal:(NBMiniModal *)modal;

@end
