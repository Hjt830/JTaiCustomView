//
//  ViewController.m
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/6.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import "ViewController.h"
#import "JTaiCombineView.h"
#import "JTaiGetTelCodeView.h"
#import "JTaiPopView.h"

@interface ViewController () <JTaiCombineViewDelegate,JTaiGetTelCodeViewDelegate>
{
    JTaiPopView *_popView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:230 green:230 blue:230 alpha:0.8];
    
    NSArray *array = @[@"combineView",@"getTelCodeView",@"popView"];
    
    for (int i = 0 ; i < array.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        btn.frame = CGRectMake((Kwidth - 160)/2, 200+60*i, 160, 44);
        [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:21];
        [self.view addSubview:btn];
        
        if (i == 0) {
            [btn addTarget:self action:@selector(showCombineView) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 1) {
            [btn addTarget:self action:@selector(showTelCodeView) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (i == 2) {
            [btn addTarget:self action:@selector(showPopView) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}

- (void)showCombineView
{
    JTaiCombineView *view = [[JTaiCombineView alloc] initWithFrame:self.view.frame];
    view.title = @"个人信息";
    view.buttonTitle = @"提交";
    view.dataSource = @[@"姓名",@"性别",@"地址"];
    view.delegate = self;
    [view showInView:self.view];
}

- (void)showTelCodeView
{
    JTaiGetTelCodeView *telCodeView = [[JTaiGetTelCodeView alloc] initWithFrame:self.view.frame];
    telCodeView.delegate = self;
    [telCodeView showInView:self.view animated:YES];
}

- (void)showPopView
{
    if (!_popView) {
        _popView = [JTaiPopView popViewWith:@[@"销量",@"价格",@"人气"]];
        [_popView showInView:self.view];
    }
    else {
        [_popView showInView:self.view];
    }
}

#pragma mark - ======================= JTaiCombineViewDelegate =======================

- (void)combineView:(JTaiCombineView *)combineView didSelectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld行",index);
}

- (void)combineViewDidSelectButton
{
    NSLog(@"提交");
}

#pragma mark - ======================= JTaiGetTelCodeViewDelegate =======================

- (void)GetTelCodeView:(JTaiGetTelCodeView *)codeView didSelectButtonAtIndex:(NSInteger)index
{
    NSString *str = nil;
    if (index == 0) str = @"确定";
    else str = @"取消";
    
    NSLog(@"%@",str);
}

- (void)GetTelCodeViewDidSelectGetCode
{
    NSLog(@"获取验证码");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
