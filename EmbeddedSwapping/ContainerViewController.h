//
//  ContainerViewController.h
//  EmbeddedSwapping
//
//  Created by Michael Luton on 11/13/12.
//  Copyright (c) 2012 Sandmoose Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DelegateProtocol <NSObject>

- (void)viewControllerWillBeginSegue:(UIViewController*)viewController withIdentifier:(NSString*)identifier;

@end

@interface ContainerViewController : UIViewController

@property (nonatomic, weak, readonly) UIViewController* currentController;

@property (nonatomic, strong) void(^animationBlock)(UIViewController* container, UIViewController* fromViewController, UIViewController* toViewController);

@property (nonatomic, weak) NSObject<DelegateProtocol>* segueDelegate;

@end
