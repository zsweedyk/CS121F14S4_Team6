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

@interface SheepController () {
    @public UIView* _viewController;
    @public CGRect _sheepFrame;
    BOOL _gameOver;
}

@end

@implementation SheepController : UIViewController

- (id)init
{
    _gameOver = false;
    return self;
}

- (void)generateSheep:(UIView*)view withSheepFrame:(CGRect)sheepFrame{
    
    NSLog(@"enter generateSheep");
    
    _viewController = view;
    _sheepFrame = sheepFrame;

    if(!_gameOver){
        NSLog(@"enter while loop generate sheep");
        SheepModel* newSheepModel = [[SheepModel alloc] init];
        SheepView* newSheepView = [[SheepView alloc] initWithFrame:sheepFrame];
        newSheepView.customSheepViewDelegate = self;
    
        [newSheepModel makeSheep];
        [newSheepView moveSheepFrom:CGPointMake(800.0, 500.0) to:CGPointMake(0.0, 0.0)];
        [newSheepView displayOperator:[newSheepModel getOperator]];
        [newSheepView displayValue:[newSheepModel getValue]];
    
        [view addSubview:newSheepView];
        //        _sheepOnScreen = true;
    
    }
}

- (void)generateNewSheep {
    if(!_gameOver){
        NSLog(@"enter generateNewSheep");
        [self generateSheep:_viewController withSheepFrame:_sheepFrame];
    }
}

- (void)endGame
{
    _gameOver = true;
}

//- (void)noSheepOnScreen:(SheepView *)controller trueOrFalse:(bool)boolean {
//    _sheepOnScreen = boolean;
//}

//
//- (void)setSheepOnScreen:(bool)boolean {
//    _sheepOnScreen = boolean;
//}

@end
