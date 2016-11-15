//
//  ViewController.m
//  KVODemo
//
//  Created by csdc-iMac on 2016/11/15.
//  Copyright © 2016年 Cloudox. All rights reserved.
//

#import "ViewController.h"
#import "StudentModel.h"

//设备的宽高
#define SCREENWIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT      [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property (nonatomic, strong) StudentModel *studentModel;
@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // 实例化并设置监听
    self.studentModel = [[StudentModel alloc] init];
    [self.studentModel setValue:@"Cloudox" forKey:@"name"];
    [self.studentModel setValue:@"90.0" forKey:@"score"];
    [self.studentModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];
    
    // 界面内容
    // 名字
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 20)];
    nameLabel.text = [NSString stringWithFormat:@"Name：%@", [self.studentModel valueForKey:@"name"]];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    
    // 分数
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, SCREENWIDTH, 20)];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score：%@", [self.studentModel valueForKey:@"score"]];
    self.scoreLabel.textColor = [UIColor whiteColor];
    self.scoreLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.scoreLabel];
    
    // 按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((SCREENWIDTH - 100)/2, 300, 100, 20)];
    [btn setTitle:@"修改分数" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

// 按钮响应
- (void)changeScore {
    [self.studentModel setValue:@"99.0" forKey:@"score"];
}

// KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"score"]) {
        self.scoreLabel.text = [NSString stringWithFormat:@"Score：%@", [self.studentModel valueForKey:@"score"]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
