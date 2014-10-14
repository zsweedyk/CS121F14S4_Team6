//
//  DataView.h
//  TestTimer
//
//  Created by Shannon on 10/12/14.
//  Copyright (c) 2014 Shannon Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataView : UIView
{
    int _initialTime;
    UILabel* _currentTime;
    UILabel* _currentScore;
    NSTimer* _gameTimer;
}

- (id)initWithFrame:(CGRect)frame andScore:(int)currentScore;
- (void)updateScore: (int)newScore;

@end
