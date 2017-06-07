//
//  UIView+CTFrame.m
//  CalfTrader
//
//  Created by 张彬彬 on 2017/6/7.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import "UIView+CTFrame.h"

@implementation UIView (CTFrame)
@dynamic
ct_left,
ct_bottom,
ct_top,
ct_right,
ct_height,
ct_width,
ct_y,
ct_x;
-(CGFloat)ct_top{
    return self.ct_x;
}

-(CGFloat)ct_left{
    return self.ct_x;
}

-(CGFloat)ct_right{
    return self.ct_x + self.ct_width;
}

-(CGFloat)ct_bottom{
    return self.ct_y + self.ct_height;
}

-(CGFloat)ct_x{
    return self.frame.origin.x;
}

-(void)setCt_x:(CGFloat)ct_x{
    CGRect frame = self.frame;
    frame.origin.x = ct_x;
    self.frame = frame;
}

-(CGFloat)ct_y{
    return self.frame.origin.y;
}

-(void)setCt_y:(CGFloat)ct_y{
    CGRect frame = self.frame;
    frame.origin.y = ct_y;
    self.frame = frame;
}

-(CGFloat)ct_width{
    return self.frame.size.width;
}

-(void)setCt_width:(CGFloat)ct_width{
    CGRect frame = self.frame;
    frame.size.width = ct_width;
    self.frame = frame;
}

-(CGFloat)ct_height{
    return self.frame.size.height;
}

-(void)setCt_height:(CGFloat)ct_height{
    CGRect frame = self.frame;
    frame.size.height = ct_height;
    self.frame = frame;
}

@end
