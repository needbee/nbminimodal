//
//  NBSampleMiniModal.h
//  demo
//
//  Created by Josh Justice on 3/15/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBMiniModal.h"

@interface NBSampleMiniModal : NBMiniModal

-(id)initWithMessage:(NSString *)message
            delegate:(id<NBMiniModalDelegate>)delegate;

@end
