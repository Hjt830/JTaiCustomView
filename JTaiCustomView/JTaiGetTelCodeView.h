//
//  JTaiGetTelCodeView.h
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/8.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define Kheight [UIScreen mainScreen].bounds.size.height

#import <UIKit/UIKit.h>

@class JTaiGetTelCodeView;

@protocol JTaiGetTelCodeViewDelegate <NSObject>

@optional

/**
 *  点击获取验证码
 */
- (void)GetTelCodeViewDidSelectGetCode;

/**
 *  点击取消或者确定按钮
 */
- (void)GetTelCodeView:(JTaiGetTelCodeView *)codeView didSelectButtonAtIndex:(NSInteger)index;

@end

@interface JTaiGetTelCodeView : UIView

@property (nonatomic,assign) NSUInteger time;

@property (nonatomic) id <JTaiGetTelCodeViewDelegate> delegate;

- (void)showInView:(UIView *)view animated:(BOOL)animated;

- (void)dismissWithAnimated:(BOOL)animated;

@end


@interface JTaiTextFeild : UITextField

@end