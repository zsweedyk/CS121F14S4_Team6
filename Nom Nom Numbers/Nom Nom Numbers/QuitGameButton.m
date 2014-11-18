//
//  QuitGameButton.m
//  Nom Nom Numbers
//
//  Created by Shannon on 10/30/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "QuitGameButton.h"

@implementation QuitGameButton

- (id) setupData:(SKScene*)mainScene withScore:(double)currentScore
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
    SKSpriteNode* quitPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    quitPopup.size = CGSizeMake(sceneX * 0.35, sceneY * 0.3);
    quitPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    
    SKSpriteNode* shadow = [[SKSpriteNode alloc] initWithImageNamed:@"popupShadow"];
    shadow.size = CGSizeMake(quitPopup.size.width * 1.1, quitPopup.size.height * 1.1);
    shadow.position = CGPointMake(quitPopup.position.x, quitPopup.position.y - 5);
    shadow.alpha = 0.5;
    
    quitPopup.zPosition = 2;
    
    [self addChild:shadow];
    [self addChild:quitPopup];
    
    
    CGFloat popupX = quitPopup.size.width;
    CGFloat popupY = quitPopup.size.height;
    
    // Create title label on the popup
    SKLabelNode* quitPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupTitle.fontColor = [UIColor whiteColor];
    quitPopupTitle.fontSize = 35;
    quitPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupTitle.position = CGPointMake(0, popupY * 0.35);
    quitPopupTitle.text = @"You quit the game!";
    [quitPopup addChild:quitPopupTitle];
    
    // Create content text on the popup
    SKLabelNode* quitPopupText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupText.fontColor = [UIColor whiteColor];
    quitPopupText.fontSize = 28;
    quitPopupText.position = CGPointMake(0, popupY * 0.15);
    quitPopupText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupText.text = [NSString stringWithFormat:@"Your score was"];
    [quitPopup addChild:quitPopupText];
    
    // Create score text on the popup
    SKLabelNode* quitPopupScore = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupScore.fontColor = [UIColor whiteColor];
    quitPopupScore.fontSize = 33;
    quitPopupScore.position = CGPointMake(0, popupY * -0.05);
    quitPopupScore.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupScore.text = [NSString stringWithFormat:@"%.2f", currentScore];
    [quitPopup addChild:quitPopupScore];
    
    // Create confirmation button (return to main screen) on popup
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"greenButton"];
    quitButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    quitButton.position = CGPointMake(0, popupY * -0.35);
    quitButton.name = @"quitaction";
    [quitPopup addChild:quitButton];
    
    // Create the label on the confirmation button
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButtonLabel.fontColor = [UIColor whiteColor];
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitButtonLabel.text = @"OK";
    quitButtonLabel.name = @"quitaction";
    [quitButton addChild:quitButtonLabel];
    
    return self;
}

@end
