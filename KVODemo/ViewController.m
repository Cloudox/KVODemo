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
    [self.studentModel setValue:@"89.0" forKey:@"score"];
    [self.studentModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];// 1.不使用context
//    [self.studentModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:@"heyMe"];// 2.通过context传递内容给观察者
//    [self.studentModel addObserver:self forKeyPath:@"score" options:NSKeyValueObservingOptionOld context:nil];// 3.让观察者可以获取到旧值
    
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
    
//    [self.studentModel removeObserver:self forKeyPath:@"score"];// 4.移除观察者
}

// 按钮响应
- (void)changeScore {
//    [self willChangeValueForKey:@"score"];// 5.改为手动通知
    [self.studentModel setValue:@"99.0" forKey:@"score"];
//    [self didChangeValueForKey:@"score"];// 5.改为手动通知
}

// KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"score"]) {
        self.scoreLabel.text = [NSString stringWithFormat:@"Score：%@", [self.studentModel valueForKey:@"score"]];
    }
//    NSLog(@"%@", context);// 2.通过context获取被观察者传递的内容
//    NSLog(@"%@", change);// 3.根据change的设置获取新值、旧值等
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
