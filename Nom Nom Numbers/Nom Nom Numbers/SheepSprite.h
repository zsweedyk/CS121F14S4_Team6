//
//  SheepSprite.h
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
//#import "SheepModel.h"

@interface SheepSprite : SKLabelNode

- (SKSpriteNode *) createSheepWithValue:(NSString *)value andOper:(char)oper atPos:(CGPoint)pos;
- (SKSpriteNode *) displayASheepWithValue:(NSString *)value andOper:(char)oper atPos:(CGPoint)pos;

@end
