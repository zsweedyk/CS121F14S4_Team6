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

- (id) initWithFrame:(UIView*)view withSheepFrame:(CGRect)sheepFrame;
- (void)generateSheepOnScreen:(BOOL)timerRun;

@property(nonatomic, weak) id<sheepControllerDelegate> customSheepControllerDelegate;


- (void)endGame;

@property UIView* viewController;
@property CGRect sheepFrame;
@property NSMutableArray* posArray;
@property BOOL timerOngoing;
@property BOOL gameOver;

@end
