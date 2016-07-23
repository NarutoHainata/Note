//
//  CustomAlertView.m
//  Note
//
//  Created by zhang on 1/20/16.
//  Copyright (c) 2016 naruto. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#import "CustomAlertView.h"

@implementation CustomAlertView
{
    UITextField *titleFiled;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.window.windowLevel = UIWindowLevelAlert;
        self.backgroundColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:0.5];
        
        
            UIView *alertView = [[UIView alloc]init];
            alertView.frame = CGRectMake(0, 0, 300, 120);
            alertView.center = self.center;
            alertView.backgroundColor = [UIColor whiteColor];
            alertView.layer.borderColor = [[UIColor greenColor]CGColor];
            alertView.layer.borderWidth = 1;
            alertView.layer.cornerRadius = 10;
            
            [self addSubview:alertView];
        
        
    }
    return self;
}
- (void)show {
    self.hidden = NO;
    [self makeKeyAndVisible];
}

- (void)dismiss {
    self.hidden = YES;
    [self resignKeyWindow];
    //[self removeFromSuperview];
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 点击消失
    //[self dismiss];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
