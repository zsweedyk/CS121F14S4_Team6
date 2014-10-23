//
//  NSObject+DataModel.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataModel.h"
#import "DataView.h"

@implementation DataModel :NSObject

double _currentScore = 0;

// Changes the score appropriately when a sheep is selected
- (void)applySheepChar:(char)operator andValue:(NSString*)givenValue
{
    double desiredValue = [givenValue doubleValue];
    
    // Parse the NSString
    NSRange textRange = [givenValue rangeOfString:@"("];
    if (textRange.location != NSNotFound)
    {
        NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
        NSArray *splitString = [givenValue componentsSeparatedByCharactersInSet:delimiters];
        desiredValue = [[splitString objectAtIndex:1] doubleValue];
    }
    
    // Apply the operator
    if (operator == '+') {
        _currentScore = _currentScore + desiredValue;
    } else if (operator == '-') {
        _currentScore = _currentScore - desiredValue;
    } else if (operator == '/') {
        _currentScore = _currentScore / desiredValue;
    } else if (operator == 'x') {
        _currentScore = _currentScore * desiredValue;
    } else {
        _currentScore = abs(_currentScore);
    }
    
    NSLog(@"The current value is %.3f", _currentScore);
}

// Retrieves the score in the DataModel
- (double)getScore
{
    return _currentScore;
}

@end
