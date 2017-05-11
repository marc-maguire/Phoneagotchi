//
//  MMPet.h
//  Phonagotchi
//
//  Created by Marc Maguire on 2017-05-11.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMPet : NSObject

@property (nonatomic,readonly) BOOL isGrumpy;

-(void)pettingAnalyzer:(CGPoint)velocity;
//the point will be points per second
//points is an x and y value
//can check the points explicetly. if velocity.x > somevalue  && velocity.y > somevalue)


@end
