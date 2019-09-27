//
//  SeparatorView.m
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "SeparatorView.h"

@implementation SeparatorView

#pragma mark - life cycle
- (void)addSomeConstraints {
    [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.width = 1;
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - getter and setter
- (void)setWidth:(CGFloat)width {
    _width = width;
    [self invalidateIntrinsicContentSize];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.width, self.width);
}

- (UIColor *)color {
    return self.backgroundColor ?: [UIColor clearColor];
}

- (void)setColor:(UIColor *)color {
    self.backgroundColor = color;
}

@end
