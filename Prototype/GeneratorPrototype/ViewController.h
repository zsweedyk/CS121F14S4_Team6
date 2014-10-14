//
//  ViewController.h
//  GeneratorPrototype
//
//  Created by Yaxi Gao on 10/11/14.
//  Copyright (c) 2014 Yaxi Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(weak,nonatomic) IBOutlet UILabel* operatorLabel;
@property(weak,nonatomic) IBOutlet UILabel* valueLabel;

- (IBAction)buttonPressed:(id)sender;

@end

