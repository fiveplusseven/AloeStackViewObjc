//
//  ViewController.m
//  Demo
//
//  Created by zl on 2019/9/27.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "ViewController.h"
#import "UserRow.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)setupHeaderRow {
    YWUserMsgAvatarRow *headRow = [YWUserMsgAvatarRow new];
    headRow.backgroundColor = [UIColor whiteColor];
    [self.stackView addRow:headRow animated:NO];
    [self.stackView setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1.0] forRow:headRow];
    [self.stackView hideSeparatorForRow:headRow];
    [self.stackView setInset:UIEdgeInsetsMake(8, 0, 8, 0) forRow:headRow];
}

- (void)setupNameRow {

    YWUserMsgClickRow *nameRow = [[YWUserMsgClickRow alloc] initWithName:@"孩子昵称" desc:@"xxx"];
    [self.stackView addRow:nameRow animated:NO];
}

- (void)setupNoRow {
    YWUserMsgReadonlyRow *noRow = [[YWUserMsgReadonlyRow alloc] initWithName:@"学号" desc:@"123456"];
    [self.stackView addRow:noRow animated:NO];
}

- (void)setupCityRow {
    YWUserMsgClickRow *cityRow = [[YWUserMsgClickRow alloc] initWithName:@"城市" desc:@"xxxx"];
    [self.stackView addRow:cityRow animated:NO];

    [self.stackView setTapHandlerForRow:cityRow handler:^(UIView * _Nonnull view) {
        [view becomeFirstResponder];
    }];
}

- (void)setupGradeRow {
    YWUserMsgClickRow *gradeRow = [[YWUserMsgClickRow alloc] initWithName:@"在读年级" desc:@"xxx"];
    [self.stackView addRow:gradeRow animated:NO];

    [self.stackView setTapHandlerForRow:gradeRow handler:^(UIView * _Nonnull view) {
        [view becomeFirstResponder];
    }];
}

- (void)setupRows {
    self.stackView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1.0];
    self.stackView.alwaysBounceVertical = YES;
    self.stackView.rowInset = UIEdgeInsetsZero;
    [self.stackView setRowBackgroundColor:[UIColor whiteColor]];
    self.stackView.automaticallyHidesLastSeparator = YES;

    [self setupHeaderRow];
    [self setupNameRow];
    [self setupNoRow];
    [self setupCityRow];
    [self setupGradeRow];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupRows];
}


@end
