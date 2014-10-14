//
//  ViewController.m
//  GeneratorPrototype
//
//  Created by Yaxi Gao on 10/11/14.
//  Copyright (c) 2014 Yaxi Gao. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import <stdlib.h>

@interface ViewController () {
    Model* _model;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _model = [[Model alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    int chanceIndicator = arc4random_uniform(10);
    
    if (chanceIndicator == 1) {
        self.operatorLabel.text = [NSString stringWithFormat:@"ABSOLUTE!"];
        self.valueLabel.text = [NSString stringWithFormat:@" "];
    } else {
        if (chanceIndicator % 2 == 0) {
            int value = [_model generateIntegerfrom:-100 to:100];
            self.valueLabel.text = [NSString stringWithFormat:@"%d", value];
        } else {
            NSMutableArray* fraction = [_model generateFraction];
            int numerator = (int)[[fraction objectAtIndex:0] integerValue];
            int denomenator = (int)[[fraction objectAtIndex:1] integerValue];
            float result = (float)numerator / (float)denomenator;
            if (numerator == 0) {
                self.valueLabel.text = [NSString stringWithFormat:@"%d / %d (0)", numerator, denomenator];
            } else {
                self.valueLabel.text = [NSString stringWithFormat:@"%d / %d ( %.3f )", numerator, denomenator, result];
            }
            
        }
        
        char operator = [_model generateOperator];
        self.operatorLabel.text = [NSString stringWithFormat:@"%c", operator];
    }
    
}

@end
