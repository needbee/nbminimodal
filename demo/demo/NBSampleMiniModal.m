//
//  NBSampleMiniModal.m
//  demo
//
//  Created by Josh Justice on 3/15/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBSampleMiniModal.h"

@interface NBSampleMiniModal ()

-(void)tappedOk;

@end

@implementation NBSampleMiniModal

-(id)initWithMessage:(NSString *)message
            delegate:(id<NBMiniModalDelegate>)delegate
{
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 280.0, 280.0)];
    if( self ) {
        self.delegate = delegate;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 4.0;
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 50.0, 260.0, 40.0)];
        messageLabel.text = message;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageLabel];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
        okButton.frame = CGRectMake(10.0, 100.0, 260.0, 43.0);
        [okButton setTitle:@"OK" forState:UIControlStateNormal];
        [okButton addTarget:self
                     action:@selector(tappedOk)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:okButton];
    }
    return self;
}

-(void)tappedOk
{
    [self.delegate completedMiniModal:self];
}

@end
