//
//  SheepModelTest.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/4/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SheepModel.h"

@interface SheepModelTest : XCTestCase
{
    SheepModel* _sheepModel;
}
@end


@implementation SheepModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _sheepModel = [[SheepModel alloc] init];
    
}


- (void) testMakeSheep
{
    // check if the score is updated correctly
    
    [_sheepModel makeSheep];
    char operator = [_sheepModel getOperator];
    NSString* value = [_sheepModel getValue];
    XCTAssertFalse((operator == '/') && (value == [NSString stringWithFormat:@"0"]));
    
    double desiredValue;
    NSRange textRange = [value rangeOfString:@"("];
    if (textRange.location != NSNotFound)
    {
        NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
        NSArray *splitString = [value componentsSeparatedByCharactersInSet:delimiters];
        desiredValue = [[splitString objectAtIndex:1] doubleValue];
    }
    
    XCTAssertFalse((operator == '/') && (desiredValue == 0));
    
}




@end
