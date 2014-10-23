//
//  NSObject+DataModel.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataModel.h"
#import "Generator.h"

@interface DataModel () {
    char _operator;
    NSString *_value;
    Generator *_generator;
}
@end

@implementation DataModel

-(id)init
{
    if (self = [super init]) {
        _generator = [[Generator alloc]init];
    }
    
    return self;
}

-(NSString*) getValue
{
    return _value;
}

-(char) getOperator
{
    return _operator;
}

-(void) makeSheep
{
    int chanceIndicator = arc4random_uniform(10);
    
    if (chanceIndicator == 1) {
        _operator = 'A';
        _value= [NSString stringWithFormat:@" "];
    } else {
        if (chanceIndicator % 2 == 0) {
            int value = [_generator generateIntegerfrom:-100 to:100];
            _value = [NSString stringWithFormat:@"%d", value];
        } else {
            NSMutableArray* fraction = _generator.generateFraction;
            int numerator = (int)[[fraction objectAtIndex:0] integerValue];
            int denomenator = (int)[[fraction objectAtIndex:1] integerValue];
            float result = (float)numerator / (float)denomenator;
            if (numerator == 0) {
                _value = [NSString stringWithFormat:@"%d / %d (0)", numerator, denomenator];
            } else {
                _value = [NSString stringWithFormat:@"%d / %d ( %.3f )", numerator, denomenator, result];
            }
            
        }
        _operator = _generator.generateOperator;
    }
    
}

@end
