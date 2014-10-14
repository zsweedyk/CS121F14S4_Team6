//
//  DataView.m
//  TestTimer
//
//  Created by Shannon on 10/12/14.
//  Copyright (c) 2014 Shannon Lin. All rights reserved.
//

#import "DataView.h"

@implementation DataView

- (id)initWithFrame:(CGRect)frame andScore:(int)currentScore
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Set up initial conditions for timer
        _initialTime = 60;
        
        // Set up UI for Timer label
        CGFloat timerX = CGRectGetWidth(frame) * .05;
        CGFloat headerY = CGRectGetHeight(frame) * .05;
        CGRect timerDisplay = CGRectMake(timerX, headerY, 100, 50);
        _currentTime = [[UILabel alloc] initWithFrame:timerDisplay];
        [self changeTimerText];
        
        // Set up UI for Score label
        CGFloat scoreX = CGRectGetWidth(frame) * .75;
        CGRect scoreDisplay = CGRectMake(scoreX, headerY, 100, 50);
        _currentScore = [[UILabel alloc] initWithFrame:scoreDisplay];
        _currentScore.text = [NSString stringWithFormat:@"Score: %d", currentScore];
        _currentScore.textColor = [UIColor blackColor];
        
        // Add label view
        [self addSubview:_currentTime];
        [self addSubview:_currentScore];
        
        // Initialize timer
        [self initializeTimer];
        
    }
    return self;
}

- (void)changeTimerText
{
    int minutes = _initialTime / 60;
    int seconds = _initialTime % 60;
    
    _currentTime.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

- (void)initializeTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}

- (void)countDownTimer
{
//    NSLog(@"Time is currently %d seconds", _initialTime);
    if (_initialTime == 0) {
        [_gameTimer invalidate];
        NSLog(@"Game over!");
    } else {
        --_initialTime;
        [self changeTimerText];
    }
}

- (void)updateScore: (int)newScore
{
    _currentScore.text = [NSString stringWithFormat:@"Score: %d", newScore];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
