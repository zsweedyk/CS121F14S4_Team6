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
    
}

@end

@implementation SheepController : UIViewController


- (void)generateSheep:(UIView*)view {
    
    NSString* value;
    char operator;
    
    //while (!(_sheepOnScreen)) {
        SheepModel* newSheepModel = [SheepModel alloc];
        [newSheepModel makeSheep];
        value = [newSheepModel getValue];
        operator = [newSheepModel getOperator];
        
        SheepView* newSheepView = [[SheepView alloc] initWithFrame:view.frame];
//        [newSheepView displayValue:value];
//        [newSheepView displayOperator:operator];
    
    
        [newSheepView moveSheepFrom:CGPointMake(800.0, 500.0) to:CGPointMake(0.0, 0.0)];
    
        [view addSubview:newSheepView];
    
    
    
    //}
}

- (void)noSheepOnScreen:(SheepView *)controller trueOrFalse:(bool)boolean {
    _sheepOnScreen = boolean;
}

- (void)setSheepOnScreen:(bool)boolean {
    _sheepOnScreen = boolean;
}

@end
