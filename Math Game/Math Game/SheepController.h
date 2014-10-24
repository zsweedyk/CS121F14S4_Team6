//
//  UIViewController+SheepController.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheepView.h"

@class SheepController;
@protocol sheepControllerDelegate

- (void)applySheepToView:(SheepController *)controller withOper:(char)oper andValue:(NSString *)value;

@end

@interface SheepController : UIViewController <sheepViewDelegate>

@property(nonatomic, weak) id<sheepControllerDelegate> customSheepControllerDelegate;

- (void)generateSheep:(UIView*)view withSheepFrame:(CGRect)sheepFrame onScreen:(BOOL)timerRun;
- (void)endGame;

@property UIView* viewController;
@property CGRect sheepFrame;
@property BOOL timerOngoing;
@property BOOL gameOver;

@end
