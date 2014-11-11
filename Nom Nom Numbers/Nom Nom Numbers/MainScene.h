//
//  BackgroundScene.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SheepSprite.h"
#import "SheepController.h"
#import "DataView.h"
#import "DataModel.h"
#import "QuitGameButton.h"
#import "GameOverButton.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MainScene : SKScene <gameOverDelegate>

- (id) initWithSize:(CGSize)size andSKView:(SKView*)skView;

@end
