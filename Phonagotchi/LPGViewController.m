//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "MMPet.h"
@interface LPGViewController ()

@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) MMPet *pet;

@end

@implementation LPGViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    self.pet = [[MMPet alloc]init];
    //create pan recognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(pettingThePet:)];
    //add it as a gesturerecognizer of the image view you want to work on
    self.petImageView.userInteractionEnabled = YES;
    [self.petImageView addGestureRecognizer:panGestureRecognizer];


}



-(IBAction)pettingThePet:(UIPanGestureRecognizer *)gesture {
                                                                                                                 
    [self.pet pettingAnalyzer:[gesture velocityInView:self.petImageView]];
    if (self.pet.isGrumpy) {
        self.petImageView.image = [UIImage imageNamed:@"grumpy.png"];
    } else {
        self.petImageView.image = [UIImage imageNamed:@"sleeping.png"];
    }
    // call the pettingAnalyzer method that is part of our pet class
    //feed the value from the PanGestureRecognizer sender that is velocityInView -where we pass in the view that the gesture will be happening (which can be self.view) but in this case is self.petImageView so that it only happens when the image of the pet is touched.
}


@end
