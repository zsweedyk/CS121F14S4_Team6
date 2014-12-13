//
//  HighScoreTest.m
//  Nom Nom Numbers
//
//  Created by Shannon on 12/13/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "HighScoreModel.h"

@interface HighScoreTest : XCTestCase
{
    HighScoreModel* _highScoreDB;
}
@end

@implementation HighScoreTest

- (void) setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _highScoreDB = [[HighScoreModel alloc] init];
    [_highScoreDB checkExists];
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testGetTopTenForTimed {
    NSMutableArray* topTen = [_highScoreDB getTopTenForTimed];
    XCTAssertTrue([topTen count] <= 10, @"Array too large");
    XCTAssertTrue([[topTen objectAtIndex:0] doubleValue] >= [[topTen objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:1] doubleValue] >= [[topTen objectAtIndex:2] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:2] doubleValue] >= [[topTen objectAtIndex:3] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:3] doubleValue] >= [[topTen objectAtIndex:4] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:4] doubleValue] >= [[topTen objectAtIndex:5] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:5] doubleValue] >= [[topTen objectAtIndex:6] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:6] doubleValue] >= [[topTen objectAtIndex:7] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:7] doubleValue] >= [[topTen objectAtIndex:8] doubleValue], @"Incorrect order");
    XCTAssertTrue([[topTen objectAtIndex:8] doubleValue] >= [[topTen objectAtIndex:9] doubleValue], @"Incorrect order");
}

- (void) testGetTopTenForTarget {
    NSMutableArray* topTen = [_highScoreDB getTopTenForTarget];
    XCTAssertTrue([topTen count] <= 10, @"Array too large");
    XCTAssertTrue([[[topTen objectAtIndex:0] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:1] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:1] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:2] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:2] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:3] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:3] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:4] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:4] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:5] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:5] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:6] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:6] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:7] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:7] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:8] objectAtIndex:1] doubleValue], @"Incorrect order");
    XCTAssertTrue([[[topTen objectAtIndex:8] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:9] objectAtIndex:1] doubleValue], @"Incorrect order");
}

@end
