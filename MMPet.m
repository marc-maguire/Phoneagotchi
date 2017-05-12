//
//  MMPet.m
//  Phonagotchi
//
//  Created by Marc Maguire on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "MMPet.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MMPet()

@property (nonatomic,readwrite) BOOL isGrumpy;


@end

@implementation MMPet

- (instancetype)init {
    
    if (self = [super init]) {
        _isGrumpy = NO;
        _isAsleep = NO;
        _restfullness = 60;
        _crankyNess = 0;
    }
    
    return self;
}

- (void)pettingAnalyzer:(CGPoint)velocity {
    //the point will be points per second
    //points is an x and y value
    //in order to take direction out of the drag (+ or - values as x and y change) then you need to calculate the pythagorean theorum. This leaves you with a CG Point representing points per second moved in ANY direction.
    CGFloat speedLimit = [self crankyModifier];
    CGFloat speed = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
    
    if (speed < speedLimit) {
        self.isGrumpy = NO;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    } else {
        self.isGrumpy = YES;
    }
    NSLog(@"%@",(self.isGrumpy) ? @"I am GRUMPY AFFFFFF" : @"Nice petting, me no grumpy");
    NSLog(@"%ld",(long)self.crankyNess);
}


//for given amount of time;
- (void)sleepTimer{
//    self.isAsleep = YES;
//    [self setPetStateImage];
    NSDate *date = [[NSDate alloc]init];
    
    self.timer = [[NSTimer alloc]initWithFireDate:[date dateByAddingTimeInterval:5.0] interval:5.0 target:self selector:@selector(increaseRestfullness) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}

- (void)awakeTimer {
//    self.isAsleep = NO;
//    [self setPetStateImage];
    NSDate *date = [[NSDate alloc]init];
    
    self.timer = [[NSTimer alloc]initWithFireDate:[date dateByAddingTimeInterval:5.0] interval:5.0 target:self selector:@selector(decreaseRestfullness) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
    }

//[NSTimer *timer = [NSTimer alloc]init

- (CGFloat)crankyModifier {
    
    CGFloat speedModifier = 175;
    //when cranky is maxed at 10, speed modifier will be 75
    speedModifier = 175 - (10 * self.crankyNess);
    return speedModifier;
    
}

- (void)increaseRestfullness {
    
    NSLog(@"increasing restfulness by 5");
    if (self.restfullness <= 55) {
        self.restfullness += 5;
        [self decrankify];
 
    } else {
        self.isAsleep = NO;
        NSLog(@"Waking up!");
        [self.timer invalidate];
        [self awakeTimer];
    }
    [self setPetStateImage];
}

- (void)decreaseRestfullness {
    
    NSLog(@"decreasing restfulness by 5");
    if (self.restfullness >= 5) {
        self.restfullness -= 5;
        [self crankify];
    } else {
        self.isAsleep = YES;
        NSLog(@"Going to sleep");
        [self.timer invalidate];
        [self sleepTimer];
    }
    [self setPetStateImage];
}

- (void)decrankify {

    if (self.crankyNess > 0) {
        self.crankyNess -= 1;
    } else {
        self.crankyNess = 0;
    }
}

- (void)crankify {
    
    if (self.crankyNess < 10) {
        self.crankyNess += 1;
    } else {
        self.crankyNess = 10;
    }
}

- (void)makeHappy{
    self.isGrumpy = NO;
}

#pragma mark - Delegate Methods

- (void)setPetStateImage {
    
    [self.delegate setPetStateImage];
    
}




@end
