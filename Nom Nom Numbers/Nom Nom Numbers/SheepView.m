//
//  SheepView.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "SheepView.h"

@implementation SheepView

- (SKSpriteNode*)makeASheep {
    
    SKSpriteNode *sheep = [SKSpriteNode spriteNodeWithImageNamed:@"Sheep"];
    sheep.position = CGPointMake(740, 170);
    sheep.anchorPoint = CGPointZero;
    sheep.xScale = .5;
    sheep.yScale = .5;
    
    //SK actions to move sheep left
    SKAction *moveSheepLeft = [SKAction moveBy:CGVectorMake(-1000, 0) duration:10.0];
    //SKAction *moveSheepLeft = [SKAction moveTo:CGPointMake(-200, 170) duration:10.0];
    SKAction *repeatMoveLeft = [SKAction repeatActionForever:moveSheepLeft];

    //SK actions to wobble sheep
    SKAction* wobbleForward = [SKAction rotateToAngle:M_PI/16.0 duration:.5];
    SKAction* wobbleBackward = [SKAction rotateToAngle:-M_PI/16.0 duration:.5];
    SKAction* sequence = [SKAction sequence:@[wobbleForward,wobbleBackward]];
    SKAction *repeatWobble = [SKAction repeatActionForever:sequence];
    
    [sheep runAction:repeatWobble];
    [sheep runAction:repeatMoveLeft];
    
    
    return sheep;
}



- (void)sheepTapped {
    NSLog(@"Sheep tapped");
}


@end
