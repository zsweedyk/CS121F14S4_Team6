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
    for (int i = 0; i < ([topTen count] - 1); i++) {
        XCTAssertTrue([[topTen objectAtIndex:i] doubleValue] >= [[topTen objectAtIndex:i+1] doubleValue], @"Incorrect order");
    }
}

- (void) testGetTopTenForTarget {
    NSMutableArray* topTen = [_highScoreDB getTopTenForTarget];
    XCTAssertTrue([topTen count] <= 10, @"Array too large");
    
    for (int i = 0; i < ([topTen count] - 1); i++) {
        XCTAssertTrue([[[topTen objectAtIndex:i] objectAtIndex:1] doubleValue] >= [[[topTen objectAtIndex:i+1] objectAtIndex:1] doubleValue], @"Incorrect order");
    }
}

@end
