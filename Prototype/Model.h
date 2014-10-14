//
//  Model.h
//  GeneratorPrototype
//
//  Created by Yaxi Gao on 10/12/14.
//  Copyright (c) 2014 Yaxi Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

- (int) generateIntegerfrom:(int)lower to:(int)upper;
- (NSMutableArray*) generateFraction;
- (char) generateOperator;

@end