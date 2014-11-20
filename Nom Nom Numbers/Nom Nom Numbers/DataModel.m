//
//  DataModel.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataModel.h"


@implementation DataModel

@synthesize _currentScore;
@synthesize _targetScore;


// Changes the score appropriately when a sheep is selected
- (void) applySheepChar:(char)operator andValue:(NSString *)givenValue
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
    } else if (operator == 'A') {
        _currentScore = fabs(_currentScore);
    }
    
}

// Retrieves the score in the DataModel
- (double) getScore
{
    return _currentScore;
}

// Given a target score, assign this value to a public variable
- (void) setTargetScore:(int)score
{
    _targetScore = score;
}

// Return targetScore
- (int) getTargetScore
{
    return _targetScore;
}

// Reset score when game is restarted
- (void) resetScore
{
    _currentScore = 0;
}

@end
