//
//  JTaiGetTelCodeView.m
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/8.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import "JTaiGetTelCodeView.h"

@interface JTaiGetTelCodeView ()
{
    //
    UIView      *_contentView;
    // 手机号码输入框
    JTaiTextFeild *_telphoneTF;
    // 验证码输入框
    JTaiTextFeild *_telCodeTF;
    // 获取验证码
    UIButton    *_getCodeBtn;
    // 提交
    UIButton    *_submitBtn;
    // 取消
    UIButton    *_cancelBtn;
    // 分割线
    UIView      *_topLine;
    UIView      *_botLine;
    UIView      *_midLine;
    UIView      *_HLine;
    UIView      *_VLine;
    // 倒计时
    UILabel     *_timeLa;
}
@property (nonatomic,strong) NSTimer    *timer;

@end

@implementation JTaiGetTelCodeView

#warning 缺少正则表达式  监听输入  键盘的升降 代理方法

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        if (!_contentView) {
            
            _contentView = [[UIView alloc] initWithFrame:CGRectMake((Kwidth-280)/2, (Kheight-150)/2, 280, 150)];
            _contentView.clipsToBounds = YES;
            _contentView.layer.cornerRadius = 10.0f;
            _contentView.backgroundColor = [UIColor whiteColor];
            [self addSubview:_contentView];
        }
        if (!_telphoneTF) {
            
            _telphoneTF = [[JTaiTextFeild alloc] initWithFrame:CGRectMake(10, 8, 260, 44)];
            _telphoneTF.placeholder = @"请输入手机号码";
            [_contentView addSubview:_telphoneTF];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(telphoneDidChange) name:UITextFieldTextDidChangeNotification object:_telphoneTF];
            
            UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
            tel.text = @"手机号码";
            tel.textAlignment = NSTextAlignmentRight;
            tel.font = [UIFont systemFontOfSize:17];
            _telphoneTF.leftView = tel;
        }
        if (!_telCodeTF) {
            
            _telCodeTF = [[JTaiTextFeild alloc] initWithFrame:CGRectMake(10, 52, 180, 44)];
            _telCodeTF.placeholder = @"验证码";
            [_contentView addSubview:_telCodeTF];
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(telCodeDidChange) name:UITextFieldTextDidChangeNotification object:_telCodeTF];
            
            UILabel *code = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
            code.text = @"验证码";
            code.textAlignment = NSTextAlignmentRight;
            code.font = [UIFont systemFontOfSize:17];
            _telCodeTF.leftView = code;
        }
        if (!_topLine) {
            _topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 52, 270, 1)];
            _topLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            [_contentView addSubview:_topLine];
        }
        if (!_botLine) {
            _botLine = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 270, 1)];
            _botLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            [_contentView addSubview:_botLine];
        }
        if (!_midLine) {
            _midLine = [[UIView alloc] initWithFrame:CGRectMake(190, 52, 1, 43)];
            _midLine.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            [_contentView addSubview:_midLine];
        }
        if (!_getCodeBtn) {
            _getCodeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            _getCodeBtn.backgroundColor = [UIColor redColor];
            [_getCodeBtn addTarget:self action:@selector(getTelCode:) forControlEvents:UIControlEventTouchUpInside];
            _getCodeBtn.enabled = NO;
            [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_getCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
            [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _getCodeBtn.frame = CGRectMake(190, 52, 90, 44);
            [_contentView addSubview:_getCodeBtn];
        }
        if (!_timeLa) {
            _timeLa = [[UILabel alloc] initWithFrame:CGRectMake(190, 52, 90, 44)];
            _timeLa.hidden = YES;
            _timeLa.textAlignment = NSTextAlignmentCenter;
            _timeLa.font = [UIFont systemFontOfSize:10];
            [_contentView addSubview:_timeLa];
        }
        if (!_submitBtn) {
            _submitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
            _submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [_submitBtn setTitle:@"确 定" forState:UIControlStateNormal];
            [_submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_submitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
            _submitBtn.frame = CGRectMake(0, 150-44, 140, 44);
            _submitBtn.enabled = NO;
            [_contentView addSubview:_submitBtn];
        }
        if (!_cancelBtn) {
            _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
            _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
            [_cancelBtn setTitle:@"取 消" forState:UIControlStateNormal];
            [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _cancelBtn.frame = CGRectMake(_submitBtn.frame.size.width, 150-44, 140, 44);
            [_contentView addSubview:_cancelBtn];
        }
        if (!_HLine) {
            _HLine = [[UIView alloc] initWithFrame:CGRectMake(0, 150-44-0.8, 280, 0.8)];
            _HLine.backgroundColor = [UIColor colorWithRed:20 green:20 blue:20 alpha:1];
            [_contentView addSubview:_HLine];
        }
        if (!_VLine) {
            _VLine = [[UIView alloc] initWithFrame:CGRectMake(140-0.4, 150-44, 0.8, 44)];
            _VLine.backgroundColor = [UIColor colorWithRed:20 green:20 blue:20 alpha:1];
            [_contentView addSubview:_VLine];
        }
    }
    return self;
}

- (void)setTime:(NSUInteger)time
{
    if (time) {
        _time = time;
        
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取",self.time];
        NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%lu",self.time]];
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:str];
        [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        _timeLa.attributedText = mutStr;
    }
}

- (void)getTelCode:(UIButton *)sender
{
    sender.hidden = YES;
    _timeLa.hidden = NO;
    
    if ([self.delegate respondsToSelector:@selector(GetTelCodeViewDidSelectGetCode)]) {
        
        [self.delegate GetTelCodeViewDidSelectGetCode];
    }
    
    if (!self.time) {
        self.time = 60;
    }
    
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)countDown
{
    _time --;
    NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取",_time];
    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%lu",_time]];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:str];
    [mutStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    _timeLa.attributedText = mutStr;
    
    if (_time == 0) {
        [self.timer invalidate];
        self.timer = nil;
        _getCodeBtn.hidden = NO;
        _timeLa.hidden = YES;
    }
}

// 提交
- (void)submit:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(GetTelCodeView:didSelectButtonAtIndex:)]) {
        [self.delegate GetTelCodeView:self didSelectButtonAtIndex:0];
    }
    
    [self dismissWithAnimated:YES];
}

// 取消
- (void)cancel:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(GetTelCodeView:didSelectButtonAtIndex:)]) {
        [self.delegate GetTelCodeView:self didSelectButtonAtIndex:1];
    }
    
    [self dismissWithAnimated:YES];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
}

- (void)telphoneDidChange
{
    if (_telphoneTF.text.length >= 11) {
        _telphoneTF.text = [_telphoneTF.text substringToIndex:11];
    }
    
    BOOL isMatch = [self isTelponeNumber:_telphoneTF.text];
    
    if (isMatch) {
        _getCodeBtn.enabled = YES;
    } else {
        _getCodeBtn.enabled = NO;
    }
}

- (void)telCodeDidChange
{
    if (_telCodeTF.text.length >= 6) {
        _telCodeTF.text = [_telCodeTF.text substringToIndex:6];
    }
    
    if (_getCodeBtn.enabled ==  YES) {
        
        BOOL isMatch = [self isSixNumber:_telCodeTF.text];
        
        if (isMatch) {
            _submitBtn.enabled = YES;
        }
        else {
            _submitBtn.enabled = NO;
        }
    }
    else {
        _submitBtn.enabled = NO;
    }
}

// 是否是电话号码
- (BOOL)isTelponeNumber:(NSString *)telphone
{
    NSString *phoneNum = [NSString stringWithFormat:@"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNum];
   
    BOOL res = [predicate evaluateWithObject:telphone];
 
    return res;
}

// 是否是6位数字
- (BOOL)isSixNumber:(NSString *)number
{
    NSString *num = [NSString stringWithFormat:@"[0-9]{6}"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",num];
    
    BOOL res = [predicate evaluateWithObject:number];
    
    return res;
}

- (void)showInView:(UIView *)view animated:(BOOL)animated
{
    if (!animated) {
        [view addSubview:self];
    }
    else {
        [view addSubview:self];
        _contentView.frame = CGRectMake((Kwidth-280)/2, -150, 280, 150);
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _contentView.frame = CGRectMake((Kwidth-280)/2, (Kheight-150)/2, 280, 150);
        } completion:^(BOOL finished) {
        }];
    }
}

- (void)dismissWithAnimated:(BOOL)animated
{
    if (!animated) {
        [self removeFromSuperview];
    }
    else {
        _contentView.frame = CGRectMake((Kwidth-280)/2, (Kheight-150)/2, 280, 150);
        
        [UIView animateWithDuration:0.25 animations:^{
            
            _contentView.frame = CGRectMake((Kwidth-280)/2, Kheight+150, 280, 150);
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    }
}


@end


@implementation JTaiTextFeild

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.leftViewMode = UITextFieldViewModeAlways;
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
    return self;
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(5, 0, 70, bounds.size.height);
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.frame.size.width-20-5, 0, 20, bounds.size.height);
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.leftView.frame.size.width+15, 0, bounds.size.width - self.leftView.frame.size.width-20, bounds.size.height);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.leftView.frame.size.width+15, 0, bounds.size.width - self.leftView.frame.size.width-20, bounds.size.height-10);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectMake(self.leftView.frame.size.width+15, 0, bounds.size.width - self.leftView.frame.size.width-20, bounds.size.height);
}

@end
