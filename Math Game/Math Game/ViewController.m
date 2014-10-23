//
//  ViewController.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "ViewController.h"
#import "DragonView.h"

@interface ViewController ()
{
    DragonView *dragonView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect dragonFrame = [self makeDragonFrame];
    dragonView = [[DragonView alloc] initWithFrame:dragonFrame];
    
    [self.view addSubview:dragonView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)makeDragonFrame {
    CGRect screen = self.view.frame;
    
    CGFloat screenWidth = screen.size.width;
    CGFloat screenHeight = screen.size.width;
    
    CGSize dragonSize = [UIImage imageNamed:@"dragon"].size;
    CGSize backgroundSize = [UIImage imageNamed:@"mathGameBG"].size;
    CGFloat dragonBGWidthRatio = dragonSize.width/backgroundSize.width;
    CGFloat dragonBGHeightRatio = dragonSize.height/backgroundSize.height;
    
    CGFloat dragonWidth = dragonBGWidthRatio * screenWidth;
    CGFloat dragonHeight = dragonBGHeightRatio * screenHeight;
    
    CGFloat x = screenWidth - dragonWidth + 10;
    CGFloat y = screenHeight/2.0 - 330;
    
    return CGRectMake(x, y, dragonWidth, dragonHeight);
}

@end
