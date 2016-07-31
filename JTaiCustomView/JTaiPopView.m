//
//  JTaiPopView.m
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/12.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import "JTaiPopView.h"

@interface JTaiPopView () <UITableViewDataSource,UITableViewDelegate>
{
    // 表
    UITableView     *_tableView;
    // 遮罩
    UIView          *_coverView;
    // 当前选中的cell
    NSIndexPath     *_selectedIndexPath;
}
@end

@implementation JTaiPopView

// 实例化方法
+ (instancetype)popViewWith:(NSArray <NSString *> *)dataSource
{
    JTaiPopView *popView = [[JTaiPopView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, Kheight)];
    popView.dataSource = dataSource;
    
    return popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        if (!_tableView) {
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44*self.dataSource.count) style:UITableViewStylePlain];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            _tableView.scrollEnabled = NO;
            [self addSubview:_tableView];
        }
        if (!_coverView) {
            _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), self.frame.size.width, Kheight-CGRectGetHeight(_tableView.frame))];
            _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
            [self addSubview:_coverView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
            [_coverView addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource
{
    if (dataSource.count > 0) {
        _dataSource = dataSource;
        [_tableView reloadData];
    }
    
    [self setNeedsLayout];
}

- (void)showInView:(UIView *)view
{
    [_tableView reloadData];
    [view addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark - ======================= UITableViewDataSource =======================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *popCell = @"popCell";
    
    JTaiPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:popCell];
    
    if (cell == nil) {
        
        cell = [[JTaiPopViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popCell];
    }
    
    // 初始化时,默认第0行是选中状态
    if (_selectedIndexPath == nil) {
        if (indexPath.row == 0) {
            _selectedIndexPath = indexPath;
        }
    }
    
    // 复用时设置选中行的状态
    if(_selectedIndexPath == indexPath) {
        cell.type = PopViewCellStyleSelect;
    }
    else {
        cell.type = PopViewCellStyleDefault;
    }
    cell.title = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - ======================= UITableviewDelegate =======================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectedIndexPath = indexPath;
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(popView:didSelectRowAtIndex:)]) {
        
        [self.delegate popView:self didSelectRowAtIndex:indexPath.row];
    }
}

- (void)layoutSubviews
{
    _tableView.frame = CGRectMake(0, 0, self.frame.size.width, 44*self.dataSource.count);
    _coverView.frame = CGRectMake(0, CGRectGetMaxY(_tableView.frame), self.frame.size.width, Kheight-CGRectGetHeight(_tableView.frame));
}

@end




@interface JTaiPopViewCell ()
{
    // 标题
    UILabel         *_titleLa;
    // 图片
    UIImageView     *_accessoryIcon;
}
@end

@implementation JTaiPopViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat W = self.frame.size.width;
        CGFloat H = self.frame.size.height;
        
        if (!_titleLa) {
            _titleLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, W/2, H)];
            _titleLa.font = [UIFont systemFontOfSize:20];
            _titleLa.textColor = [UIColor blackColor];
            _titleLa.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_titleLa];
        }
        if (!_accessoryIcon) {
            _accessoryIcon = [[UIImageView alloc] initWithFrame:CGRectMake(W-10-30, (H-30)/2, 30, 30)];
            _accessoryIcon.contentMode = UIViewContentModeScaleToFill;
            [self.contentView addSubview:_accessoryIcon];
        }
        
        // 设置默认的类型
        self.type = PopViewCellStyleDefault;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (title) {
        _titleLa.text = title;
    }
}

- (void)setType:(PopViewCellStyle)type
{
    switch (type) {
        case PopViewCellStyleDefault:
            
            _accessoryIcon.image = nil;
            _titleLa.textColor = [UIColor blackColor];
            break;
            
        case PopViewCellStyleSelect:
            
            _accessoryIcon.image = [UIImage imageNamed:@"select"];
            _titleLa.textColor = [UIColor redColor];
            break;
            
        default:
            break;
    }
}

@end