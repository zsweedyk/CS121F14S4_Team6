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

int _currentScore = 0;

- (void)applySheepToScore: (int)newScore
{
    _currentScore = newScore;
}

- (int)getScore
{
    return _currentScore;
}

@end
