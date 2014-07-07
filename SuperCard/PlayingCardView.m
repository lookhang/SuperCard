//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Fantasy on 14-7-6.
//  Copyright (c) 2014年 Fantasy. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView


#pragma mark - Properties
@synthesize faceCardScaleFactor=_faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

#pragma mark - Drawing
#define CORNER_RADIUS 12.0
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundRect=[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    [roundRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    UIImage *faceImage=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[self rankAsString],self.suit]);
    if (faceImage) {
        CGRect imageRect=CGRectInset(self.bounds, self.bounds.size.width*(1.0-self.faceCardScaleFactor), self.bounds.size.height *(1.0-self.faceCardScaleFactor));
        [faceImage drawInRect:imageRect];
    }
    
    [self drawCorners];
    
    [[UIColor blackColor] setStroke];
    [roundRect stroke];
}

//绘制角落的文本
#define PIP_FONT_SCALE_FACTOR 0.20
#define CORNER_OFFSET 2.0
- (void)drawCorners{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment=NSTextAlignmentCenter;
    
    UIFont *cornerFont=[UIFont systemFontOfSize:self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    
    NSAttributedString *cornerText=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit] attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:cornerFont}];
    CGRect textBounds;
    textBounds.origin=CGPointMake(CORNER_OFFSET, CORNER_OFFSET);
    textBounds.size=[cornerText size];
    [cornerText drawInRect:textBounds];
    
    [self pushContextAndRotateUpsideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
    
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Initialization

-(void)setup{
    self.backgroundColor=nil;
    self.opaque=NO;
    self.contentMode=UIViewContentModeRedraw;
}

-(void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

@end
