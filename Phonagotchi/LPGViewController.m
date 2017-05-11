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
@property (nonatomic) UIImageView *foodImageView;
@property (nonatomic) UIImageView *bucketImageView;
@property (nonatomic) MMPet *pet;
@property (nonatomic) UIImageView *draggableImageView;

@end

@implementation LPGViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    
#pragma mark - set up main view and init subviews
    
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.petImageView.image = [UIImage imageNamed:@"default"];
    self.petImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.petImageView];
    
    self.foodImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"apple.png"]];
    self.foodImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.foodImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.foodImageView];

    self.bucketImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bucket.png"]];
    self.bucketImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bucketImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.bucketImageView];
    
    self.pet = [[MMPet alloc]init];
    
    
    
#pragma mark - ImageView Constraints
    

    //center the pet image view
    //petimageView center x
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    //petimageview center y
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.petImageView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    //constraint food image view to bottom left
    //foodimageView bottom constraint
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.0 constant:-18.0]];

    //foodimageView left constraint
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeLeftMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeftMargin
                                                         multiplier:1.0 constant:8.0]];
    //foodImageView width
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];
    //foodImageView height
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.foodImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];
    //constraint bucketImageView to bottom right
    //bucketImageView bottom constraint
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeBottomMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottomMargin
                                                         multiplier:1.0 constant:-18.0]];
    
    //bucketImageView right constraint
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeRightMargin
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRightMargin
                                                         multiplier:1.0 constant:-8.0]];
    //bucketImageView width
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];
    //bucketImageView height
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bucketImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:75]];


#pragma mark - Gesture Recognizers
    
    //create pan recognizer
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action: @selector(pettingThePet:)];
    //add it as a gesturerecognizer of the image view you want to work on
    [self.petImageView addGestureRecognizer:panGestureRecognizer];
    
    //create long press recognizer
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(feedThePet:)];
    [self.foodImageView addGestureRecognizer:longPressGestureRecognizer];
   
   

    
}

//cgrect intersects rect

#pragma mark - Gesture Methods

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

-(IBAction)feedThePet:(UILongPressGestureRecognizer *)gesture {
    NSLog(@"recognized");
        //the gesture knows it's view, but it is generic, the view could be a button, an image, etc. In this case we know it is a UIImageView so we cast the view to be that, then that allows us to access the image
    

    if (gesture.state == UIGestureRecognizerStateBegan) {
        
      //  UIImageView *imageView = (UIImageView *)gesture.view;
        self.draggableImageView = [[UIImageView alloc]initWithFrame:self.foodImageView.frame];
                                   self.draggableImageView.image = self.foodImageView.image;
        
        [self.view addSubview:self.draggableImageView];
                                   
        
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        
        self.draggableImageView.center = [gesture locationInView:self.view];
        
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
      //if stopped location is within bounds of cat image, feed cat, if not, animate off screen.
        if (CGRectIntersectsRect(self.foodImageView.frame, self.petImageView.frame)) {
            //animate eating
        } else {
            //animate falling off screen
        }
    }
    
    
    
    
    
}


@end
