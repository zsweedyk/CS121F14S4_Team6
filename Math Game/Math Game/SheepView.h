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


@interface SheepView : UIView

@end
