//
//  DKMoveNewFeatureVC.m
//  NewFeature
//
//  Created by HangDian on 2018/4/20.
//  Copyright © 2018年 HangDian. All rights reserved.
//

#import "DKMoveNewFeatureVC.h"
#import <AVKit/AVKit.h>
#import "DKMainViewController.h"
@interface DKMoveNewFeatureVC ()
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@end

@implementation DKMoveNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"qidong" withExtension:@"mp4"];
    self.player = [AVPlayer playerWithURL:url];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = self.view.bounds;
    [self.view.layer  addSublayer:self.playerLayer];
    [self.player play];
    
    
    UIButton *enterButton = [[UIButton alloc]initWithFrame:CGRectMake(24, self.view.bounds.size.height-80, self.view.bounds.size.width-48, 44)];
    enterButton.layer.cornerRadius = 22;
    enterButton.layer.borderWidth = 1;
    [enterButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:enterButton];
    [enterButton addTarget:self action:@selector(presentViewController) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark - 循环播放的通知
-(void)playbackFinished:(NSNotification *)notification{
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
}

-(void)presentViewController{
    DKMainViewController *mainVC = [[DKMainViewController alloc]init];
    [self presentViewController:mainVC animated:YES completion:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self.playerLayer removeAllAnimations];
        [self.view removeFromSuperview];
    }];

}
#pragma mark - 移除通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
