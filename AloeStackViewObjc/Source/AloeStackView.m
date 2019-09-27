//
//  AloeStackView.m
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "AloeStackView.h"

@interface AloeStackView ()

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSLayoutConstraint *stackViewAxisConstraint;
@end

@implementation AloeStackView

#pragma mark - add and remove
- (void)addRow:(UIView *)row animated:(BOOL)animated {
    [self insertCellWithContentView:row atIndex:self.stackView.arrangedSubviews.count animated:animated];
}

- (void)addRows:(NSArray<UIView *> *)rows animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self addRow:item animated:animated];
    }
}

- (void)prependRow:(UIView *)row animated:(BOOL)animated {
    [self insertCellWithContentView:row atIndex:0 animated:animated];
}

- (void)prependRows:(NSArray<UIView *> *)rows animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self prependRow:item animated:animated];
    }
}

- (void)insertRow:(UIView *)row beforeRow:(UIView *)beforeRow animated:(BOOL)animated {
    if (![beforeRow.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)(beforeRow.superview);
    NSUInteger idx = [self.stackView.arrangedSubviews indexOfObject:cell];
    if (idx == NSNotFound) { return; }

    [self insertCellWithContentView:row atIndex:idx animated:animated];
}

- (void)insertRows:(NSArray<UIView *> *)rows beforeRow:(UIView *)beforeRow animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self insertRow:item beforeRow:beforeRow animated:animated];
    }
}

- (void)insertRow:(UIView *)row afterRow:(UIView *)afterRow animated:(BOOL)animated {
    if (![afterRow.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)(afterRow.superview);
    NSUInteger idx = [self.stackView.arrangedSubviews indexOfObject:cell];
    if (idx == NSNotFound) { return; }

    [self insertCellWithContentView:row atIndex:idx+1 animated:animated];
}

- (void)insertRows:(NSArray<UIView *> *)rows afterRow:(UIView *)afterRow animated:(BOOL)animated {
    UIView *currentAfterRow = afterRow;
    for (UIView *item in rows) {
        [self insertRow:item afterRow:currentAfterRow animated:animated];
        currentAfterRow = item;
    }
}

- (void)removeRow:(UIView *)row animated:(BOOL)animated {
    if ([row.superview isKindOfClass:[StackViewCell class]]) {
        StackViewCell *cell = (StackViewCell *)(row.superview);
        [self removeCell:cell animated:animated];
    }
}

- (void)removeRows:(NSArray<UIView *> *)rows animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self removeRow:item animated:animated];
    }
}

- (void)removeAllRowsAnimated:(BOOL)animated {
    for (UIView *item in self.stackView.arrangedSubviews) {
        StackViewCell *cell = (StackViewCell *)item;
        [self removeCell:cell animated:animated];
    }
}

#pragma mark - access rows
- (UIView *)firstRow {
    UIView *first = [self.stackView.arrangedSubviews firstObject];
    if (!first) { return nil; }
    StackViewCell *cell = (StackViewCell *)first;
    return cell.contentView;
}

- (UIView *)lastRow {
    UIView *last = [self.stackView.arrangedSubviews lastObject];
    if (!last) { return nil; }
    StackViewCell *cell = (StackViewCell *)last;
    return cell.contentView;
}

- (NSArray<UIView *> *)getAllRows {
    NSMutableArray<UIView *> *arr = [NSMutableArray array];
    for (UIView *item in self.stackView.arrangedSubviews) {
        StackViewCell *cell = (StackViewCell *)item;
        [arr addObject:cell.contentView];
    }

    return [arr copy];
}

- (BOOL)containsRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return NO; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    return [self.stackView.arrangedSubviews containsObject:cell];
}

#pragma mark - hide and show rows
- (void)hideRow:(UIView *)row animated:(BOOL)animated {
    [self setRow:row isHidden:YES animated:animated];
}

- (void)hideRows:(NSArray<UIView *> *)rows animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self hideRow:item animated:animated];
    }
}

- (void)showRow:(UIView *)row animated:(BOOL)animated {
    [self setRow:row isHidden:NO animated:animated];
}

- (void)showRows:(NSArray<UIView *> *)rows animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self showRow:item animated:animated];
    }
}

- (void)setRow:(UIView *)row isHidden:(BOOL)isHidden animated:(BOOL)animated {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    if (cell.isHidden == isHidden) { return; }

    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.hidden = isHidden;
            [cell layoutIfNeeded];
        }];
    } else {
        cell.hidden = isHidden;
    }
}

- (void)setRows:(NSArray<UIView *> *)rows isHidden:(BOOL)isHidden animated:(BOOL)animated {
    for (UIView *item in rows) {
        [self setRow:item isHidden:isHidden animated:animated];
    }
}

- (BOOL)isRowHidden:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return NO; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    return cell.isHidden;
}

#pragma mark - user action
- (void)setTapHandlerForRow:(UIView *)row handler:(TapHandler)handler {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;

    if (handler) {
        cell.tapHandler = ^(UIView * _Nonnull view) {
            handler(view);
        };
    } else {
        cell.tapHandler = nil;
    }
}

#pragma mark - style rows
- (void)setBackgroundColor:(UIColor *)color forRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    cell.rowBackgroundColor = color;
}

- (void)setBackgroundColor:(UIColor *)color forRows:(NSArray<UIView *> *)rows {
    for (UIView *item in rows) {
        [self setBackgroundColor:color forRow:item];
    }
}

- (void)setInset:(UIEdgeInsets)inset forRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    cell.rowInset = inset;
}

- (void)setInset:(UIEdgeInsets)inset forRows:(NSArray<UIView *> *)rows {
    for (UIView *item in rows) {
        [self setInset:inset forRow:item];
    }
}

#pragma mark - style separtors
- (void)setSeparatorInset:(UIEdgeInsets)separatorInset forRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    cell.separatorInset = separatorInset;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset forRows:(NSArray<UIView *> *)rows {
    for (UIView *item in rows) {
        [self setSeparatorInset:separatorInset forRow:item];
    }
}

#pragma mark - hide and show separtors
- (void)hideSeparatorForRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    cell.shouldHideSeparator = YES;
    [self updateSeparatorVisibilityForCell:cell];
}

- (void)hideSeparatorForRows:(NSArray<UIView *> *)rows {
    for (UIView *item in rows) {
        [self hideSeparatorForRow:item];
    }
}

- (void)showSeparatorForRow:(UIView *)row {
    if (![row.superview isKindOfClass:[StackViewCell class]]) { return; }
    StackViewCell *cell = (StackViewCell *)row.superview;
    cell.shouldHideSeparator = NO;
    [self updateSeparatorVisibilityForCell:cell];
}

- (void)showSeparatorForRows:(NSArray<UIView *> *)rows {
    for (UIView *item in rows) {
        [self showSeparatorForRow:item];
    }
}

#pragma mark - modify the scroll position
- (void)scrollRowToVisible:(UIView *)row animated:(BOOL)animated {
    if (!row.superview) { return; }
    CGRect rect = [self convertRect:row.frame fromView:row.superview];
    [self scrollRectToVisible:rect animated:animated];
}

#pragma mark - extend aloeStackView
- (StackViewCell *)cellForRow:(UIView *)row {
    return [[StackViewCell alloc] initWithContentView:row];
}

- (void)configCell:(StackViewCell *)cell {}

#pragma mark - life cycle
- (void)setupProperty {
    UIEdgeInsets defaultSeparatorInset = [UITableView new].separatorInset;
    UIColor *defaultSeparatorColor = [UITableView new].separatorColor ?: [UIColor clearColor];

    self.rowBackgroundColor = [UIColor clearColor];
    self.rowHighlightColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    self.rowInset = UIEdgeInsetsMake(12, defaultSeparatorInset.left, 12, defaultSeparatorInset.left);
    self.separatorColor = defaultSeparatorColor;
    self.separatorHeight = 1 / [UIScreen mainScreen].scale;
    self.separatorInset = defaultSeparatorInset;
}

- (void)setupStackView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.stackView];
}

- (void)addSomeConstraints {
    [self setUpStackViewConstraints];
    [self updateStackViewAxisConstraint];
}

- (void)setUpStackViewConstraints {
    NSArray *constraints = @[[self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
                             [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                             [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                             [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor]];
    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)updateStackViewAxisConstraint {
    self.stackViewAxisConstraint.active = NO;
    if (self.stackView.axis == UILayoutConstraintAxisVertical) {
        self.stackViewAxisConstraint = [self.stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor];
    } else {
        self.stackViewAxisConstraint = [self.stackView.heightAnchor constraintEqualToAnchor:self.heightAnchor];
    }
    self.stackViewAxisConstraint.active = YES;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupProperty];
        [self setupStackView];
        [self addSomeConstraints];
    }
    return self;
}

- (StackViewCell *)createCellWithContentView:(UIView *)contentView {
    StackViewCell *cell = [self cellForRow:contentView];

    cell.rowBackgroundColor = self.rowBackgroundColor;
    cell.rowHighlightColor = self.rowHighlightColor;
    cell.rowInset = self.rowInset;
    cell.separatorAxis = self.axis == UILayoutConstraintAxisHorizontal ? UILayoutConstraintAxisVertical : UILayoutConstraintAxisHorizontal;
    cell.separatorColor = self.separatorColor;
    cell.separatorHeight = self.separatorHeight;
    cell.separatorInset = self.separatorInset;
    cell.shouldHideSeparator = self.hidesSeparatorsByDefault;

    [self configCell:cell];
    return cell;
}

- (void)insertCellWithContentView:(UIView *)contentView atIndex:(NSUInteger)idx animated:(BOOL)animated {
    if ([self containsRow:contentView]) {
        StackViewCell *cellToRemove = (StackViewCell *)contentView.superview;
        [self removeRow:cellToRemove animated:NO];
    }

    StackViewCell *cell = [self createCellWithContentView:contentView];
    [self.stackView insertArrangedSubview:cell atIndex:idx];

    [self updateSeparatorVisibilityForCell:cell];
    [self updateSeparatorVisibilityForCell:[self cellAbove:cell]];

    if (animated) {
        cell.alpha = 0;
        [self layoutIfNeeded];
        [UIView animateWithDuration:0.3 animations:^{
            cell.alpha = 1;
        }];
    }
}

- (void)removeCell:(StackViewCell *)cell animated:(BOOL)animated {
    StackViewCell *aboveCell = [self cellAbove:cell];

    void (^completion)(BOOL) = ^(BOOL finished) {
        [cell removeFromSuperview];
        if (aboveCell) {
            [self updateSeparatorVisibilityForCell:aboveCell];
        }
    };

    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            cell.hidden = YES;
        } completion:completion];
    } else {
        completion(YES);
    }
}

- (void)updateSeparatorVisibilityForCell:(StackViewCell *)cell {
    BOOL isLastCellAndHidingIsEnabled = self.automaticallyHidesLastSeparator && (cell == self.stackView.arrangedSubviews.lastObject);

    cell.separatorHidden = isLastCellAndHidingIsEnabled || cell.shouldHideSeparator;
}

- (nullable StackViewCell *)cellAbove:(StackViewCell *)cell {
    NSUInteger idx = [self.stackView.arrangedSubviews indexOfObject:cell];
    if (idx == NSNotFound) { return nil; }
    if (idx > 0) {
        return (StackViewCell *)(self.stackView.arrangedSubviews[idx-1]);
    }
    return nil;
}

#pragma mark - getter and setter
- (UIStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [UIStackView new];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.axis = UILayoutConstraintAxisVertical;
    }
    return _stackView;
}

- (UILayoutConstraintAxis)axis {
    return self.stackView.axis;
}

- (void)setAxis:(UILayoutConstraintAxis)axis {
    self.stackView.axis = axis;
    [self updateStackViewAxisConstraint];
    for (UIView *item in self.stackView.arrangedSubviews) {
        StackViewCell *cell = (StackViewCell *)item;
        cell.separatorAxis = axis == UILayoutConstraintAxisHorizontal ? UILayoutConstraintAxisVertical : UILayoutConstraintAxisHorizontal;
    }
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    for (UIView *item in self.stackView.arrangedSubviews) {
        StackViewCell *cell = (StackViewCell *)item;
        cell.separatorColor = separatorColor;
    }
}

- (void)setSeparatorHeight:(CGFloat)separatorHeight {
    _separatorHeight = separatorHeight;
    for (UIView *item in self.stackView.arrangedSubviews) {
        StackViewCell *cell = (StackViewCell *)item;
        cell.separatorHeight = separatorHeight;
    }
}

- (void)setAutomaticallyHidesLastSeparator:(BOOL)automaticallyHidesLastSeparator {
    _automaticallyHidesLastSeparator = automaticallyHidesLastSeparator;
    if (self.stackView.arrangedSubviews.lastObject) {
        StackViewCell *cell = (StackViewCell *)self.stackView.arrangedSubviews.lastObject;
        [self updateSeparatorVisibilityForCell:cell];
    }
}
@end
