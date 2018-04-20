//
//  DKImageNewFeature.m
//  NewFeature
//
//  Created by HangDian on 2018/4/20.
//  Copyright © 2018年 HangDian. All rights reserved.
//

#import "DKImageNewFeature.h"
#import "DKMainViewController.h"
@interface DKImageNewFeature()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;
@end

@implementation DKImageNewFeature{
    CGFloat            _screenWidth;
    CGFloat            _screenheight;
    NSUInteger         _picCount;
    NSArray            *_picNameArray;
}

-(instancetype)initWithPicNameArray:(NSArray *)picNameArray{
    
    if (self = [super init]) {
        _picNameArray = [NSArray array];
        _picNameArray = picNameArray;        
        [self setupUI];
        [self creatPageControll];
    }
    return self;
}

-(void)setupUI{
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenheight = [UIScreen mainScreen].bounds.size.height;
    _picCount = _picNameArray.count;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _screenWidth, _screenheight)];
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat flagMarginX = 0;
    for (NSInteger i=0; i<_picNameArray.count; i++) {
        flagMarginX = _screenWidth * i;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_picNameArray[i]]];
        imageView.frame = CGRectMake(flagMarginX, 0, _screenWidth, _screenheight);
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(_screenWidth*(_picNameArray.count+1), 0);
    self.scrollView.pagingEnabled = YES;
    
}
#pragma mark - 创建翻页指示器
-(void)creatPageControll{
    UIPageControl *pageControll = [[UIPageControl alloc]init];
    self.pageControl = pageControll;
    pageControll.numberOfPages = _picCount;
    pageControll.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControll.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self.view addSubview:pageControll];
    
    //分页指示器布局
    NSLayoutConstraint *layouCenterX = [NSLayoutConstraint constraintWithItem:pageControll attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint* layoutBottom = [NSLayoutConstraint constraintWithItem:pageControll
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0f
                                                                     constant:-70];
    //关闭系统自动布局
    pageControll.translatesAutoresizingMaskIntoConstraints = NO;
    //让自己写的布局生效,这个是ios8以后的写法
    layoutBottom.active = YES;
    layouCenterX.active = YES;
    
}
#pragma mark - scrollView正在滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x/_screenWidth+0.5;
    if (scrollView.contentOffset.x==_screenWidth*_picCount) {
        DKMainViewController *mainVC = [[DKMainViewController alloc]init];
        [self presentViewController:mainVC animated:NO completion:nil];
        [self.view removeFromSuperview];
    }    
    self.pageControl.hidden = scrollView.contentOffset.x > _screenWidth*(_picCount-0.5);
}

#pragma mark - 设置分页指示器的位置
-(void)setPageControllBottom:(CGFloat)pageControllBottom{
    //分页指示器布局
    NSLayoutConstraint *layouCenterX = [NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    NSLayoutConstraint* layoutBottom = [NSLayoutConstraint constraintWithItem:_pageControl
                                                                    attribute:NSLayoutAttributeBottom
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1.0f
                                                                     constant:-70];
    //关闭系统自动布局
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    //让自己写的布局生效,这个是ios8以后的写法
    layoutBottom.active = YES;
    layouCenterX.active = YES;
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}



@end
