//
//  Highlightable.m
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "Highlightable.h"
#import "StackViewCell.h"

@implementation UIView (Highlightable)

- (BOOL)isHighlightable {
    return YES;
}

- (void)setIsHighlighted:(BOOL)isHighlighted {
    if (self.superview && [self.superview isKindOfClass:[StackViewCell class]]) {
        StackViewCell *cell = (StackViewCell *)self.superview;
        cell.backgroundColor = isHighlighted ? cell.rowHighlightColor : cell.rowBackgroundColor;
    }
}

@end
