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

- (void)noSheepOnScreen:(SheepView *)controller trueOrFalse:(bool)boolean;

@end

@interface SheepView: UIView

@property(nonatomic, weak) id<sheepViewDelegate> customNumDelegate;

- (void) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point;

- (void) moveSheepFrom:(CGPoint)start to:(CGPoint)end;

- (void) displayValue:(NSString*)value;

- (void) displayOperator:(char)string;

- (void) onTimer;

@property UIImageView* sheep;

@end
