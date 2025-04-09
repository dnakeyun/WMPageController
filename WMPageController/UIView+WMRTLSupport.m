//
//  UIView+WMRTLSupport.m
//  WMPageController
//
//  Created by 陈群 on 2025/4/7.
//

#import "UIView+WMRTLSupport.h"
#import <objc/runtime.h>

static char refWidthKey;
@implementation UIView (WMRTLSupport)

// 参照宽度，也就是【父视图】的宽度
// 如果【父视图】是`UIScrollView`最好将其设置为它的`contentSize.width`
- (CGFloat)rtl_refWidth {
    NSNumber *width = objc_getAssociatedObject(self, &refWidthKey);
    if (width) {
        return [width doubleValue];
    }
    return self.superview ? CGRectGetMaxX(self.superview.bounds) : 0;
}

- (void)setRtl_refWidth:(CGFloat)rtl_refWidth {
    objc_setAssociatedObject(self, &refWidthKey, @(rtl_refWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)rtl_frame:(BOOL)isLTR {
    if (isLTR) {
        return self.frame;
    }
    CGFloat x = self.rtl_refWidth - CGRectGetMaxX(self.frame);
    return CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
+ (CGRect)rtl_frame:(BOOL)isLTR convertFrame:(CGRect)frame refWidth:(CGFloat)refWidth {
    if (isLTR) {
        return frame;
    }
    CGFloat x = refWidth - CGRectGetMaxX(frame);
    return CGRectMake(x, frame.origin.y, frame.size.width, frame.size.height);
}

- (void)setRtl_frame:(CGRect)rtl_frame isLTR:(BOOL)isLTR {
    if (isLTR) {
        self.frame = rtl_frame;
        return;
    }
    CGFloat superWidth = self.rtl_refWidth;
    CGFloat x = self.rtl_refWidth - CGRectGetMaxX(rtl_frame);
    self.frame = CGRectMake(x, rtl_frame.origin.y, rtl_frame.size.width, rtl_frame.size.height);
}

- (CGPoint)rtl_center:(BOOL)isLTR {
    if (isLTR) {
        return self.center;
    }
    CGFloat centerX = self.rtl_refWidth - self.center.x;
    return CGPointMake(centerX, self.center.y);
}

- (void)setRtl_center:(CGPoint)rtl_center isLTR:(BOOL)isLTR {
    if (isLTR) {
        self.center = rtl_center;
        return;
    }
    CGFloat centerX = self.rtl_refWidth - rtl_center.x;
    self.center = CGPointMake(centerX, rtl_center.y);
}

- (CGFloat)rtl_x:(BOOL)isLTR {
    if (isLTR) {
        return self.frame.origin.x;
    }
    return self.rtl_refWidth - CGRectGetMaxX(self.frame);
}

- (void)setRtl_x:(CGFloat)rtl_x isLTR:(BOOL)isLTR {
    if (isLTR) {
        CGRect frame = self.frame;
        frame.origin.x = rtl_x;
        self.frame = frame;
        return;
    }
    CGFloat x = self.rtl_refWidth - self.frame.size.width - rtl_x;
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)rtl_midX:(BOOL)isLTR {
    if (isLTR) {
        return CGRectGetMidX(self.frame);
    }
    return self.rtl_refWidth - CGRectGetMidX(self.frame);
}

- (CGFloat)rtl_maxX:(BOOL)isLTR {
    if (isLTR) {
        return CGRectGetMaxX(self.frame);
    }
    return self.rtl_refWidth - self.frame.origin.x;
}

/// 相对【自身宽度】的转换值
- (CGFloat)rtl_valueFromSelf:(CGFloat)v isLTR:(BOOL)isLTR {
    return isLTR ? v : (self.bounds.size.width - v);
}

/// 相对【参照宽度】的转换值
- (CGFloat)rtl_valueFromRef:(CGFloat)v isLTR:(BOOL)isLTR {
    return isLTR ? v : (self.rtl_refWidth - v);
}

@end
