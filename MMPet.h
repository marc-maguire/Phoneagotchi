//
//  MMPet.h
//  Phonagotchi
//
//  Created by Marc Maguire on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

//interuption wakes up the pet but the timers still go in the wrong direction
//pet does not fall asleep if there is no user interaction


@protocol CatProtocol <NSObject>

-(void)setPetStateImage;

@end

@interface MMPet : NSObject

@property (nonatomic,readonly) BOOL isGrumpy;
@property (nonatomic) BOOL isAsleep;
@property (nonatomic) NSInteger restfullness;
@property (nonatomic) NSInteger crankyNess;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) id<CatProtocol> delegate;


//for given amount of time;


- (void)pettingAnalyzer:(CGPoint)velocity;
//the point will be points per second
//points is an x and y value
//can check the points explicetly. if velocity.x > somevalue  && velocity.y > somevalue)
- (void)sleepTimer;
- (void)awakeTimer;
- (void)setPetStateImage;
- (void)makeHappy;


@end
