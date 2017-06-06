//
//  CTLocationManager.h
//  CalfTrader
//
//  Created by 张彬彬 on 2017/5/31.
//  Copyright © 2017年 上海宏鹿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CTLocationManagerHandler)(BOOL inChina) ;

@interface CTLocationManager : NSObject

-(void)requestLocationCompletionHandler:(CTLocationManagerHandler) completion;

@end
