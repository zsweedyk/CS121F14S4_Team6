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

@interface UIViewController () {
//
//    @public UIView* _viewController;
//    @public CGRect _sheepFrame;

}

@end

@implementation SheepController : UIViewController

- (id)init
{
    _gameOver = false;
    return self;
}

-(id) initWithFrame:(UIView*)view withSheepFrame:(CGRect)sheepFrame {
    
    _viewController = view;
    _sheepFrame = sheepFrame;
    
//    NSMutableArray *yourCGPointsArray = [[NSMutableArray alloc] init];
//    [yourCGPointsArray addObject:[NSValue valueWithCGPoint:CGPointMake(100, 100)]];
//    
//    //Now getting the cgpoint back
//    CGPoint point = [[yourCGPointsArray objectAtIndex:0] CGPointValue];
    
     _posArray = [[NSMutableArray alloc] initWithCapacity:5];
    [_posArray addObject:[NSValue valueWithCGPoint:CGPointMake(800.0, 200.0)]];
    [_posArray addObject:[NSValue valueWithCGPoint:CGPointMake(800.0, 300.0)]];
    [_posArray addObject:[NSValue valueWithCGPoint:CGPointMake(800.0, 400.0)]];
    [_posArray addObject:[NSValue valueWithCGPoint:CGPointMake(800.0, 500.0)]];
    [_posArray addObject:[NSValue valueWithCGPoint:CGPointMake(800.0, 600.0)]];
    
    while ([_posArray count] > 1) {
        [self generateSheep];
    }
    
    return self;
}

- (void)generateSheep {
    

    SheepModel* newSheepModel = [[SheepModel alloc] init];
    CGPoint initialPos = [[_posArray objectAtIndex:0] CGPointValue];
    [_posArray removeObjectAtIndex:0];
    SheepView* newSheepView = [[SheepView alloc] initWithFrame:_sheepFrame];
    newSheepView.customSheepViewDelegate = self;
    
    [newSheepModel makeSheep];
    [newSheepView moveSheepFrom:initialPos to:CGPointMake(0.0, 0.0)];
    [newSheepView displayOperator:[newSheepModel getOperator]];
    [newSheepView displayValue:[newSheepModel getValue]];
    
    [_viewController addSubview:newSheepView];

}

- (void)generateNewSheepAt:(CGPoint)point {
    [_posArray addObject:[NSValue valueWithCGPoint:point]];
    [self generateSheep];
}

@end
