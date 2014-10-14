//
//  ViewController.m
//  TestTimer
//
//  Created by Shannon on 10/12/14.
//  Copyright (c) 2014 Shannon Lin. All rights reserved.
//

#import "ViewController.h"
#import "DataView.h"
#import "DataModel.h"

@interface ViewController ()
{
    int _currentScore;
    DataView* _dataView;
    DataModel* _dataModel;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] initWithFrame:frame andScore:_currentScore];
    [self.view addSubview:_dataView];
    
    // Create a testButton
    CGFloat buttonX = CGRectGetWidth(frame)*0.05;
    CGFloat buttonY = CGRectGetHeight(frame)*0.1;
    CGRect buttonFrame = CGRectMake(buttonX, buttonY, 120, 50);
    UIButton* scoreChanger = [[UIButton alloc] initWithFrame:buttonFrame];
    [scoreChanger setTitle:@"Change score" forState:UIControlStateNormal];
    [scoreChanger setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scoreChanger addTarget:self action:@selector(changeScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: scoreChanger];
}

- (void)changeScore
{
    [_dataModel setScore:(_currentScore += 50)];
    [_dataView updateScore:_currentScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
