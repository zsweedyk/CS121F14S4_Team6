//
//  DataView.h
//  Math Game
//
//  Created by Shannon on 10/21/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataView;
@protocol gameOverDelegate

- (void)showGameResults:(DataView *)controller;

@end

@interface DataView : UIView
{
    int _initialTime;
    UILabel* _currentTime;
    UILabel* _currentScore;
    NSTimer* _gameTimer;
}

@property(nonatomic, weak) id<gameOverDelegate> customDelegate;

- (id) initWithFrame:(CGRect)frame andScore:(double)currentScore;
- (void) updateScore: (double)newScore;
- (void) stopTimer;

@end
