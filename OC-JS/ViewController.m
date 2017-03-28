//
//  ViewController.m
//  OC-JS
//
//  Created by a on 17/3/28.
//  Copyright © 2017年 a. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *webView;

@end

@implementation ViewController

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SW, 64)];
    [btn setTitle:@"alert" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClikc) forControlEvents:UIControlEventTouchUpInside];

    [self loadWebView];

}

- (void)btnClikc
{
    [self.webView evaluateJavaScript:@"alertMessage('hello')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {

        NSLog(@"alert");

    }];
}

- (void)loadWebView
{
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SW, SH)];
    _webView.navigationDelegate = self;
    _webView.UIDelegate = self;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"OC-JS.html" ofType:nil];
    NSString *htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlStr baseURL:[NSURL URLWithString:path]];

    [self.view addSubview:_webView];

}

#pragma mark WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        completionHandler();

    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"webView did start provision");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"webView fail to provision!");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"webview fail navigation!");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"webView did finish navigation!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
