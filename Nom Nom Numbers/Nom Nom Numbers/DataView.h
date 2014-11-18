//
//  DataView.h
//  Nom Nom Numbers
//
//  Created by Shannon on 10/25/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "DataModel.h"
#import "SheepController.h"

@class DataView;
@protocol gameOverDelegate

- (void)showGameResults:(DataView *)controller;

@end

@interface DataView : SKLabelNode
{
    int _initialTime;
    SKLabelNode* _currentTime;
    SKLabelNode* _currentScore;
    SKLabelNode* _targetScore;
    NSTimer* _gameTimer;
    DataModel* _dataModel;
    NSString* _mode;
    SheepController* _sheepController;
}

@property(nonatomic, weak) id<gameOverDelegate> customDelegate;

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore andMode:(NSString*)mode andModel:(DataModel*)model andSheepController:(SheepController *)sheepController;
- (void) updateScore: (double)newScore;
- (void) stopTimer;
- (void) resetTimer;
- (int) getCurrentTime;

@end
