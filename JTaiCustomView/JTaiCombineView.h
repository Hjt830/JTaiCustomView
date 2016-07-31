//
//  JTaiCombineView.h
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/6.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define Kheight [UIScreen mainScreen].bounds.size.height

@class JTaiCombineView;

@protocol JTaiCombineViewDelegate <NSObject>

@optional

- (void)combineView:(JTaiCombineView *)combineView didSelectRowAtIndex:(NSInteger)index;

- (void)combineViewDidSelectButton;

@end

@interface JTaiCombineView : UIView

// 标题
@property (nonatomic,copy) NSString     *title;

// 数据源
@property (nonatomic,strong) NSArray <NSString *> *dataSource;

// 按钮标题
@property (nonatomic,strong) NSString   *buttonTitle;

// 代理
@property (nonatomic) id <JTaiCombineViewDelegate> delegate;


- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
