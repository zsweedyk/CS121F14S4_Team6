//
//  NSObject+SheepModel.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SheepModel : NSObject

- (NSString *) getValue;
- (char) getOperator;
- (void) setValue:(NSString *)value;
- (void) setOper:(char)operator;
- (void) makeSheepFrom:(int)start to:(int)end;
- (void)scoreIsLow:(bool)boolean;

@end