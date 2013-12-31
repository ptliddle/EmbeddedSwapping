//
//  ContainerViewController.m
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//  Heavily inspired by http://orderoo.wordpress.com/2012/02/23/container-view-controllers-in-the-storyboard/
//

#import "ContainerViewController.h"

@interface ContainerViewController () {
    dispatch_queue_t serialTransitionQueue;
}

@end

@implementation ContainerViewController

@synthesize currentController=_currentController;
@synthesize animationBlock=_animationBlock;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _animationBlock = ^void(UIViewController* container, UIViewController* fromViewController, UIViewController* toViewController) {
            // no animation by default
            [fromViewController removeFromParentViewController];
            [container.view addSubview:toViewController.view];

            [toViewController didMoveToParentViewController:container];
        };

        _currentController = nil;

        serialTransitionQueue = dispatch_queue_create("com.EmbeddedSwapping.queue", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* destController = segue.destinationViewController;
    UIView* destView = destController.view;

    destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

    if (self.currentController == nil) {
        [destController willMoveToParentViewController:self];

        [self addChildViewController:destController];
        [self.view addSubview:destView];

        [destController didMoveToParentViewController:self];
    } else {
        [self moveFromViewController:self.currentController toViewController:destController];
    }

    _currentController = destController;
}

- (void)moveFromViewController:(UIViewController*)from toViewController:(UIViewController*)to {
    dispatch_async(serialTransitionQueue, ^(void){
        dispatch_sync(dispatch_get_main_queue(), ^(void){
            [to willMoveToParentViewController:self];

            [self addChildViewController:to];
            self.animationBlock(self, from, to);
        });
    });
}

@end
