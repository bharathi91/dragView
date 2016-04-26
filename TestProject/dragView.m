
#import "dragView.h"

@implementation dragView
@synthesize delegate;
@synthesize dragLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       // [self baseInit];
        self.backgroundColor=[UIColor brownColor];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame options:(NSMutableDictionary *)optionals
{
    self = [super initWithFrame:frame];
    if (self) {
        // [self baseInit];
        _setSelectedIndex=nil;
        self.backgroundColor=[UIColor orangeColor];
        self.options=optionals;
        arrayLabel=[[NSMutableArray alloc]init];
        [self createLayout];
        
    }
    return self;
}
-(void)setSetSelectedIndex:(NSInteger *)setSelectedIndex

{
    _setSelectedIndex=setSelectedIndex;
    [self updateText];

}
-(void)createLayout
{
    int x=1;
    for (int i=1; i<self.options.count+1; i++)
    {
        x=(self.frame.size.width/self.options.count)*i;
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x,self.frame.size.height/2)];
        [path addLineToPoint:CGPointMake(x,self.frame.size.height)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = [path CGPath];
        shapeLayer.strokeColor = [[UIColor blueColor] CGColor];
        shapeLayer.lineWidth = 0.4;
        shapeLayer.fillColor = [[UIColor clearColor] CGColor];
       UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width/self.options.count)*(i-1), self.frame.size.height/2, x/i,self.frame.size.height/2)];
        [self addSubview:label];
        label.backgroundColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.tag=i-1;
        NSString *firstKey = [self.options allKeys][i-1];
        label.text=[self.options valueForKey:firstKey];
        [self.layer addSublayer:shapeLayer];
        [arrayLabel addObject:label];
    }
   
    x=(self.frame.size.width/self.options.count);
    self.ViewArrow=[[arrowView alloc]initWithFrame:CGRectMake(0, 0, x,self.frame.size.height/2)];
    self.dragLabel=[[UILabel alloc]init];
    self.dragLabel.font=[UIFont fontWithName:@"Avenior-Book" size:14];
    self.dragLabel.textColor=[UIColor whiteColor];
    self.dragLabel.textAlignment=NSTextAlignmentCenter;
    CGSize size = [[self.options valueForKey:[self.options allKeys][0]] sizeWithAttributes:
                   @{NSFontAttributeName: self.dragLabel.font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    [self.dragLabel setFrame:CGRectMake(10,6,adjustedSize.width,20)];
    self.strSelectedOption=self.dragLabel.text;
    self.dragLabel.backgroundColor=[UIColor redColor];
    [self.ViewArrow addSubview:self.dragLabel];
    [self resizeToFitSubviews];
    [self addSubview:self.ViewArrow];
    [self updateText];
}
-(void)updateText
{
    int index=0;
    if (_setSelectedIndex)
    {
        index=(int)_setSelectedIndex;
    }
    UILabel *label=[arrayLabel objectAtIndex:index];
    CGRect frame=self.ViewArrow.frame;
    NSLog(@"%@",label.text);
    self.dragLabel.text=label.text;
    frame.origin.x=label.frame.origin.x-((self.ViewArrow.frame.size.width-label.frame.size.width)/2);
    [self.ViewArrow setFrame:frame];
    [self.ViewArrow setNeedsLayout];
    self.strSelectedOption=self.dragLabel.text;
}

-(void)resizeToFitSubviews
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in self.ViewArrow.subviews) {
        float fw = v.frame.origin.x + v.frame.size.width;
        float fh = v.frame.origin.y + v.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [self.ViewArrow setFrame:CGRectMake(self.ViewArrow.frame.origin.x, self.ViewArrow.frame.origin.y, w+10, h+15)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
   CGPoint startingPoint = [touch locationInView:self];
    
    NSLog(@"Touch starting point = x : %f Touch Starting Point = y : %f", startingPoint.x, startingPoint.y);
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
   CGPoint touchPoint = [touch locationInView:self];
    CGRect frame=self.ViewArrow.frame;
    NSLog(@"%@",touch.view.subviews);
    if ([touch.view isKindOfClass:[dragView class]])
    {
        for (UIView *view in touch.view.subviews)
        {
            if(CGRectContainsPoint(view.frame, touchPoint)){
                if ([view isKindOfClass:[UILabel class]])
                {
                    UILabel *label2=(UILabel *)view;
                    NSLog(@"%@",label2.text);
                    self.dragLabel.text=label2.text;
                    frame.origin.x=label2.frame.origin.x-((self.ViewArrow.frame.size.width-label2.frame.size.width)/2);
                   [self.ViewArrow setFrame:frame];
                    [self.ViewArrow setNeedsLayout];
                    self.strSelectedOption=self.dragLabel.text;
                    [delegate dragViewDidFinish:self selectedValue:self.strSelectedOption];
                }
            }
        }
       
    }
   
    NSLog(@"Touch end point =x : %f Touch end point =y : %f", touchPoint.x, touchPoint.y);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint  touchPoint = [touch locationInView:self];
    CGRect frame=self.ViewArrow.frame;
    if ([touch.view isKindOfClass:[dragView class]])
        {
            for (UIView *view in touch.view.subviews)
            {
                if(CGRectContainsPoint(view.frame, touchPoint)){
                    if ([view isKindOfClass:[UILabel class]])
                        {
                    UILabel *label2=(UILabel *)view;
                    NSLog(@"%@",label2.text);
                    self.dragLabel.text=label2.text;
                    frame.origin.x=label2.frame.origin.x-((self.ViewArrow.frame.size.width-label2.frame.size.width)/2);
                    [self.ViewArrow setFrame:frame];
                    [self.ViewArrow setNeedsLayout];
                    self.strSelectedOption=self.dragLabel.text;
                    [delegate dragViewDidFinish:self selectedValue:self.strSelectedOption];
                }
            }
        }
        
    }
    NSLog(@"Touch moving point =x : %f Touch moving point =y : %f", touchPoint.x, touchPoint.y);
}
- (void)tapGestureRecognizer:(UIGestureRecognizer *)recognizer {
}
@end
