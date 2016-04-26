
#import "arrowView.h"
#define kArrowHeight 10
@implementation arrowView
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *fillPath = [UIBezierPath bezierPath];
    [fillPath moveToPoint:CGPointMake(0, 0)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width,0)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width,self.bounds.size.height-kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2+(kArrowHeight/2), self.bounds.size.height-kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height)];
    [fillPath addLineToPoint:CGPointMake(self.bounds.size.width/2-(kArrowHeight/2), self.bounds.size.height-kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(0,self.bounds.size.height-kArrowHeight)];
    [fillPath addLineToPoint:CGPointMake(0,0)];
    [fillPath closePath];
    CGContextAddPath(context, fillPath.CGPath);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextFillPath(context);
    self.backgroundColor=[UIColor clearColor];
    self.layer.cornerRadius=10.0f;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
@end
