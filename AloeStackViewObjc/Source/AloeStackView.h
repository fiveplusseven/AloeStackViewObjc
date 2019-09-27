//
//  AloeStackView.h
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AloeStackView : UIScrollView

// config aloeStackView
@property (nonatomic, assign) UILayoutConstraintAxis axis;

// add and remove rows
- (void)addRow:(UIView *)row animated:(BOOL)animated;
- (void)addRows:(NSArray<UIView *> *)rows animated:(BOOL)animated;
- (void)prependRow:(UIView *)row animated:(BOOL)animated;
- (void)prependRows:(NSArray<UIView *> *)rows animated:(BOOL)animated;
- (void)insertRow:(UIView *)row beforeRow:(UIView *)beforeRow animated:(BOOL)animated;
- (void)insertRows:(NSArray<UIView *> *)rows beforeRow:(UIView *)beforeRow animated:(BOOL)animated;
- (void)insertRow:(UIView *)row afterRow:(UIView *)afterRow animated:(BOOL)animated;
- (void)insertRows:(NSArray<UIView *> *)rows afterRow:(UIView *)afterRow animated:(BOOL)animated;
- (void)removeRow:(UIView *)row animated:(BOOL)animated;
- (void)removeRows:(NSArray<UIView *> *)rows animated:(BOOL)animated;
- (void)removeAllRowsAnimated:(BOOL)animated;

// access rows
- (nullable UIView *)firstRow;
- (nullable UIView *)lastRow;
- (nullable NSArray<UIView *> *)getAllRows;
- (BOOL)containsRow:(UIView *)row;

// hide and show rows
- (void)hideRow:(UIView *)row animated:(BOOL)animated;
- (void)hideRows:(NSArray<UIView *> *)rows animated:(BOOL)animated;
- (void)showRow:(UIView *)row animated:(BOOL)animated;
- (void)showRows:(NSArray<UIView *> *)rows animated:(BOOL)animated;
- (void)setRow:(UIView *)row isHidden:(BOOL)isHidden animated:(BOOL)animated;
- (void)setRows:(NSArray<UIView *> *)rows isHidden:(BOOL)isHidden animated:(BOOL)animated;
- (BOOL)isRowHidden:(UIView *)row;

// user action
- (void)setTapHandlerForRow:(UIView *)row handler:(nullable TapHandler)handler;

// style rows
@property (nonatomic, strong) UIColor *rowBackgroundColor;
@property (nonatomic, strong) UIColor *rowHighlightColor;
- (void)setBackgroundColor:(UIColor *)color forRow:(UIView *)row;
- (void)setBackgroundColor:(UIColor *)color forRows:(NSArray<UIView *> *)rows;
@property (nonatomic, assign) UIEdgeInsets rowInset;
- (void)setInset:(UIEdgeInsets)inset forRow:(UIView *)row;
- (void)setInset:(UIEdgeInsets)inset forRows:(NSArray<UIView *> *)rows;

// style separator
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
- (void)setSeparatorInset:(UIEdgeInsets)separatorInset forRow:(UIView *)row;
- (void)setSeparatorInset:(UIEdgeInsets)separatorInset forRows:(NSArray<UIView *> *)rows;

// hide and show separators
@property (nonatomic, assign) BOOL hidesSeparatorsByDefault; // default is NO
- (void)hideSeparatorForRow:(UIView *)row;
- (void)hideSeparatorForRows:(NSArray<UIView *> *)rows;
- (void)showSeparatorForRow:(UIView *)row;
- (void)showSeparatorForRows:(NSArray<UIView *> *)rows;
@property (nonatomic, assign) BOOL automaticallyHidesLastSeparator; // default is NO

// modify the scroll position
- (void)scrollRowToVisible:(UIView *)row animated:(BOOL)animated;

// extend aloeStackView
- (StackViewCell *)cellForRow:(UIView *)row;
- (void)configCell:(StackViewCell *)cell;

@end

NS_ASSUME_NONNULL_END
