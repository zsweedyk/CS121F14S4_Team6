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
    double diff = abs(targetScore - _currentScore);
    double score = 0.0;
    
    // Give scores according to proximity to target score
    if (diff == 0) {
        score = 100;
    } else if (diff < 10) {
        score = 95;
    } else if (diff < 20) {
        score = 80;
    } else if (diff < 40) {
        score = 70;
    } else if (diff < 80) {
        score = 60;
    } else if (diff < 100) {
        score = 50;
    } else {
        score = 40;
    }
    
    // Alter scores depending on time taken
    if (time > 600) {
        score = 0;
    } else if (time < 15) {
        // Do nothing
    } else {
        score = score * (600 - time)/600;
    }

    score = round(100 * score)/100.00;
    NSAssert(!isnan(score), @"Not a number returned");
    return score;
}

@end
