//
//  DataView.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataView.h"

@implementation DataView

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore
{
    CGFloat Xdimensions = mainScene.size.width;
    CGFloat Ydimensions = mainScene.size.height;
    
    _initialTime = 60;
    CGFloat headerY = Ydimensions * .93;
    NSString* fontType = @"MarkerFelt-Thin";
    
    // Set up UI for Score Label
    CGFloat scoreX = Xdimensions * .02;
    _currentScore = [[SKLabelNode alloc] initWithFontNamed:fontType];
    _currentScore.fontSize = 45;
    _currentScore.fontColor = [UIColor whiteColor];
    _currentScore.position = CGPointMake(scoreX, headerY);
    _currentScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _currentScore.text = [NSString stringWithFormat:@"Score: %.3f", currentScore];
    
    // Set up UI for Timer Label
    CGFloat timerX = Xdimensions * .5;
    _currentTime = [[SKLabelNode alloc] initWithFontNamed:fontType];
    _currentTime.fontSize = 45;
    _currentTime.fontColor = [UIColor whiteColor];
    _currentTime.position = CGPointMake(timerX, headerY);
    [self changeTimerText];
 
    // Add Label view
    [self addChild:_currentTime];
    [self addChild:_currentScore];
    
    // Initialize timer
    [self initializeTimer];
    return self;
}

// Used to change the text of the timer to a MM:SS format
- (void) changeTimerText
{
    int minutes = _initialTime / 60;
    int seconds = _initialTime % 60;
    
    _currentTime.text = [NSString stringWithFormat:@"%d:%03d", minutes, seconds];
}

// Creates an NSTimer
- (void) initializeTimer
{
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}

// Decrements the timer and calls on delegate function when timer reaches 0
- (void) countDownTimer
{
    if (_initialTime == 0) {
        [_gameTimer invalidate];
        [self.customDelegate showGameResults:self];
        
    } else {
        
        if (_initialTime < 12) {
            _currentTime.fontColor = [UIColor redColor];
        }
        --_initialTime;
        [self changeTimerText];
    }
    
}

// Updates the visual when the score is changed
- (void) updateScore: (double)newScore
{
    _currentScore.text = [NSString stringWithFormat:@"Score: %.3f", newScore];
}

// Stop the timer
- (void) stopTimer
{
    [_gameTimer invalidate];
}

@end
