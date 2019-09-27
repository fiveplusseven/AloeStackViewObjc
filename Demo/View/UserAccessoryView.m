//
//  UserAccessoryView.m
//  Demo
//
//  Created by zl on 2019/9/27.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "UserAccessoryView.h"
#import <Masonry/Masonry.h>

@interface UserAccessoryView ()

@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *doneBtn;

@end

@implementation UserAccessoryView

#pragma mark - life cycle
- (void)setupSubview {
    [self addSubview:self.cancelBtn];
    [self addSubview:self.doneBtn];
}

- (void)addSomeConstraints {
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(6);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(44);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-6);
        make.top.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    self = [super initWithFrame:rect];
    self.backgroundColor = [UIColor whiteColor];
    if (self) {
        [self setupSubview];
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - response methods
- (void)didCancel {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)didDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

#pragma mark - getter and setter
- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(didCancel) forControlEvents:UIControlEventTouchDown];
    }
    return _cancelBtn;
}
- (UIButton *)doneBtn {
    if (_doneBtn == nil) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(didDone) forControlEvents:UIControlEventTouchDown];
    }
    return _doneBtn;
}

@end
