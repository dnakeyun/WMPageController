//
//  UIScrollView+WMRTLSupport.h
//  WMPageController
//
//  Created by 陈群 on 2025/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (WMRTLSupport)

/// 内容参照宽度（默认取 `contentSize.width`）
@property (nonatomic, assign) CGFloat rtl_contentRefWidth;

/// RTL 布局下的 `contentInset`（交换 `left` 和 `right`）
@property (nonatomic, assign) UIEdgeInsets rtl_contentInset;

/// RTL 布局下的 `contentOffset`（基于 `rtl_contentRefWidth` 计算）
@property (nonatomic, assign) CGPoint rtl_contentOffset;

/// 设置 RTL 布局下的 `contentOffset`（支持动画）
- (void)rtl_setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;

/// 相对【自身宽度】的转换值（RTL 时取反）
- (CGFloat)rtl_valueFromSelf:(CGFloat)value isLTR:(BOOL)isLTR;

/// 转换 `contentOffset`（RTL 时基于 `rtl_contentRefWidth` 计算）
- (CGPoint)rtl_contentOffset:(CGPoint)offset isLTR:(BOOL)isLTR;

@end

NS_ASSUME_NONNULL_END
