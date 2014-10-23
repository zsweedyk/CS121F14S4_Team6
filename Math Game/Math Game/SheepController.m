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

    int _numSheepOnScreen;
}

@end

@implementation UIViewController (SheepController)


- (void)generateSheep {
    
    double value;
    NSString* operator;
    
    while (_numSheepOnScreen < 4) {
        SheepModel* newSheepModel = [SheepModel alloc];
        newSheepModel.makeSheep;
        value = newSheepModel.getValue;
        operator = newSheepModel.getOperator;
        
        SheepView* newSheepView = [SheepView alloc];
        newSheepView.displayValue(value);
        newSheepView.displayOperator(operator);
    }
}

@end
