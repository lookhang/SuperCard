//
//  ViewController.m
//  SuperCard
//
//  Created by Fantasy on 14-7-6.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController

- (void)setPlayingCardView:(PlayingCardView *)playingCardView
{
    NSLog(@"setPlayingCardView");
    _playingCardView = playingCardView;
    //[self drawRandomPlayingCard];
    //[playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:playingCardView action:@selector(pinch:)]];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.playingCardView.rank=10;
    self.playingCardView.suit=@"♥";
    self.playingCardView.faceUp=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
