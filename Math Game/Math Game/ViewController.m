//
//  ViewController.m
//  Math Game
//
//  Created by Hugo Ho on 10/17/14.
//  Copyright (c) 2014 CS 121 Team 6. All rights reserved.
//

#import "ViewController.h"
#import "DataView.h"
#import "DataModel.h"

@interface ViewController ()
{
    int _currentScore;
    DataView* _dataView;
    DataModel* _dataModel;
};
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect frame = self.view.frame;
    
    // Create DataModel
    _dataModel = [DataModel alloc];
    _currentScore = [_dataModel getScore];
    
    // Create DataView
    _dataView = [[DataView alloc] initWithFrame:frame andScore:_currentScore];
    [self.view addSubview:_dataView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
