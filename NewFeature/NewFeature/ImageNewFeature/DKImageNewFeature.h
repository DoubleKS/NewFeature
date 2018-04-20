//
//  DKImageNewFeature.h
//  NewFeature
//
//  Created by HangDian on 2018/4/20.
//  Copyright © 2018年 HangDian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKImageNewFeature : UIViewController

/**
 翻页指示器展示页的颜色
 */
@property (nonatomic,strong)UIColor *currentPageIndicatorTintColor;

/**
 翻页指示器未展示页的颜色
 */
@property (nonatomic,strong)UIColor *pageIndicatorTintColor;

/**
 翻页指示器距离屏幕底部的高度
 */
@property (nonatomic,assign)CGFloat pageControllBottom;

/**
 指定初始化方法
 @param picNameArray 图片数组
 */
-(instancetype)initWithPicNameArray:(NSArray *)picNameArray;


@end
