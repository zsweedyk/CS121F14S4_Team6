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
    
    // Create popup
    SKSpriteNode* quitPopup = [[SKSpriteNode alloc] initWithImageNamed:@"popup"];
    quitPopup.size = CGSizeMake(sceneX * 0.35, sceneY * 0.3);
    quitPopup.position = CGPointMake(sceneX * 0.5, sceneY * 0.5);
    [self addChild:quitPopup];
    
    // Create title label on the popup
    CGFloat popupX = quitPopup.size.width;
    CGFloat popupY = quitPopup.size.height;
    SKLabelNode* quitPopupTitle = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupTitle.fontColor = [UIColor whiteColor];
    quitPopupTitle.fontSize = 35;
    quitPopupTitle.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupTitle.position = CGPointMake(0, popupY * 0.3);
    quitPopupTitle.text = @"You quit the game!";
    [quitPopup addChild:quitPopupTitle];
    
    // Create content text on the popup
    SKLabelNode* quitPopupText = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitPopupText.fontColor = [UIColor whiteColor];
    quitPopupText.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitPopupText.text = [NSString stringWithFormat:@"Your score was %.3f", currentScore];
    [quitPopup addChild:quitPopupText];
    
    // Create confirmation button (return to main screen) on popup
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"wooden"];
    quitButton.size = CGSizeMake(popupX * 0.3, popupY * 0.2);
    quitButton.position = CGPointMake(0, popupY * -0.3);
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
