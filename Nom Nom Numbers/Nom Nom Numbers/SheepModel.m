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
    NSString *_value;
    Generator *_generator;
}
@end

@implementation SheepModel

- (id) init
{
    if (self = [super init]) {
        _generator = [[Generator alloc]init];
    }
    
    return self;
}

- (NSString*) getValue
{
    return _value;
}

- (char) getOperator
{
    return _operator;
}

// Makes sheep with operator and value
- (void) makeSheep
{
    int chanceIndicator = arc4random_uniform(75);
    
    if (chanceIndicator == 1) {
        _operator = 'A';
        _value= [NSString stringWithFormat:@" "];
        
    } else {
        _operator = _generator.generateOperator;
        
        if (chanceIndicator % 2 == 0) {
            int value = [_generator generateIntegerfrom:-100 to:100];
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
}


@end

