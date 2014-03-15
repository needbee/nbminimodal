//
//  NBViewController.m
//  demo
//
//  Created by Josh Justice on 3/15/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBViewController.h"
#import "UIViewController+MiniModal.h"
#import "NBSampleMiniModal.h"

@interface NBViewController ()

-(IBAction)tappedShowMiniModal;

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)tappedShowMiniModal
{
    NBSampleMiniModal *modal = [[NBSampleMiniModal alloc] initWithMessage:@"Hello, world!"
                                                                 delegate:self];
    modal.delegate = self;
    [self displayMiniModal:modal];
}

-(void)completedMiniModal:(NBMiniModal *)modal
{
    [self dismissMiniModal];
}

@end
