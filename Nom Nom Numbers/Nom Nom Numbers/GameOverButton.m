//
//  GameOverButton.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/30/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "GameOverButton.h"

@implementation GameOverButton

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore
{
    CGFloat sceneX = mainScene.size.width;
    CGFloat sceneY = mainScene.size.height;
    
    // Create popup
    SKSpriteNode* gameOverPopup = [[SKSpriteNode alloc] initWithImageNamed:@"wooden"];
    gameOverPopup.size = CGSizeMake(sceneX * 0.35, sceneY * 0.3);
    gameOverPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    [self addChild:gameOverPopup];
    
    
    CGFloat popupX = gameOverPopup.size.width;
    CGFloat popupY = gameOverPopup.size.height;
    
    // Create title label on the popup
    SKLabelNode* gameOverPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupTitle.fontColor = [UIColor whiteColor];
    gameOverPopupTitle.fontSize = 35;
    gameOverPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupTitle.position = CGPointMake(0, popupY * 0.3);
    gameOverPopupTitle.text = @"Game Over!";
    [gameOverPopup addChild:gameOverPopupTitle];
    
    // Create score content text on the popup
    SKLabelNode* gameOverPopupScore = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupScore.fontColor = [UIColor whiteColor];
    gameOverPopupScore.fontSize = 30;
    gameOverPopupScore.position = CGPointMake(0, popupY * 0.1);
    gameOverPopupScore.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupScore.text = [NSString stringWithFormat:@"Your score was %.3f.", currentScore];
    [gameOverPopup addChild:gameOverPopupScore];
    
    // Create question content text on the popup
    SKLabelNode* gameOverPopupQuestion = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupQuestion.fontColor = [UIColor whiteColor];
    gameOverPopupQuestion.fontSize = 30;
    gameOverPopupQuestion.position = CGPointMake(0, popupY * -0.06);
    gameOverPopupQuestion.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupQuestion.text = [NSString stringWithFormat:@"Play again?"];
    [gameOverPopup addChild:gameOverPopupQuestion];

    // Create restart button (play again) on popup
    SKSpriteNode* restartButton = [[SKSpriteNode alloc] initWithImageNamed:@"wooden"];
    restartButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    restartButton.position = CGPointMake(popupX * -0.3, popupY * -0.3);
    [gameOverPopup addChild:restartButton];
    
    // Create the label on the confirmation button
    SKLabelNode* restartButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    restartButtonLabel.fontColor = [UIColor whiteColor];
    restartButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    restartButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    restartButtonLabel.text = @"Yes";
    restartButtonLabel.name = @"playagainaction";
    [restartButton addChild:restartButtonLabel];
    
    // Create quit button (return to main screen) on popup
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"wooden"];
    quitButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    quitButton.position = CGPointMake(popupX * 0.3, popupY * -0.3);
    [gameOverPopup addChild:quitButton];
    
    // Create the label on the confirmation button
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButtonLabel.fontColor = [UIColor whiteColor];
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitButtonLabel.text = @"No";
    quitButtonLabel.name = @"quitaction";
    [quitButton addChild:quitButtonLabel];
    
    return self;
}

@end
