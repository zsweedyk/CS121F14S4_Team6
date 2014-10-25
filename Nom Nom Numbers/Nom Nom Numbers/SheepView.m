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
    
    SKAction *moveSheepLeft = [SKAction moveBy:CGVectorMake(-1000, 0) duration:10.0];
    //SKAction *moveSheepLeft = [SKAction moveTo:CGPointMake(-200, 170) duration:10.0];
    [sheep runAction:moveSheepLeft];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sheepTapped)];
    //[sheep ]
    
    return sheep;
}

- (UIGestureRecognizer*)getGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sheepTapped)];
    return tap;
}


- (void)sheepTapped {
    NSLog(@"Sheep tapped");
}


@end
