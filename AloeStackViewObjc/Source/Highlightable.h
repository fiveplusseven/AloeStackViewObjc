//
//  Highlightable.h
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Highlightable <NSObject>

- (BOOL)isHighlightable;
- (void)setIsHighlighted:(BOOL)isHighlighted;

@end

@interface UIView (Highlightable) <Highlightable>

@end
