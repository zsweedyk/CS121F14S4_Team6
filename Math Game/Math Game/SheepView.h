//
//  UIView+SheepView.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheepView: UIView

- (UIImage*) getImageWithString:(NSString*)text for:(char)input;

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end;

- (void) displayValue:(NSString*)value;

- (void) displayOperator:(char)oper;

- (void) onTimer;

@property UIImageView* sheep;

@end
