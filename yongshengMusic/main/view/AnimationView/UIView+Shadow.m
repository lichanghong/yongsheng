
#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius {
    [self shadowPath:offset shadowColor:shadowColor shadowOpacity:shadowOpacity cornerRadius:shadowRadius shadowRadius:3];
}

- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor {
    [self shadowPath:offset shadowColor:shadowColor shadowOpacity:1 shadowRadius:0];
}

- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius
{
    CGRect rect = CGRectMake(offset.x, offset.y, self.bounds.size.width, self.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:shadowRadius];
    self.layer.shadowPath = path.CGPath;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
}
@end
