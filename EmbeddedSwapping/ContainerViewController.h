//
//  ContainerViewController.h
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController* currentController;

@property (nonatomic, strong) void(^animationBlock)(UIViewController* container, UIViewController* fromViewController, UIViewController* toViewController);

@end
