//
//  Model.m
//  GeneratorPrototype
//
//  Created by Yaxi Gao on 10/12/14.
//  Copyright (c) 2014 Yaxi Gao. All rights reserved.
//

#import "Model.h"

@implementation Model

- (int) generateIntegerfrom:(int)lower to:(int)upper
{
    return (arc4random() % (upper-lower)) + lower;
}

- (NSMutableArray*) generateFraction
{
    NSMutableArray *values = [NSMutableArray array];
    values = [[NSMutableArray alloc] init];
    
    
    NSInteger denomenator = arc4random_uniform(10) + 1;
    NSInteger numerator = arc4random_uniform((int)denomenator);
    [values addObject:[NSNumber numberWithInteger:numerator]];
    [values addObject:[NSNumber numberWithInteger:denomenator]];
    return values;
}

- (char) generateOperator
{
    int value = arc4random_uniform(4);
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
        default:
            return '*';
            break;
    }
}

@end
