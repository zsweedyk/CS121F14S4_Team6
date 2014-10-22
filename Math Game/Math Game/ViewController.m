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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)makeDragonFrame {
    return CGRectMake(50, 50, 200, 600);
}

@end
