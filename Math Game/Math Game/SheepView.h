//
//  UIView+SheepView.h
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SheepView;
@protocol sheepViewDelegate

- (void)generateNewSheepAt:(CGPoint)point;

@end

@interface SheepView: UIView

- (UIImage*) getImageWithString:(NSString*)text for:(char)input;

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end whileGame:(BOOL)gameOngoing;

- (void) displayValue:(NSString*)value;

- (void) displayOperator:(char)oper;

- (void) onTimer;

- (id)initWithFrame:(CGRect)frame;

@property UIImageView* sheep;
@property(nonatomic, weak) id<sheepViewDelegate> customSheepViewDelegate;

@end
