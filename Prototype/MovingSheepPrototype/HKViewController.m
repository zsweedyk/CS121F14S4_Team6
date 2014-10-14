//
//  HKViewController.m
//  MovingSheepPrototype
//
//  Created by HMC on 10/13/14.
//  Copyright (c) 2014 Hana Kim. All rights reserved.
//

#import "HKViewController.h"

@interface HKViewController () 

@end

@implementation HKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //myImage.center = CGPointMake(320,120);
    
    pos = CGPointMake(-1.0,0.0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
}

-(void) onTimer {
    myImage1.center = CGPointMake(myImage1.center.x+pos.x,myImage1.center.y+pos.y);
    if (myImage1.center.x < -50)
        myImage1.center = CGPointMake(myImage1.center.x+860, myImage1.center.y);
    
    myImage2.center = CGPointMake(myImage2.center.x+pos.x,myImage2.center.y+pos.y);
    if (myImage2.center.x < -50)
        myImage2.center = CGPointMake(myImage2.center.x+860, myImage2.center.y);
    
    myImage3.center = CGPointMake(myImage3.center.x+pos.x,myImage3.center.y+pos.y);
    if (myImage3.center.x < -50)
        myImage3.center = CGPointMake(myImage3.center.x+860, myImage3.center.y);
    
    myImage4.center = CGPointMake(myImage4.center.x+pos.x,myImage4.center.y+pos.y);
    if (myImage4.center.x < -50)
        myImage4.center = CGPointMake(myImage4.center.x+860, myImage4.center.y);


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
