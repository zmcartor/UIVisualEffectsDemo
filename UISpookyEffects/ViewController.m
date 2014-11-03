//
//  ViewController.m
//  UISpookyEffects
//
//  Created by Zach McArtor on 10/27/14.
//  Copyright (c) 2014 HackaZach. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property UIImageView *ghost;
@property UIImageView *ghost1;
@property UIImageView *ghost2;
@property UIImageView *ghost3;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property UIScreenEdgePanGestureRecognizer *pan;
@property UIView *hudView;
@property (nonatomic, assign) BOOL hudVisible;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipePan:)];
    [self.pan setEdges:UIRectEdgeLeft];
    [self.view addGestureRecognizer:self.pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipePan:(UIScreenEdgePanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (self.hudVisible) return;
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.hudView.frame = CGRectOffset(self.hudView.frame, self.view.bounds.size.width, 0);
            self.hudVisible = YES;
        } completion:nil];
    }
}

- (void)insertVisualEffectHud {
    self.hudView = [[UIView alloc] initWithFrame:self.view.bounds];
    UITapGestureRecognizer *tappy = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeHud:)];
    tappy.numberOfTapsRequired = 3;
    [self.hudView addGestureRecognizer:tappy];
    self.hudView.frame = CGRectOffset(self.hudView.frame, -self.view.bounds.size.width, 0);
    [self.view addSubview:self.hudView];
   
    //visualEffectsView configured for BLUR
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.frame = self.hudView.bounds;
    [self.hudView addSubview:blurView];
    
    // Another VisualEffectsView configured for Vibrancy
    // what happens if we use the wrong blur ?
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc] initWithEffect:[UIVibrancyEffect effectForBlurEffect:blur]];
    vibrantView.frame = blurView.bounds;
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:33]];
    label.frame = CGRectMake(8, 30, 400, 500);
    label.numberOfLines = 0;
    label.text = @"VIBRANT GHOSTS\nSPOOKY BOO\nTRICK OR TREAT\nSCARY\nBOO BOO!:P\n SCARY\nHAPPY HALLOWEEN \n(triple tap to close BOO!)";
    [vibrantView.contentView addSubview:label];
    
    // add vibrantView to first blurView
    [blurView.contentView addSubview:vibrantView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.backgroundImage.image = [UIImage imageNamed:@"house.jpeg"];
   
    self.ghost = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ghost.png"]];
    self.ghost.frame = CGRectMake(0, 0, 40, 40);
    [self.view addSubview:self.ghost];
    
    self.ghost1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ghost.png"]];
    self.ghost1.frame = CGRectMake(0, 0, 60, 60);
    [self.view addSubview:self.ghost1];
    
    self.ghost2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ghost.png"]];
    self.ghost2.frame = CGRectMake(0, 0, 75, 75);
    [self.view addSubview:self.ghost2];
    
    self.ghost3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ghost.png"]];
    self.ghost3.frame = CGRectMake(0, 0, 30, 30);
    [self.view addSubview:self.ghost3];
    
    
    CGRect boundingRect = CGRectMake(0,100, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    [self.ghost.layer addAnimation:orbit forKey:@"orbit"];
    
    CAKeyframeAnimation *orbit1 = [CAKeyframeAnimation animation];
    orbit1.keyPath = @"position";
    orbit1.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit1.duration = 2;
    orbit1.additive = YES;
    orbit1.repeatCount = HUGE_VALF;
    orbit1.calculationMode = kCAAnimationPaced;
    orbit1.rotationMode = kCAAnimationRotateAuto;
    [self.ghost1.layer addAnimation:orbit1 forKey:@"orbit"];
    
    CAKeyframeAnimation *orbit2 = [CAKeyframeAnimation animation];
    orbit2.keyPath = @"position";
    orbit2.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit2.duration = 5;
    orbit2.additive = YES;
    orbit2.repeatCount = HUGE_VALF;
    orbit2.calculationMode = kCAAnimationPaced;
    orbit2.rotationMode = kCAAnimationRotateAuto;
    [self.ghost2.layer addAnimation:orbit2 forKey:@"orbit"];
   
    CAKeyframeAnimation *orbit3 = [CAKeyframeAnimation animation];
    orbit3.keyPath = @"position";
    orbit3.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit3.duration = 1.75;
    orbit3.additive = YES;
    orbit3.repeatCount = HUGE_VALF;
    orbit3.calculationMode = kCAAnimationPaced;
    orbit3.rotationMode = kCAAnimationRotateAuto;
    [self.ghost3.layer addAnimation:orbit3 forKey:@"orbit"];
   
    [self insertVisualEffectHud];
}

- (void) removeHud:(UITapGestureRecognizer *)tapRecog {
    [UIView animateWithDuration:3 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGAffineTransform shrink = CGAffineTransformScale(CGAffineTransformIdentity, 0.8 , 0.8);
        self.hudView.transform = shrink;
        self.hudView.frame = CGRectOffset(self.hudView.frame, -self.view.bounds.size.width, 0);
        self.hudVisible = NO;
    } completion:^(BOOL sucess){
        self.hudView.transform = CGAffineTransformIdentity;
    }];
}

@end
