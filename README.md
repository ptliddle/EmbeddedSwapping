Demonstration of how to make a custom container view controller manage multiple child view controllers using storyboards. This idea based on [mluton/EmbeddedSwapping](https://github.com/mluton/EmbeddedSwapping) code.

The child view controllers are connected to their container with a custom segue. The custom segue doesn't do anything but exists for the purpose of connecting things together in the storyboard. The custom container view controller manages the child view controllers in `prepareForSegue:sender`.

Usage example with custom animation:

```objective-c
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
```

MIT license.
