//
//  NSObject+Generator.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Generator : NSObject

- (int) generateIntegerfrom:(int)lower to:(int)upper;
- (NSMutableArray *) generateFraction;
- (char) generateOperator;

@end
