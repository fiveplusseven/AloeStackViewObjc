//
//  UserRow.m
//  Demo
//
//  Created by zl on 2019/9/27.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "UserRow.h"
#import <Masonry/Masonry.h>
#import "UserAccessoryView.h"

#pragma mark - YWUserMsgAvatarRow
@interface YWUserMsgAvatarRow ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation YWUserMsgAvatarRow

#pragma mark - life cycle
- (void)setupSubview {
    [self addSubview:self.imgView];
    [self addSubview:self.descLabel];
    [self addSubview:self.iconView];
}

- (void)addSomeConstraints {
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
        make.leading.equalTo(self).offset(20);
        make.height.width.mas_equalTo(56);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-20);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(12);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.iconView.mas_leading).offset(-16);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - getter and setter
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [UIImageView new];
        _imgView.backgroundColor = [UIColor orangeColor];
        _imgView.layer.cornerRadius = 28;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}
- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [UILabel new];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.textColor = [UIColor orangeColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.text = @"修改孩子头像";
    }
    return _descLabel;
}
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"me_msg_right_row_icon"];
    }
    return _iconView;
}
@end

#pragma mark - YWUserMsgClickRow

@interface YWUserMsgClickRow ()<UIPickerViewDelegate, UIPickerViewDataSource>

// row
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *iconView;

// init
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;

// picker
@property (nonatomic, strong) NSArray *gradeDataSource;

@end

@implementation YWUserMsgClickRow

#pragma mark - input view
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canResignFirstResponder {
    return YES;
}
- (UIView *)inputAccessoryView {
    return [UserAccessoryView new];
}

- (UIView *)inputView {
    UIPickerView *picker = [UIPickerView new];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self;
    picker.dataSource = self;
    return picker;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.gradeDataSource.count;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.gradeDataSource[row];
}

#pragma mark - life cycle
- (void)setupSubview {
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.iconView];
}

- (void)addSomeConstraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
        make.leading.equalTo(self).offset(20);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-20);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(12);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.iconView.mas_leading).offset(-16);
    }];
}

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc {
    self = [super init];
    if (self) {
        self.name = name; self.desc = desc;
        [self setupSubview];
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - getter and setter
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = self.name;
    }
    return _nameLabel;
}
- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [UILabel new];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.textColor = [UIColor orangeColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.text = self.desc;
    }
    return _descLabel;
}
- (UIImageView *)iconView {
    if (_iconView == nil) {
        _iconView = [UIImageView new];
        _iconView.image = [UIImage imageNamed:@"me_msg_right_row_icon"];
    }
    return _iconView;
}
- (NSArray *)gradeDataSource {
    if (_gradeDataSource == nil) {
        _gradeDataSource = @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级", @"小班", @"中班", @"大班", @"其他"];
    }
    return _gradeDataSource;
}

@end

#pragma mark - YWUserMsgReadonlyRow

@interface YWUserMsgReadonlyRow ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;

@end

@implementation YWUserMsgReadonlyRow

#pragma mark - life cycle
- (void)setupSubview {
    [self addSubview:self.nameLabel];
    [self addSubview:self.descLabel];
}

- (void)addSomeConstraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
        make.leading.equalTo(self).offset(20);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).offset(-20);
    }];
}

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc {
    self = [super init];
    if (self) {
        self.name = name; self.desc = desc;
        [self setupSubview];
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - getter and setter
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = self.name;
    }
    return _nameLabel;
}
- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [UILabel new];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.text = self.desc;
    }
    return _descLabel;
}
@end

#pragma mark - YWUserMsgTextfieldRow

@interface YWUserMsgTextfieldRow ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *placeholder;
@end

@implementation YWUserMsgTextfieldRow

#pragma mark - life cycle
- (void)setupSubview {
    [self addSubview:self.nameLabel];
    [self addSubview:self.textField];
}

- (void)addSomeConstraints {
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-16);
        make.leading.equalTo(self).offset(20);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self.nameLabel.mas_trailing).offset(20);
    }];
}

- (instancetype)initWithName:(NSString *)name placeholder:(nonnull NSString *)placeholder {
    self = [super init];
    if (self) {
        self.name = name; self.placeholder = placeholder;
        [self setupSubview];
        [self addSomeConstraints];
    }
    return self;
}

#pragma mark - getter and setter
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = self.name;
    }
    return _nameLabel;
}
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [UITextField new];
        _textField.font = [UIFont systemFontOfSize:16];
        _textField.textColor = [UIColor blackColor];
        _textField.placeholder = self.placeholder;
    }
    return _textField;
}
- (NSString *)str {
    return self.textField.text;
}
@end

