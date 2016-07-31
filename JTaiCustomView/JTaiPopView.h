//
//  JTaiPopView.h
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/12.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define Kheight [UIScreen mainScreen].bounds.size.height

@class JTaiPopView;

// 协议
@protocol JTaiPopViewDelegate <NSObject>

@optional

- (void)popView:(JTaiPopView *)popView didSelectRowAtIndex:(NSInteger)index;

@end


@interface JTaiPopView : UIView

// 数据源
@property (nonatomic,strong) NSArray  <NSString *>  *dataSource;

// 代理
@property (nonatomic) id    <JTaiPopViewDelegate> delegate;

// 实例化方法
+ (instancetype)popViewWith:(NSArray <NSString *> *)dataSource;

- (void)showInView:(UIView *)view;

@end




typedef enum {

    PopViewCellStyleDefault = 1,
    PopViewCellStyleSelect  = 2,

} PopViewCellStyle ;

@interface JTaiPopViewCell : UITableViewCell

// 状态 <选中\非选中>
@property (nonatomic,assign) PopViewCellStyle  type;

// 标题
@property (nonatomic,copy) NSString *title;

// 代理
@property (nonatomic) id <JTaiPopViewDelegate> delegate;

@end