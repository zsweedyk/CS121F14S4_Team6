//
//  UIViewController+SheepController.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepController.h"
#import "SheepModel.h"
#import "SheepView.h"

@interface UIViewController ()

@end

@implementation SheepController : UIViewController

- (id)init
{
    _gameOver = false;
    return self;
}

- (void)generateSheep:(UIView*)view withSheepFrame:(CGRect)sheepFrame onScreen:(BOOL)timerRun
{
    _viewController = view;
    _sheepFrame = sheepFrame;
    _timerOngoing = timerRun;

    SheepModel* newSheepModel = [[SheepModel alloc] init];
    SheepView* newSheepView = [[SheepView alloc] initWithFrame:sheepFrame];
    newSheepView.customSheepViewDelegate = self;
    
    [newSheepModel makeSheep];
    [newSheepView moveSheepFrom:CGPointMake(800.0, 500.0) to:CGPointMake(0.0, 0.0) whileGame:_timerOngoing];
    [newSheepView displayOperator:[newSheepModel getOperator]];
    [newSheepView displayValue:[newSheepModel getValue]];
    [view addSubview:newSheepView];
    
    if (!timerRun) {
        [newSheepView removeFromSuperview];
    }
}

- (void)generateNewSheep
{
    [self generateSheep:_viewController withSheepFrame:_sheepFrame onScreen:_timerOngoing];
}

@end
