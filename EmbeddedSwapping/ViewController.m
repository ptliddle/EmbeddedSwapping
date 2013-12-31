//
//  ViewController.m
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//

#import "ViewController.h"
#import "ContainerViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

static NSString* const firstControllerSegueIdentifier = @"embedFirst";
static NSString* const secondControllerSegueIdentifier = @"embedSecond";

@interface ViewController ()
@property (nonatomic, weak) ContainerViewController *containerViewController;

- (IBAction)swapButtonPressed:(id)sender;

@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedContainer"]) {
        self.containerViewController = segue.destinationViewController;

        self.containerViewController.animationBlock = ^void(UIViewController* container, UIViewController* fromViewController, UIViewController* toViewController) {
            [container transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                [fromViewController removeFromParentViewController];
                [toViewController didMoveToParentViewController:self];
            }];
        };
    }
}

- (IBAction)swapButtonPressed:(id)sender {
    if ([self.containerViewController.currentController isKindOfClass:[FirstViewController class]]) {
        [self.containerViewController performSegueWithIdentifier:secondControllerSegueIdentifier sender:self];
    } else {
        [self.containerViewController performSegueWithIdentifier:firstControllerSegueIdentifier sender:self];
    }
}

@end
