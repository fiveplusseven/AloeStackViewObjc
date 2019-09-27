//
//  StackViewCell.h
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapHandler)(UIView *view);

@interface StackViewCell : UIView

@property (nonatomic, strong) UIView *contentView;
- (instancetype)initWithContentView:(UIView *)contentView;

@property (nonatomic, copy, nullable) TapHandler tapHandler;

@property (nonatomic, strong) UIColor *rowHighlightColor;
@property (nonatomic, strong) UIColor *rowBackgroundColor;
@property (nonatomic, assign) UIEdgeInsets rowInset;

@property (nonatomic, assign) UILayoutConstraintAxis separatorAxis;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
@property (nonatomic, assign, getter=isSeparatorHidden) BOOL separatorHidden;

// internal
@property (nonatomic, assign) BOOL shouldHideSeparator;

@end

NS_ASSUME_NONNULL_END
