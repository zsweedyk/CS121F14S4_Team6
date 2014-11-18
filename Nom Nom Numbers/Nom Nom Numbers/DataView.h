//
//  DataView.h
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class DataView;
@protocol gameOverDelegate

- (void)showGameResults:(DataView *)controller;

@end

@interface DataView : SKLabelNode
{
    int _initialTime;
    SKLabelNode* _currentTime;
    SKLabelNode* _currentScore;
    NSTimer* _gameTimer;
}

@property(nonatomic, weak) id<gameOverDelegate> customDelegate;

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore;
- (void) updateScore: (double)newScore;
- (void) initializeTimer;
- (void) stopTimer;
- (void) resetTimer;

@end
