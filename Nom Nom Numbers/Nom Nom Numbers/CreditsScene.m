//
//  CreditsScene.m
//  Nom Nom Numbers
//
//  Created by jarthurcs on 12/8/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "CreditsScene.h"
#import "StartScene.h"

@implementation CreditsScene
{
    SKView* _skView;
    NSMutableArray* _arrOfSounds;
    double _nextLineY;
}

- (id) initWithSize:(CGSize)size andSKView:(SKView *)skView
{
    _arrOfSounds = [NSMutableArray new];
    self = [super initWithSize:size];
    _skView = [[SKView alloc] init];
    _skView = skView;
    _nextLineY = self.size.height * 0.7;
    [self setup];
    
    return self;
}

- (void) setup
{
    [self createBackground];
    
    [self createQuitButton];
    
    [self writeLine:@"This app was developed and designed by"];
    [self writeLine:@"Danielle Demas, Yaxi Gao, Hugo Ho, Hana Kim, and Shannon Lin"];
    [self writeLine:@"as part of the CS 121 class at Harvey Mudd College."];
    [self writeLine:@"It was developed as part of the Games Network,"];
    [self writeLine:@"which is funded by NSF grant #1042472."];
    [self writeLine:@""];
    [self writeLine:@"The Large Fireball sound was recorded by Mike Koenig"];
    [self writeLine:@"and is used under Creative Commons Attribution 3.0."];
    [self writeLine:@"It can be found at http://soundbible.com/1348-Large-Fireball.html."];
    [self writeLine:@""];
    [self writeLine:@"Thank you for trying our game and we hope you have fun!"];
}

- (void) createBackground
{
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"mathGameBG"];
    background.position = CGPointZero;
    background.anchorPoint = CGPointZero;
    background.xScale = .5;
    background.yScale = .5;
    [self addChild:background];
}

- (void) createQuitButton
{
    SKSpriteNode* quitButton = [[SKSpriteNode alloc] initWithImageNamed:@"redButton"];
    quitButton.size = CGSizeMake(120, 60);
    quitButton.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.1);
    quitButton.name = @"quitbutton";
    quitButton.zPosition = 2;
    [self addChild:quitButton];
    
    SKLabelNode* quitButtonLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    quitButtonLabel.fontSize = 30;
    quitButtonLabel.fontColor = [UIColor whiteColor];
    quitButtonLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    quitButtonLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    quitButtonLabel.text = @"Go back";
    quitButtonLabel.name = @"quitbutton";
    [quitButton addChild:quitButtonLabel];
}

- (void) writeLine: (NSString*) text
{
    SKLabelNode* textLabel = [[SKLabelNode alloc] initWithFontNamed:@"MarkerFelt-Thin"];
    textLabel.fontSize = 32;
    textLabel.fontColor = [UIColor blackColor];
    textLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    textLabel.position = CGPointMake(self.size.width / 2, _nextLineY);
    textLabel.text = text;
    [self addChild:textLabel];
    
    _nextLineY -= textLabel.fontSize + 5;
}

- (IBAction) playButtonNoise:(id)sender
{
    NSString* fileName = @"Click";
    
    NSString* soundFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType: @"wav"];
    NSURL* fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error: nil];
    [_arrOfSounds removeAllObjects];
    [_arrOfSounds addObject:newPlayer];
    [newPlayer prepareToPlay];
    [newPlayer play];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode* node = [self nodeAtPoint:location];
    
    if ([node.name isEqual: @"quitbutton"]) {
        [self playButtonNoise:self];
        SKScene* startScene = [[StartScene alloc] initWithSize:self.size andSKView:[[SKView alloc] init]];
        SKTransition* transition = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:startScene transition:transition];
    }
}

@end
