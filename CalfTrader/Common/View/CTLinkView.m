//
//  CTLinkView.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/26.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "CTLinkView.h"

@interface CTLinkView ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) NSMutableDictionary *clicks;

@end

@implementation CTLinkView

#pragma mark - ♻️life cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textView];
        _contentFont = [UIFont systemFontOfSize:16.];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.textView];
        _contentFont = [UIFont systemFontOfSize:16.];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark - 🔒private

#pragma mark - 🍐delegate
- (BOOL)textView:(UITextView *)textView
shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange
     interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    NSString *rangeString = NSStringFromRange(characterRange);
    CTLinkViewClick click = (CTLinkViewClick)self.clicks[rangeString];
    if(click){
        click([textView.text substringWithRange:characterRange]);
        return YES;
    }
    
    return NO;
}

- (BOOL)textView:(UITextView *)textView
shouldInteractWithURL:(NSURL *)URL
         inRange:(NSRange)characterRange
NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead"){
    NSString *rangeString = NSStringFromRange(characterRange);
    CTLinkViewClick click = (CTLinkViewClick)self.clicks[rangeString];
    if(click){
        click([textView.text substringWithRange:characterRange]);
        return YES;
    }
    
    return NO;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if(!NSEqualRanges(textView.selectedRange, NSMakeRange(0, 0))) {
        textView.selectedRange = NSMakeRange(0, 0);
    }
}

#pragma mark - 🚪public
-(void)addLink:(NSRange)range click:(CTLinkViewClick)click{
    NSAttributedString *content = _textView.attributedText;
    if ((range.location + range.length) > content.length) {
        return;
    }
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]
                                             initWithAttributedString:content];
    
    NSString *linkName = NSStringFromRange(range);
    [attrString setAttributes:@{NSLinkAttributeName:linkName,
                                NSFontAttributeName : _contentFont}
                        range:range];
    _textView.attributedText = attrString;
    [self.clicks setValue:click forKey:linkName];
}

#pragma mark - ☸getter and setter
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.editable = NO;
        _textView.delegate = self;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.scrollEnabled = NO;
        _textView.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor lightGrayColor]};
    }
    
    return _textView;
}

-(NSMutableDictionary *)clicks{
    if (!_clicks) {
        _clicks = [[NSMutableDictionary alloc] init];
    }
    
    return _clicks;
}

-(void)setContent:(NSString *)content{
    if ([_content isEqualToString:content]) {
        return;
    }
    _content = [content copy];
    _textView.attributedText = nil;
    _clicks = nil;
    _textView.attributedText = [[NSAttributedString alloc]initWithString:content
                                                              attributes:@{NSFontAttributeName : _contentFont}];
}

-(void)setContentFont:(UIFont *)contentFont{
    if ([_contentFont isEqual:contentFont]) {
        return;
    }
    
    _contentFont = contentFont;
    if (_content && _content.length > 0) {
        _textView.attributedText = [[NSAttributedString alloc]initWithString:_content
                                                                  attributes:@{NSFontAttributeName : _contentFont}];
    }
}

@end
