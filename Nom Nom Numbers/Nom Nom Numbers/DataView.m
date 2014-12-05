//
//  DataView.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "DataView.h"
#import "DataModel.h"
#import "SheepController.h"

@implementation DataView

#define timeModeStartTime 60

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore andMode:(NSString*)mode andModel:(DataModel*)model andSheepController:(SheepController *)sheepController
{
    _sheepController = sheepController;
    _dataModel = model;
    _mode = mode;
    CGFloat Xdimensions = mainScene.size.width;
    CGFloat Ydimensions = mainScene.size.height * 0.05;
    CGFloat headerY = Ydimensions * .93;
    
    CGFloat scoreX;
    CGFloat timerX;
    CGFloat targetScoreX;
    NSString* fontType = @"MarkerFelt-Thin";
    
    // If we are in timed mode, set up and display timer
    if ([mode isEqualToString:@"timed"]) {
        scoreX = Xdimensions * .2;
        timerX = Xdimensions * .07;
        CGFloat timerY = Ydimensions * 18.5;
        
        _initialTime = timeModeStartTime;
        
        // Set up UI for Timer Label
        _currentTime = [[SKLabelNode alloc] initWithFontNamed:fontType];
        _currentTime.fontSize = 60;
        _currentTime.fontColor = [UIColor whiteColor];
        _currentTime.position = CGPointMake(timerX, timerY);
        _currentTime.zPosition = 2;
        [self changeTimerText];
        [self addChild:_currentTime];
        
    
    // If we are in target mode, set up and display target score
    } else {
        scoreX = Xdimensions * .2;
        targetScoreX = Xdimensions * .75;
        
        // Set up Target Score Label
        _targetScore = [[SKLabelNode alloc] initWithFontNamed:fontType];
        _targetScore.fontSize = 45;
        _targetScore.fontColor = [UIColor blackColor];
        _targetScore.position = CGPointMake(targetScoreX, headerY);
        _targetScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        _targetScore.zPosition = 2;
        
        int targetScore = [_sheepController getTargetScore];
        [_dataModel setTargetScore:targetScore];
        _targetScore.text = [NSString stringWithFormat:@"Target: %d",targetScore];
        [self addChild:_targetScore];
        
        _initialTime = 0;
        
        // Set up 'Hit Me!' Label
        SKSpriteNode* targetButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
        targetButton.size = CGSizeMake(120, 60);
        targetButton.position = CGPointMake(Xdimensions*.1, Ydimensions);
        targetButton.name = @"targetbutton";
        targetButton.zPosition = 2;
        [self addChild:targetButton];
        
        SKLabelNode* targetButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
        targetButtonLabel.fontColor = [UIColor whiteColor];
        targetButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        targetButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        targetButtonLabel.text = @"Hit Me!";
        targetButtonLabel.name = @"targetbutton";
        [targetButton addChild:targetButtonLabel];
    }

    // Set up UI for Score Label
    _currentScore = [[SKLabelNode alloc] initWithFontNamed:fontType];
    _currentScore.fontSize = 45;
    _currentScore.fontColor = [UIColor blackColor];
    _currentScore.position = CGPointMake(scoreX, headerY);
    _currentScore.zPosition = 2;
    _currentScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    _currentScore.text = [NSString stringWithFormat:@"Score: %.2f", currentScore];
 
    // Add Label view
    [self addChild:_currentScore];
    return self;
}


// Used to change the text of the timer to a MM:SS format
- (void) changeTimerText
{
    int minutes = _initialTime / 60;
    int seconds = _initialTime % 60;
    
    _currentTime.text = [NSString stringWithFormat:@"%d:%02d", minutes, seconds];
}

// Creates an NSTimer
- (void) initializeTimer
{
    if ([_mode isEqualToString:@"timed"]) {
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
    } else {
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countUpTimer) userInfo:nil repeats:YES];
    }
    
}

// Decrements the timer and calls on delegate function when timer reaches 0
- (void) countDownTimer
{
    if (_initialTime == 0) {
        [_gameTimer invalidate];
        _initialTime = 0;
        [self.customDelegate showGameResults:self];
        
    } else {
        if (_initialTime < 12) {
            _currentTime.fontColor = [UIColor redColor];
        }
        --_initialTime;
        [self changeTimerText];
    }
}

// Increments timer - used for target mode
- (void) countUpTimer
{
    ++_initialTime;
}

// Updates the visual when the score is changed
- (void) updateScore: (double)newScore
{
    _currentScore.text = [NSString stringWithFormat:@"Score: %.2f", newScore];
}

// Stop the timer
- (void) stopTimer
{
    [_gameTimer invalidate];
}

// Return current time as name suggests
- (int) getCurrentTime
{
    return _initialTime;
}

// When game is restarted, timed mode must start decrementing from the set macro
// while target mode must start incrementing from 0
- (void) resetTimer
{
    [self initializeTimer];
    
    if ([_mode isEqualToString:@"timed"]) {
        _initialTime = timeModeStartTime;
        _currentTime.fontColor = [UIColor whiteColor];
        [self changeTimerText];
    } else {
        _initialTime = 0;
        int targetScore = [_sheepController getTargetScore];
        [_dataModel setTargetScore:targetScore];
        
        _targetScore.text = [NSString stringWithFormat:@"Target: %d",targetScore];
    }
}

@end
