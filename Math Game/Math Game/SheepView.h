//
//  UIView+SheepView.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>
//@import SpriteKit;

@interface SheepView: UIView

- (void) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point;

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end;

- (void) displayValue:(double)value;

- (void) displayOperator:(NSString*)string;

- (void) onTimer;

@end
