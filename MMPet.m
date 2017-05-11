//
//  MMPet.m
//  Phonagotchi
//
//  Created by Marc Maguire on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "MMPet.h"
//#include "math.h"

@interface MMPet()

@property (nonatomic,readwrite) BOOL isGrumpy;

@end

@implementation MMPet

-(instancetype)init {
    
    if (self = [super init]) {
        _isGrumpy = NO;
    }
    
    
    return self;
}

- (void)pettingAnalyzer:(CGPoint)velocity {
    //the point will be points per second
    //points is an x and y value
    //in order to take direction out of the drag (+ or - values as x and y change) then you need to calculate the pythagorean theorum. This leaves you with a CG Point representing points per second moved in ANY direction.
    CGFloat speed = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    
    if (speed < 175) {
        self.isGrumpy = NO;
    } else {
        self.isGrumpy = YES;
    }
    
    NSLog(@"%@",(self.isGrumpy) ? @"I am GRUMPY AFFFFFF" : @"Nice petting, me no grumpy");
}



@end
