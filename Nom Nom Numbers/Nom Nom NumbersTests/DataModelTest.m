//
//  DataModelTest.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/3/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DataModel.h"
#import "SheepModel.h"

@interface DataModelTest : XCTestCase
{
    DataModel* _dataModel;
    SheepModel* _sheepModel;
}
@end


@implementation DataModelTest

- (void)setUp {
    
    [super setUp];
    
    _dataModel = [[DataModel alloc] init];
    _sheepModel = [[SheepModel alloc] init];
}

// Check if the score is updated correctly
- (void) testApplySheep
{
    char operator = '+';
    NSString* value = [NSString stringWithFormat:@"34"];
    [_dataModel applySheepChar:operator andValue:value];
    XCTAssertTrue(_dataModel._currentScore == (double)34, @"Wrong Score");
    
    operator = 'x';
    value = [NSString stringWithFormat:@"3/5(0.600)"];
    [_dataModel applySheepChar:operator andValue:value];
    XCTAssertTrue(_dataModel._currentScore == (double)20.4, @"Wrong Score");
    
    operator = '/';
    value = [NSString stringWithFormat:@"-1/2(-0.500)"];
    [_dataModel applySheepChar:operator andValue:value];
    XCTAssertTrue(_dataModel._currentScore == (double)-40.8, @"Wrong Score");
    
    operator = '-';
    value = [NSString stringWithFormat:@"-5"];
    [_dataModel applySheepChar:operator andValue:value];
    XCTAssertTrue(_dataModel._currentScore == (double)-35.8, @"Wrong Score");
    
    operator = 'B';
    value = [NSString stringWithFormat:@"-80"];
    XCTAssertThrows([_dataModel applySheepChar:operator andValue:value], @"Not a valid operator");
}



// Check if the resetScore works properly
- (void) testResetScore
{
    char operator = '-';
    NSString* value = [NSString stringWithFormat:@"34"];
    [_dataModel applySheepChar:operator andValue:value];
    [_dataModel resetScore];
    XCTAssertTrue(_dataModel._currentScore == 0, @"Score is not reset");
}

- (void) testCalculateTargetScore
{
    double time = 40.0;
    
    [_dataModel setTargetScore:(arc4random_uniform(100) - 50)];
    
    
    double targetScore = [_dataModel calculateTargetScoreAtTime:time];
    XCTAssert(targetScore != 0, @"target score is 0");
    XCTAssert(!isnan([_dataModel getScore]), @"nan returned as final score");

    
    
}


@end
