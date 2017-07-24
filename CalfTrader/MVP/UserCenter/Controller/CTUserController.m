//
//  CTUserController.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/5.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTUserController.h"
#import <WebKit/WebKit.h>

@interface CTUserController ()
<WKNavigationDelegate,
WKUIDelegate,
WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *registerUrlString;

@end

@implementation CTUserController

#pragma mark - ♻️life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.frame = CGRectMake(0, 0, 300, 300);
    self.webView.center = self.view.center;
    [self.view addSubview:self.webView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_registerUrlString) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_registerUrlString]]];
        return;
    }
    __weak typeof(self) weakSelf = self;
    [[CTNetworkManager sharedManager]get:CTBaseUrl
                               urlString:@"calfTrader-accountCenter-api/hgaccount/getRegisteH5Url.do"
                              parameters:@{@"mobile":@"17621150503",@"token":@"5ae02b25973f193d9820170707152302"}
                              encryption:YES
                              completion:^(id response, NSError *error) {
                                  NSString *urlString = response[@"data"][@"data"][@"hg_reg_url"];
                                  _registerUrlString = urlString;
                                  [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
                              }];
}

#pragma mark - 🔒private
- (void) addUserScriptToUserContentController:(WKUserContentController *) userContentController{
    NSString *jsHandler = [NSString stringWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"ajaxHandler" withExtension:@"js"]
                                                   encoding:NSUTF8StringEncoding
                                                      error:NULL];
    WKUserScript *ajaxHandler = [[WKUserScript alloc]initWithSource:jsHandler
                                                      injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                   forMainFrameOnly:NO];
    [userContentController addScriptMessageHandler:self name:@"callbackHandler"];
    [userContentController addUserScript:ajaxHandler];
}

#pragma mark - 🔄overwrite

#pragma mark - 🚪public

#pragma mark - 🍐delegate
/*--- WKScriptMessageHandler --*/
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"callbackHandler"]) {
        if (message.body) {
            NSLog(@"%@",[NSString stringWithFormat:@"%@",message.body]);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                           message:[NSString stringWithFormat:@"%@",message.body]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

/*--- WKUIDelegate ---*/

/*--- WKNavigationDelegate ---*/
- (void)webView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if (navigationResponse.forMainFrame) {
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    decisionHandler(WKNavigationResponsePolicyCancel);
}

//- (void)webView:(WKWebView *)webView
//decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
//decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [webView sizeToFit];
}
#pragma mark - ☎️notification

#pragma mark - 🎬event response

#pragma mark - ☸getter and setter
-(WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        configuration.suppressesIncrementalRendering = NO;
        configuration.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
        [self addUserScriptToUserContentController:configuration.userContentController];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
        _webView.opaque = NO;
    }
    
    return _webView;
}

@end
