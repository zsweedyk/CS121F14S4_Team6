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

// Generate individual sheep and set SKActions to move sheep across screen
- (SKSpriteNode *) createSheepWithValue:(NSString *)value andOper:(char)oper atPos:(CGPoint)pos
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
    SKAction* moveSheepUp = [SKAction moveBy:CGVectorMake(0, 1000) duration:acrossScreenTime];
    SKAction* repeatMoveUp = [SKAction repeatActionForever:moveSheepUp];
    
    double wobbleTime = acrossScreenTime / 40.0;
    
    // SK actions to wobble sheep
    SKAction* wobbleForward = [SKAction rotateToAngle:M_PI/60.0 duration:wobbleTime];
    SKAction* wobbleBackward = [SKAction rotateToAngle:-M_PI/60.0 duration:wobbleTime];
    SKAction* sequence = [SKAction sequence:@[wobbleForward,wobbleBackward]];
    SKAction* repeatWobble = [SKAction repeatActionForever:sequence];
    
    [_sheepNode runAction:repeatWobble];
    [_sheepNode runAction:repeatMoveUp];
    
    return [self displayASheepWithValue:value andOper:oper atPos:pos];
}

// Calls auxillary functions to place image onto sheep node
- (SKSpriteNode *) displayASheepWithValue:(NSString *)value andOper:(char)oper atPos:(CGPoint)pos
{
    _value = value;
    _oper = oper;
    
    [self makeSheepImage];
    [_sheepNode setTexture:[SKTexture textureWithImage:_sheepImage]];

    return _sheepNode;
}

// Creates UIImage given operators or values and places it on top of sheep in appropriate location
- (void) getImageForText:(NSString *)text for:(char)input
{
    NSAssert(input == 'O' || input == 'V', @"Invalid: input was neither 'V' for value nor 'O' for operator");
    
    UIGraphicsBeginImageContext(_sheepImage.size);
    [_sheepImage drawInRect:CGRectMake(0,0,_sheepImage.size.width,_sheepImage.size.height)];
    
    UITextView* myText = [[UITextView alloc] init];
    myText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:40];
    myText.textColor = [UIColor blackColor];
    myText.text = text;
    myText.backgroundColor = [UIColor clearColor];
    
    CGPoint point;
    if (input == 'O') { // put operator in correct location on sheep
        if (_oper == 'A') {
            // fit the words "Absolute Value" on the body of the sheep
            point = CGPointMake(_sheepImage.size.width/3.5, _sheepImage.size.height/2);
            myText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:35];
        }
        else {
            myText.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:50];
            point = CGPointMake(_sheepImage.size.width/2.25, _sheepImage.size.height/5.25);
        }
    } else { // put value in correct location on sheep
        point = CGPointMake(_sheepImage.size.width/3.5, _sheepImage.size.height/2);
    }
    
    myText.frame = CGRectMake(point.x, point.y, _sheepImage.size.width, _sheepImage.size.height);
    [[UIColor clearColor] set];
    NSDictionary* att = @{NSFontAttributeName:myText.font};
    [myText.text drawInRect:myText.frame withAttributes:att];
    
    _sheepImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

// Calls getImageForText with appropriate operator and values
- (void) makeSheepImage
{
    //_sheepImage = [[UIImage alloc] init];
    
    NSString* stringOperator = [NSString stringWithFormat:@"%c" , _oper];
    
    if ([_value doubleValue] > 75) {
        _sheepImage = [UIImage imageWithCGImage:[[UIImage imageNamed:@"SheepGold"] CGImage]
                                          scale:1.0
                                    orientation:UIImageOrientationRight];
    } else if (_oper == 'A') {
        stringOperator = @"Absolute\nValue";
        _sheepImage = [UIImage imageWithCGImage:[[UIImage imageNamed:@"SheepRainbow"] CGImage]
                                            scale:1.0
                                            orientation:UIImageOrientationRight];
        
    } else if (_oper == '/' || _oper == 'x') {
        _sheepImage = [UIImage imageWithCGImage:[[UIImage imageNamed:@"SheepRam"] CGImage]
                                            scale:1.0
                                            orientation:UIImageOrientationRight];
        
    } else {
        _sheepImage = [UIImage imageWithCGImage:[[UIImage imageNamed:@"Sheep"] CGImage]
                                            scale:1.0
                                            orientation:UIImageOrientationRight];
    }
    

    
    [self getImageForText:stringOperator for:'O'];
    [self getImageForText:_value for:'V'];
}

@end
