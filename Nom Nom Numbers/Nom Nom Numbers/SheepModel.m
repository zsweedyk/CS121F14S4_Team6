//
//  NSObject+SheepModel.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepModel.h"
#import "Generator.h"

@interface SheepModel ()
{
    char _operator;
    bool _scoreIsLow;
    bool _firstRound;
    NSString* _value;
    Generator* _generator;
    int _fromInt;
    int _toInt;
}
@end

@implementation SheepModel

// Initialize SheepModel
- (id) init
{
    if (self = [super init]) {
        _generator = [[Generator alloc]init];
    }
    _scoreIsLow = false;
    _firstRound = true;
    
    return self;
}

- (void) setValue:(NSString *)value
{
    _value = value;
}

- (void) setOper:(char)operator
{
    _operator = operator;
}

// Return value of sheep
- (NSString *) getValue
{
    return _value;
}

// Return operator of sheep
- (char) getOperator
{
    return _operator;
}

- (void) makeSheepFrom:(int)start to:(int)end
{
    NSAssert(start <= end, @"end is less than start");
    
    int chanceIndicator = arc4random_uniform(50);
    
    if (_scoreIsLow) {
        
        if (chanceIndicator < 40) {
            chanceIndicator = 32;
        } else {
            chanceIndicator = 34;
        }
    }
    
    if (chanceIndicator == 1) {
        _operator = 'A';
        _value= [NSString stringWithFormat:@" "];
        
    } else {
        _operator = _generator.generateOperator;
        if (_firstRound) {
            if (chanceIndicator < 30) {
                _operator = '+';
            }
        }
        int value;
        
        if (chanceIndicator < 33) {
            if (_operator == 'x') {
                value = [_generator generateIntegerfrom:start/20 to:end/20];
            } else {
                value = [_generator generateIntegerfrom:start to:end];
            }
            if ((_operator == '/') && (value == 0)) {++value;}
            _value = [NSString stringWithFormat:@" %d", value];
            
        } else {
            NSMutableArray* fraction = _generator.generateFraction;
            int numerator = (int)[[fraction objectAtIndex:0] integerValue];
            
            if ((_operator == '/') && (numerator == 0)) {
                ++numerator;
            }
            
            int denomenator = (int)[[fraction objectAtIndex:1] integerValue];
            float result = (float)numerator / (float)denomenator;
            
            if (numerator == 0) {
                _value = [NSString stringWithFormat:@"%d / %d \n (0)", numerator, denomenator];
            } else {
                _value = [NSString stringWithFormat:@" %d / %d \n(%.2f)", numerator, denomenator, result];
            }
            
        }
    }
    
    _firstRound = false;
}

- (void)scoreIsLow:(bool)boolean
{
    _scoreIsLow = boolean;
    [_generator setScoreIsLow:boolean];
}

@end
