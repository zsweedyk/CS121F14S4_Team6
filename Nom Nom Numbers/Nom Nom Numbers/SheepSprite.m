//
//  SheepSprite.m
//  Nom Nom Numbers
//
//  Created by Hugo Ho on 10/24/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//


#import "SheepSprite.h"

@implementation SheepSprite
{
    UIImage* _sheepImage;
    SKSpriteNode* _sheepNode;
    NSString* _value;
    char _oper;
}

- (SKSpriteNode*) createSheepWithValue:(NSString*)value andOper:(char)oper atPos:(CGPoint)pos
{
    
    _value = value;
    _oper = oper;
    
    [self makeSheepImage];
    
    _sheepNode = [[SKSpriteNode alloc] init];
    _sheepNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:_sheepImage]];
    _sheepNode.name = @"sheep";
    
    _sheepNode.position = pos;
    _sheepNode.anchorPoint = CGPointZero;
    _sheepNode.xScale = .5;
    _sheepNode.yScale = .5;
    
    double acrossScreenTime = (arc4random() % (120)) + 60;
    acrossScreenTime /= 10.0;
    
    // SK actions to move sheep left
    SKAction *moveSheepLeft = [SKAction moveBy:CGVectorMake(-1000, 0) duration:acrossScreenTime];
    SKAction *repeatMoveLeft = [SKAction repeatActionForever:moveSheepLeft];
    
    double wobbleTime = acrossScreenTime / 40.0;
    
    // SK actions to wobble sheep
    SKAction* wobbleForward = [SKAction rotateToAngle:M_PI/60.0 duration:wobbleTime];
    SKAction* wobbleBackward = [SKAction rotateToAngle:-M_PI/60.0 duration:wobbleTime];
    SKAction* sequence = [SKAction sequence:@[wobbleForward,wobbleBackward]];
    SKAction *repeatWobble = [SKAction repeatActionForever:sequence];
    
    [_sheepNode runAction:repeatWobble];
    [_sheepNode runAction:repeatMoveLeft];
    
    return [self displayASheepWithValue:value andOper:oper atPos:pos];
}

- (SKSpriteNode*) displayASheepWithValue:(NSString*)value andOper:(char)oper atPos:(CGPoint)pos
{
    
    _value = value;
    _oper = oper;
    
    [self makeSheepImage];
    [_sheepNode setTexture:[SKTexture textureWithImage:_sheepImage]];

    return _sheepNode;
}

- (void) getImageForText:(NSString *)text for:(char)input
{
    UIGraphicsBeginImageContext(_sheepImage.size);
    [_sheepImage drawInRect:CGRectMake(0,0,_sheepImage.size.width,_sheepImage.size.height)];
    UITextView *myText = [[UITextView alloc] init];
    
    myText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:40];
    myText.textColor = [UIColor blackColor];
    myText.text = text;
    myText.backgroundColor = [UIColor clearColor];
    
    CGPoint point;
    if (input == 'O') {
        point = CGPointMake(_sheepImage.size.width/4, _sheepImage.size.height/3.25);
    } else {
        point = CGPointMake(_sheepImage.size.width/2.15, _sheepImage.size.height/3.5);
    }
    
    myText.frame = CGRectMake(point.x, point.y, _sheepImage.size.width, _sheepImage.size.height);
    [[UIColor clearColor] set];
    NSDictionary *att = @{NSFontAttributeName:myText.font};
    [myText.text drawInRect:myText.frame withAttributes:att];
    
    _sheepImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}



- (void)makeSheepImage
{
    _sheepImage = [[UIImage alloc] init];
    _sheepImage = [UIImage imageNamed:@"Sheep"];
    
    NSString* stringOperator = [NSString stringWithFormat:@"%c" , _oper];
    
    [self getImageForText:stringOperator for:'O'];
    [self getImageForText:_value for:'V'];

    
}



@end
