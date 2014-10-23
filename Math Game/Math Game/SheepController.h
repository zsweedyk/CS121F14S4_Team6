//
//  UIViewController+SheepController.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheepView.h"


@interface SheepController : UIViewController <sheepViewDelegate>

- (void)generateSheep:(UIView*)view;
- (void)setSheepOnScreen:(bool)boolean;

@property bool sheepOnScreen;

@end
