//
//  UIView+WMRTLSupport.h
//  WMPageController
//
//  Created by 陈群 on 2025/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WMRTLSupport)
// 参照宽度，也就是【父视图】的宽度
// 如果【父视图】是`UIScrollView`最好将其设置为它的`contentSize.width`
- (CGFloat)rtl_refWidth;
- (void)setRtl_refWidth:(CGFloat)rtl_refWidth;

- (CGRect)rtl_frame:(BOOL)isLTR;
+ (CGRect)rtl_frame:(BOOL)isLTR convertFrame:(CGRect)frame refWidth:(CGFloat)refWidth;

- (void)setRtl_frame:(CGRect)rtl_frame isLTR:(BOOL)isLTR;

- (CGPoint)rtl_center:(BOOL)isLTR;

- (void)setRtl_center:(CGPoint)rtl_center isLTR:(BOOL)isLTR;
- (CGFloat)rtl_x:(BOOL)isLTR;

- (void)setRtl_x:(CGFloat)rtl_x isLTR:(BOOL)isLTR;

- (CGFloat)rtl_midX:(BOOL)isLTR;
- (CGFloat)rtl_maxX:(BOOL)isLTR;

/// 相对【自身宽度】的转换值
- (CGFloat)rtl_valueFromSelf:(CGFloat)v isLTR:(BOOL)isLTR;
/// 相对【参照宽度】的转换值
- (CGFloat)rtl_valueFromRef:(CGFloat)v isLTR:(BOOL)isLTR;
@end

NS_ASSUME_NONNULL_END
