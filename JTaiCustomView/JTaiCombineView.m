//
//  JTaiCombineView.m
//  JTaiCustomView
//
//  Created by 黄金台 on 16/3/6.
//  Copyright © 2016年 com.Hjt_830.163. All rights reserved.
//

#import "JTaiCombineView.h"

@interface JTaiCombineView () <UITableViewDataSource,UITableViewDelegate>
{
    // 遮罩
    UIView  *_coverView;
    // 内容View
    UIView  *_contentView;
    // 表
    UITableView *_tableView;
    // 表头
    UILabel     *_header;
    //
    UIButton    *_sureBtn;
}
@end

@implementation JTaiCombineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGFloat contentH = (self.dataSource.count+2) * 44;
    
    if (contentH > Kheight/2) {
        contentH = Kheight/2;
    }
    CGFloat coverH = Kheight - contentH;
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, coverH)];
        _coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:_coverView];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_coverView addGestureRecognizer:tap];
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, coverH, Kwidth, contentH)];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        [self addSubview:_contentView];
    }
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, Kwidth, contentH-44) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_contentView addSubview:_tableView];
    }
    if (!_header) {
        _header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 44)];
        _header.textColor = [UIColor blackColor];
        _header.textAlignment = NSTextAlignmentCenter;
        _header.font = [UIFont systemFontOfSize:18];
        [_contentView addSubview:_header];
    }
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_sureBtn setBackgroundColor:[UIColor orangeColor]];
        _sureBtn.clipsToBounds = YES;
        _sureBtn.layer.cornerRadius = 8.0f;
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.frame = CGRectMake((Kwidth-200)/2, contentH-39, 200, 30);
        [_contentView addSubview:_sureBtn];
    }
}

- (void)setTitle:(NSString *)title
{
    if (title) {
        _header.text = [NSString stringWithFormat:@"  %@",title];
    }
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
    if (buttonTitle) {
        [_sureBtn setTitle:buttonTitle forState:UIControlStateNormal];
    }
}

- (void)setDataSource:(NSArray<NSString *> *)dataSource
{
    if (dataSource.count > 0) {
        
        _dataSource = dataSource;
        _tableView.tableHeaderView = _header;
        [self layoutIfNeeded];
        
        [_tableView reloadData];
    }
}

#pragma mark - ======================= UITableViewDatasource =======================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:220 green:220 blue:220 alpha:1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor grayColor];
    }
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - ======================= UITableViewDelegate =======================

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(combineView:didSelectRowAtIndex:)]) {
        
        [self.delegate combineView:self didSelectRowAtIndex:indexPath.row];
    }
    
    [self dismiss];
}

- (void)submit:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(combineViewDidSelectButton)]) {
        
        [self.delegate combineViewDidSelectButton];
    }
    [self dismiss];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];

    CGFloat contentH = (self.dataSource.count+1) * 44;
    if (contentH > Kheight/2) {
        contentH = Kheight/2;
    }
    CGFloat coverH = Kheight - contentH;
    
    _coverView.frame = CGRectMake(0, -coverH, Kwidth, coverH);
    _contentView.frame = CGRectMake(0, Kheight+contentH, Kwidth, contentH);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _coverView.frame = CGRectMake(0, 0, Kwidth, coverH);
        _contentView.frame = CGRectMake(0, coverH, Kwidth, contentH);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    CGFloat W = self.frame.size.width;
    CGFloat H = self.frame.size.height;
    
    CGFloat contentH = (self.dataSource.count+2) * 44;
    
    if (contentH > Kheight/2) {
        contentH = Kheight/2;
    }
    CGFloat coverH = H - contentH;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _coverView.frame = CGRectMake(0, -coverH, W, coverH);
        _contentView.frame = CGRectMake(0, Kheight+contentH, W, contentH);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentH = (self.dataSource.count+2) * 44;
    
    if (contentH > Kheight/2) {
        contentH = Kheight/2;
    }
    CGFloat coverH = Kheight - contentH;
    
    _coverView.frame = CGRectMake(0, 0, Kwidth, coverH);
    _contentView.frame = CGRectMake(0, coverH, Kwidth, contentH);
    _tableView.frame = CGRectMake(0, 0, Kwidth, contentH-44);
    _sureBtn.frame = CGRectMake((Kwidth-200)/2, contentH-39, 200, 34);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
