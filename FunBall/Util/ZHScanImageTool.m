//
//  ZHScanImageTool.m
//  BusinessClient
//
//  Created by zhph on 2017/5/8.
//  Copyright © 2017年 小飞鸟. All rights reserved.
//

#import "ZHScanImageTool.h"

#define MaxSCale 2.0  //最大缩放比例
#define MinScale 0.5  //最小缩放比例

@interface ZHScanImageTool()<UIScrollViewDelegate>

@end

@implementation ZHScanImageTool

//原始尺寸
static CGRect oldframe;
//缩放图片的比例
CGFloat totalScale;
/*展示图片的imageView*/
UIImageView *imageView;

/*创建一个查看图片的工具*/
+(instancetype)shareScanImageToolWithImageView:(UIImageView*)imageView{

    return [[ZHScanImageTool alloc]initWithFrame:CGRectZero WithImageView:imageView];
}

-(instancetype)initWithFrame:(CGRect)frame WithImageView:(UIImageView*)currentImageview{

    if (self=[super initWithFrame:frame]) {
        
        self.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor blackColor];
        self.alpha=0.0;
        
        totalScale=1.0;
        
        //当前imageview的图片
        UIImage *image = currentImageview.image;
        //当前视图
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
  
        //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
        oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];

        //将所展示的imageView重新绘制在Window中
        imageView = [[UIImageView alloc] initWithFrame:oldframe];
        [imageView setImage:image];
        imageView.userInteractionEnabled=YES;
        [imageView setTag:1024];
        [self addSubview:imageView];
        
        
        //添加一个啮合手势
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [imageView addGestureRecognizer:pinch];

        //添加点击事件同样是类方法 -> 作用是再次点击回到初始大小
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        //动画放大所展示的ImageView
        
        [UIView animateWithDuration:0.4 animations:^{
            CGFloat y,width,height;
            y = ([UIScreen mainScreen].bounds.size.height - image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width) * 0.5;
            //宽度为屏幕宽度
            width = [UIScreen mainScreen].bounds.size.width;
            //高度 根据图片宽高比设置
            height = image.size.height * [UIScreen mainScreen].bounds.size.width / image.size.width;
            [imageView setFrame:CGRectMake(0, y, width, height)];
            //重要！ 将视图显示出来
            [self setAlpha:1];
        } completion:^(BOOL finished) {
            
        }];
 
    }
    
    return self;

}

#pragma mark 图片的缩放
- (void)pinch:(UIPinchGestureRecognizer *)recognizer{
    
    CGFloat scale = recognizer.scale;
    
    //放大情况
    if(scale > 1.0){
        if(totalScale > MaxSCale) return;
    }
    
    //缩小情况
    if (scale < 1.0) {
        if (totalScale < MinScale) return;
    }
    
    imageView.transform = CGAffineTransformScale(imageView.transform, scale, scale);
    totalScale *=scale;
    recognizer.scale = 1.0;
    
}


#pragma mark 点击隐退图片
-(void)hideImageView:(UITapGestureRecognizer *)tap{
    //原始imageview
    UIImageView *imageView = [tap.view viewWithTag:1024];
    //恢复
    [UIView animateWithDuration:0.4 animations:^{
        [imageView setFrame:oldframe];
        self.alpha=0.0;
    } completion:^(BOOL finished) {
        //完成后操作->将背景视图删掉
        [self removeFromSuperview];
    }];
}



@end
