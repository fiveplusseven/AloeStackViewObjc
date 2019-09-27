//
//  UserRow.h
//  Demo
//
//  Created by zl on 2019/9/27.
//  Copyright © 2019 longjianjiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YWUserMsgAvatarRow : UIView

@end

@interface YWUserMsgClickRow : UIView

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc;

@end

@interface YWUserMsgReadonlyRow : UIView

- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc;

@end

@interface YWUserMsgTextfieldRow : UIView

@property (nonatomic, copy, readonly) NSString *str;

- (instancetype)initWithName:(NSString *)name placeholder:(NSString *)placeholder;

@end

NS_ASSUME_NONNULL_END
