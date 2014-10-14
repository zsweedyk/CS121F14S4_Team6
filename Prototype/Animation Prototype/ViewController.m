//
//  ViewController.m
//  Animation Prototype
//
//  Created by Hugo Ho on 10/12/14.
//  Copyright (c) 2014 Hugo Ho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = self.view.frame;
    CGFloat gridX = CGRectGetWidth(frame)*.45;
    CGFloat gridY = CGRectGetHeight(frame)*.5;
    CGFloat gridSize = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.10;
    CGRect buttonFrame = CGRectMake(gridX, gridY, gridSize, gridSize);
    
    UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:@"Animate!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(animateObject) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    }
- (void)animateObject {
    NSMutableArray *animationArray = [[NSMutableArray alloc] init];
    
    for (int i = 43; i <= 75; i++) {
        if (i != 56 && i != 57 && i != 58 && i != 67) {
            NSString *imgName = [NSString stringWithFormat:@"IMG_03%d.jpg",i];
            [animationArray addObject:[UIImage imageNamed:imgName]];
            NSLog(@"imgName: %@", imgName);
        }
    }
    
    //[animationArray addObject:nil];
    
    CGRect frame = self.view.frame;
    CGFloat gridX = CGRectGetWidth(frame)*.1;
    CGFloat gridY = CGRectGetHeight(frame)*.1;
    CGFloat gridSize = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame))*.80;
    CGRect animationFrame = CGRectMake(gridX, gridY, gridSize, gridSize);
    
    UIImageView *animationView = [[UIImageView alloc] initWithFrame:animationFrame];
    animationView.animationImages = animationArray;
    animationView.animationDuration = 3;
    animationView.animationRepeatCount = 3;
    [animationView startAnimating];
    [self.view addSubview:animationView];
    //[animationView release];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
