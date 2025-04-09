//
//  UIScrollView+WMRTLSupport.m
//  WMPageController
//
//  Created by 陈群 on 2025/4/7.
//

#import "UIScrollView+WMRTLSupport.h"
#import <objc/runtime.h>

static char contentRefWidthKey;

@implementation UIScrollView (WMRTLSupport)

#pragma mark - Associated Properties

- (CGFloat)rtl_contentRefWidth {
    NSNumber *width = objc_getAssociatedObject(self, &contentRefWidthKey);
    return width ? width.doubleValue : self.contentSize.width;
}

- (void)setRtl_contentRefWidth:(CGFloat)rtl_contentRefWidth {
    objc_setAssociatedObject(self, &contentRefWidthKey, @(rtl_contentRefWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - RTL Layout Support

- (UIEdgeInsets)rtl_contentInset {
    return self.contentInset; // 实际逻辑在 setter 中处理
}

- (void)setRtl_contentInset:(UIEdgeInsets)rtl_contentInset isLTR:(BOOL)isLTR {
    if (isLTR) {
        self.contentInset = rtl_contentInset;
        return;
    }
    self.contentInset = UIEdgeInsetsMake(rtl_contentInset.top,
                                        rtl_contentInset.right,
                                        rtl_contentInset.bottom,
                                        rtl_contentInset.left);
}

- (CGPoint)rtl_contentOffset {
    return self.contentOffset; // 实际逻辑在 setter 中处理
}

- (void)setRtl_contentOffset:(CGPoint)rtl_contentOffset isLTR:(BOOL)isLTR {
    if (isLTR) {
        self.contentOffset = rtl_contentOffset;
        return;
    }
    CGFloat offsetX = self.rtl_contentRefWidth - self.bounds.size.width - rtl_contentOffset.x;
    self.contentOffset = CGPointMake(offsetX, rtl_contentOffset.y);
}

- (void)rtl_setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated isLTR:(BOOL)isLTR {
    CGPoint offset = contentOffset;
    if (isLTR == false) {
        CGFloat offsetX = self.rtl_contentRefWidth - self.bounds.size.width - contentOffset.x;
        offset = CGPointMake(offsetX, contentOffset.y);
    }
    [self setContentOffset:offset animated:animated];
}

- (CGFloat)rtl_valueFromSelf:(CGFloat)value isLTR:(BOOL)isLTR {
    return isLTR ? value : (self.rtl_contentRefWidth - value);
}

- (CGPoint)rtl_contentOffset:(CGPoint)offset isLTR:(BOOL)isLTR {
    if (isLTR) {
        return offset;
    }
    CGFloat offsetX = self.rtl_contentRefWidth - self.bounds.size.width - offset.x;
    return CGPointMake(offsetX, offset.y);
}

@end
