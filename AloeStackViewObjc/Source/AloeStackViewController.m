//
//  AloeStackViewController.m
//  AloeStackViewObjc
//
//  Created by zl on 2019/9/24.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import "AloeStackViewController.h"

@interface AloeStackViewController ()

@end

@implementation AloeStackViewController

- (void)loadView {
    self.view = self.stackView;
}

#pragma mark - getter and setter
- (AloeStackView *)stackView {
    if (_stackView == nil) {
        _stackView = [AloeStackView new];
    }
    return _stackView;
}
@end
