//
//  GeneratorTest.m
//  Nom Nom Numbers
//
//  Created by Yaxi Gao on 11/3/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Generator.h"

@interface GeneratorTest : XCTestCase
{
    Generator* _generator;
}
@end


@implementation GeneratorTest

- (void) setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _generator = [[Generator alloc] init];
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testOperator
{
    // check if the randomly generated operator is valid
    
    for (int i = 0; i < 11; ++i) {
        char operator = [_generator generateOperator];
        
        XCTAssertTrue((operator == '+') || (operator == '-') || (operator == 'x') || (operator == '/'), @"Not a valid operator");
    }
}

- (void) testInteger
{
    // check if the randomly generated integer is within the right range
    
    for (int i = 0; i < 11; ++i) {
        
        int start = arc4random() % 200 - 100;
        int end = arc4random_uniform(200) + start;
        XCTAssert(end >= start);
        int value = [_generator generateIntegerfrom:start to:end];
        XCTAssertTrue((value >= start) && (value <= end), @"String is not a valid length");
    }
}

- (void) testFraction
{
    // check if the randomly generated fraction is valie
    for (int i = 0; i < 11; ++i) {
        NSMutableArray* fraction = [_generator generateFraction];
        XCTAssertFalse([fraction objectAtIndex:0]>[fraction objectAtIndex:1], @"Denomenator is greater than numerator");
    }
}


@end
