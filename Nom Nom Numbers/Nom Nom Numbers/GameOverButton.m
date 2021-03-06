//
//  GameOverButton.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/30/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "GameOverButton.h"

@implementation GameOverButton

- (id) setupData:(SKScene *)mainScene withScore:(double)currentScore
{
    CGFloat sceneX = mainScene.size.width;
    CGFloat sceneY = mainScene.size.height;
    
    // Create popup backlay
    UIColor* transparentColor = [[UIColor alloc] initWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    SKSpriteNode* gameOverBacklay = [[SKSpriteNode alloc] initWithColor:transparentColor size:CGSizeMake(sceneX, sceneY)];
    gameOverBacklay.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    gameOverBacklay.zPosition = 2;
    [self addChild:gameOverBacklay];
    
    // Create popup
    SKSpriteNode* gameOverPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    gameOverPopup.size = CGSizeMake(sceneX * 0.35, sceneY * 0.3);
    gameOverPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    
    SKSpriteNode* shadow = [[SKSpriteNode alloc] initWithImageNamed:@"popupShadow"];
    shadow.size = CGSizeMake(gameOverPopup.size.width * 1.1, gameOverPopup.size.height * 1.1);
    shadow.position = CGPointMake(gameOverPopup.position.x, gameOverPopup.position.y - 5);
    shadow.alpha = 0.5;
    
    [self addChild:shadow];
    gameOverPopup.zPosition = 2;
    [self addChild:gameOverPopup];
    
    
    CGFloat popupX = gameOverPopup.size.width;
    CGFloat popupY = gameOverPopup.size.height;
    
    // Create title label on the popup
    SKLabelNode* gameOverPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupTitle.fontColor = [UIColor whiteColor];
    gameOverPopupTitle.fontSize = 35;
    gameOverPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupTitle.position = CGPointMake(0, popupY * 0.35);
    if (currentScore < 0)
        gameOverPopupTitle.text = @"Try again...";
    else if (currentScore > 2500)
        gameOverPopupTitle.text = @"AMAZING!!";
    else if (currentScore > 1000)
        gameOverPopupTitle.text = @"Fantastic!!";
    else if (currentScore > 600)
        gameOverPopupTitle.text = @"Great!";
    else if (currentScore > 200)
        gameOverPopupTitle.text = @"Good job!";
    else if (currentScore > 50)
        gameOverPopupTitle.text = @"Wow!";
    else
        gameOverPopupTitle.text = @"Nice!";
    [gameOverPopup addChild:gameOverPopupTitle];
    
    // Create score content text on the popup
    SKLabelNode* gameOverPopupScore = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupScore.fontColor = [UIColor whiteColor];
    gameOverPopupScore.fontSize = 28;
    gameOverPopupScore.position = CGPointMake(0, popupY * 0.17);
    gameOverPopupScore.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupScore.text = [NSString stringWithFormat:@"Your score was"];
    [gameOverPopup addChild:gameOverPopupScore];
    
    // Create score text on the popup
    SKLabelNode* gameOverScore = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverScore.fontColor = [UIColor whiteColor];
    gameOverScore.fontSize = 33;
    gameOverScore.position = CGPointMake(0, popupY * 0.02);
    gameOverScore.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverScore.text = [NSString stringWithFormat:@"%.2f", currentScore];
    [gameOverPopup addChild:gameOverScore];
    
    // Create question content text on the popup
    SKLabelNode* gameOverPopupQuestion = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    gameOverPopupQuestion.fontColor = [UIColor whiteColor];
    gameOverPopupQuestion.fontSize = 28;
    gameOverPopupQuestion.position = CGPointMake(0, popupY * -0.13);
    gameOverPopupQuestion.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    gameOverPopupQuestion.text = [NSString stringWithFormat:@"Play again?"];
    [gameOverPopup addChild:gameOverPopupQuestion];

    // Create restart button (play again) on popup
    SKSpriteNode* restartButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
    restartButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    restartButton.position = CGPointMake(popupX * -0.3, popupY * -0.35);
    restartButton.name = @"playagainaction";
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
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"redButton"];
    quitButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    quitButton.position = CGPointMake(popupX * 0.3, popupY * -0.35);
    quitButton.name = @"quitaction";
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
