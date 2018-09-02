

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

/**
 阴影矩形

 @param offset 偏移
 @param shadowColor 阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius 矩形圆角
 */
- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius;

- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor;

/**
 @param offset 偏移
 @param shadowColor 阴影颜色
 @param shadowOpacity 阴影透明度
 @param cornerRadius 圆角
 @param shadowRadius 阴影半径
 */
- (void)shadowPath:(CGPoint)offset shadowColor:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)shadowRadius;
@end
