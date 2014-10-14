//
//  DataModel.m
//  TestTimer
//
//  Created by Shannon on 10/12/14.
//  Copyright (c) 2014 Shannon Lin. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

int _currentScore = 0;

- (void)setScore: (int)newScore
{
    _currentScore = newScore;
    NSLog(@"Current score is: %d", _currentScore);
}

- (int)getScore
{
    return _currentScore;
}

@end
