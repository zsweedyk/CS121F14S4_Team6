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
    NSAssert((operator == '+' || operator == '-' ||
              operator == '/' || operator == 'x' || operator == 'A'), @"Not a valid operator");
    
    double desiredValue = [givenValue doubleValue];
    
    // Parse the NSString
    NSRange textRange = [givenValue rangeOfString:@"("];
    if (textRange.location != NSNotFound) {
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
    
    [self.customDelegate sendScore:_currentScore];
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

- (int) getTargetScore
{
    return _targetScore;
}


// Reset score when game is restarted
- (void) resetScore
{
    _currentScore = 0;
}

// Algorithm to calculate final score when 'Hit me' is pressed
// in target mode
- (double) calculateTargetScoreAtTime:(double)time
{
    int targetScore =  _targetScore;
    
    // Calculate difference between current score and target score
    double diff = abs(_currentScore - targetScore);
    double scoreTargetScorePortion;
    
    //calculate how close current score is to target score as a percentage
    if (abs(targetScore - diff) < 0) {
        scoreTargetScorePortion = 0;
    } else {
        scoreTargetScorePortion = (targetScore - diff)/targetScore;
    }
    
    // Reward a fast time; any time over 10 minutes results in a score of 0
    double score;
    if (time > 600) {
        score = 0;
        
    } else {
        score = (600-time)/600 * scoreTargetScorePortion * 100;
    }
    
    NSAssert(!isnan(score), @"not a number returned");
    return score;
}

@end