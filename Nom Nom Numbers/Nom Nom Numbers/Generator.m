//
//  NSObject+Generator.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "Generator.h"

@implementation Generator {
    bool _scoreIsLow;
}

- (id) init {
    _scoreIsLow = false;
    
    return self;
}

// Randomly generate an integer between the given range
- (int) generateIntegerfrom:(int)lower to:(int)upper
{
    return (arc4random() % (upper-lower)) + lower;
}

// Randomly generate a fraction
- (NSMutableArray *) generateFraction
{
    NSMutableArray* values = [[NSMutableArray alloc] init];
    
    NSInteger denomenator = arc4random_uniform(5) + 1;
    NSInteger numerator = arc4random_uniform((int)denomenator);
    [values addObject:[NSNumber numberWithInteger:numerator]];
    [values addObject:[NSNumber numberWithInteger:denomenator]];
    return values;
}

// Randomly generate one of the four operators
- (char) generateOperator
{
    int value = arc4random_uniform(6);
    switch (value) {
        case 0:
            return '+';
            break;
        case 1:
            return '-';
            break;
        case 2:
            return '/';
            break;
        case 3:
            return 'x';
            break;
        case 4:
            //If score is low, increase chances of generating '+' or '*'
            if (_scoreIsLow) {
                return '+';
            } else {
                return '-';
            }
        default:
            if (_scoreIsLow) {
                return 'x';
            } else {
                return '/';
            }
            
    }
}

// Function that sets boolean to indicate if score is low
- (void)setScoreIsLow:(bool)boolean
{
    _scoreIsLow = boolean;
}

@end
