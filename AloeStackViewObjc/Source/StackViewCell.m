//
//  StackViewCell.m
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "StackViewCell.h"
#import "SeparatorView.h"
#import "Tappable.h"
#import "Highlightable.h"

@interface StackViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) SeparatorView *separatorView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) NSLayoutConstraint *separatorTopConstraint;
@property (nonatomic, strong) NSLayoutConstraint *separatorBottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint *separatorLeadingConstraint;
@property (nonatomic, strong) NSLayoutConstraint *separatorTrailingConstraint;

@end

@implementation StackViewCell

#pragma mark - life cycle
- (void)setupProperty {
    self.rowHighlightColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1.0];
    self.rowBackgroundColor = [UIColor clearColor];
    self.separatorAxis = UILayoutConstraintAxisHorizontal;
}

- (void)setupSubview {
    self.clipsToBounds = YES;

    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.contentView];

    [self addSubview:self.separatorView];
}

- (void)addSomeConstraints {
    NSLayoutConstraint *cbc = [self.contentView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor];
    cbc.priority = UILayoutPriorityRequired-1;
    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor],
        cbc,
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.trailingAnchor]]
    ];

    self.separatorTopConstraint = [self.separatorView.topAnchor constraintEqualToAnchor:self.topAnchor];
    self.separatorBottomConstraint = [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    self.separatorLeadingConstraint = [self.separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    self.separatorTrailingConstraint = [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];

    [self updateSeparatorAxisConstraints];
}

- (void)updateTapGestureRecognizerEnabled {
    self.tapGestureRecognizer.enabled = self.tapHandler || [self.contentView conformsToProtocol:@protocol(Tappable)];
}

- (void)updateSeparatorAxisConstraints {
    self.separatorTopConstraint.active = self.separatorAxis == UILayoutConstraintAxisVertical;
    self.separatorBottomConstraint.active = YES;
    self.separatorLeadingConstraint.active = self.separatorAxis == UILayoutConstraintAxisHorizontal;
    self.separatorTrailingConstraint.active = YES;
}

- (void)updateSeparatorInset {
    self.separatorTopConstraint.constant = self.separatorInset.top;
    self.separatorBottomConstraint.constant = self.separatorAxis == UILayoutConstraintAxisHorizontal ? 0 : -self.separatorInset.bottom;
    self.separatorLeadingConstraint.constant = self.separatorInset.left;
    self.separatorTrailingConstraint.constant = self.separatorAxis == UILayoutConstraintAxisVertical ? 0 : -self.separatorInset.right;
}

- (instancetype)initWithContentView:(UIView *)contentView {
    self = [super init];
    if (self) {
        self.contentView = contentView;

        self.translatesAutoresizingMaskIntoConstraints = NO;
        if (@available(iOS 11.0, *)) {
            self.insetsLayoutMarginsFromSafeArea = NO;
        }

        [self setupProperty];
        [self setupSubview];
        [self addSomeConstraints];
        [self updateTapGestureRecognizerEnabled];
    }
    return self;
}

#pragma mark - touch methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (!self.contentView.isUserInteractionEnabled) { return; }

    if ([self.contentView isHighlightable]) {
        [self.contentView setIsHighlighted:YES];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (!self.contentView.isUserInteractionEnabled) { return; }

    UITouch *touch = [touches anyObject];
    if (!touch) { return; }

    CGPoint point = [touch locationInView:self];
    if ([self.contentView isHighlightable]) {
        BOOL isPointInsidedCell = [self pointInside:point withEvent:event];
        [self.contentView setIsHighlighted:isPointInsidedCell];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (!self.contentView.isUserInteractionEnabled) { return; }

    if ([self.contentView isHighlightable]) {
        [self.contentView setIsHighlighted:NO];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (!self.contentView.isUserInteractionEnabled) { return; }

    if ([self.contentView isHighlightable]) {
        [self.contentView setIsHighlighted:NO];
    }
}

#pragma mark - response method
- (void)handleTap:(UITapGestureRecognizer *)gesture {
    if (!self.contentView.isUserInteractionEnabled) {
        return;
    }
    if ([self.contentView respondsToSelector:@selector(didTapView)]) {
        [self.contentView performSelector:@selector(didTapView) withObject:nil];
    }
    if (self.tapHandler) {
        self.tapHandler(self.contentView);
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *view = gestureRecognizer.view;
    if (!view) {
        return NO;
    }

    CGPoint loction = [touch locationInView:view];
    UIView *hitView = [view hitTest:loction withEvent:nil];

    while (hitView && hitView != view) {
        if ([hitView isKindOfClass:[UIControl class]]) {
            return NO;
        }
        hitView = hitView.superview;
    }
    return YES;
}

#pragma mark - getter and setter
- (UITapGestureRecognizer *)tapGestureRecognizer {
    if (_tapGestureRecognizer == nil) {
        _tapGestureRecognizer = [UITapGestureRecognizer new];
        _tapGestureRecognizer.delegate = self;
        [_tapGestureRecognizer addTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
    return _tapGestureRecognizer;
}

- (SeparatorView *)separatorView {
    if (_separatorView == nil) {
        _separatorView = [SeparatorView new];
    }
    return _separatorView;
}

- (void)setTapHandler:(TapHandler)tapHandler {
    _tapHandler = tapHandler;
    [self updateTapGestureRecognizerEnabled];
}

- (void)setHidden:(BOOL)hidden {
    if (super.hidden == hidden) {
        return;
    }
    super.hidden = hidden;
    self.separatorView.alpha = hidden ? 0 : 1;
}

- (void)setRowBackgroundColor:(UIColor *)rowBackgroundColor {
    _rowBackgroundColor = rowBackgroundColor;
    self.backgroundColor = rowBackgroundColor;
}

- (UIEdgeInsets)rowInset {
    return self.layoutMargins;
}

- (void)setRowInset:(UIEdgeInsets)rowInset {
    self.layoutMargins = rowInset;
}

- (void)setSeparatorAxis:(UILayoutConstraintAxis)separatorAxis {
    _separatorAxis = separatorAxis;
    [self updateSeparatorAxisConstraints];
    [self updateSeparatorInset];
}

- (UIColor *)separatorColor {
    return self.separatorView.color;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    self.separatorView.color = separatorColor;
}

- (CGFloat)separatorHeight {
    return self.separatorView.width;
}

- (void)setSeparatorHeight:(CGFloat)separatorHeight {
    self.separatorView.width = separatorHeight;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
    _separatorInset = separatorInset;
    [self updateSeparatorInset];
}

- (BOOL)isSeparatorHidden {
    return self.separatorView.isHidden;
}

- (void)setSeparatorHidden:(BOOL)separatorHidden {
    self.separatorView.hidden = separatorHidden;
}
@end
