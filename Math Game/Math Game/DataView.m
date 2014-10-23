//
//  DataView.m
//  Math Game
//
//  Created by Shannon on 10/21/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataView.h"

@implementation DataView :UIView

- (id)initWithFrame:(CGRect)frame andScore:(double)currentScore
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Set up initial conditions for timer
        _initialTime = 60;
        
        // Set up UI for Timer label
        CGFloat timerX = CGRectGetWidth(frame) * .45;
        CGFloat headerY = CGRectGetHeight(frame) * .04;
        CGRect timerDisplay = CGRectMake(timerX, headerY, 100, 50);
        _currentTime = [[UILabel alloc] initWithFrame:timerDisplay];
        _currentTime.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
        _currentTime.textColor = [UIColor whiteColor];
        [self changeTimerText];
        
        // Set up UI for Score label
        CGFloat scoreX = CGRectGetWidth(frame) * .05;
        CGFloat scoreY = CGRectGetHeight(frame) * .04;
        CGRect scoreDisplay = CGRectMake(scoreX, scoreY, 300, 50);
        _currentScore = [[UILabel alloc] initWithFrame:scoreDisplay];
        _currentScore.text = [NSString stringWithFormat:@"Score: %.3f", currentScore];
        _currentScore.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:50];
        _currentScore.textColor = [UIColor whiteColor];
        
        // Add label view
        [self addSubview:_currentTime];
        [self addSubview:_currentScore];
        
        // Initialize timer
        [self initializeTimer];
        
    }
    return self;
}

// Used to change the text of the timer to a MM:SS format
- (void)changeTimerText
{
    int minutes = _initialTime / 60;
    int seconds = _initialTime % 60;
    
    _currentTime.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

// Creates an NSTimer
- (void)initializeTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}

// Decrements the timer and calls on delegate function when timer reaches 0
- (void)countDownTimer
{
    if (_initialTime == 0) {
        [_gameTimer invalidate];
        [self.customDelegate showGameResults:self];
    } else {
        --_initialTime;
        [self changeTimerText];
    }
}

// Updates the visual when the score is changed
- (void)updateScore: (double)newScore
{
    _currentScore.text = [NSString stringWithFormat:@"Score: %.3f", newScore];
}

@end
