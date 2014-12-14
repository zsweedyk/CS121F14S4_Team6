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

    
    //Assert that an incorrect range raises an exception
    XCTAssertThrowsSpecific([_sheepModel makeSheepFrom:100 to:99], NSException);
    
    //Assert that operator and value is never returned uninitialized
    [_sheepModel makeSheepFrom:-100 to:100];
    char operator = [_sheepModel getOperator];
    NSString* value = [_sheepModel getValue];
    NSAssert(operator != ' ', @"empty operator string");
    if (operator != 'A') {
        NSAssert(![value isEqualToString:@" "], @"empty value string");
    }
    
    
}




@end
