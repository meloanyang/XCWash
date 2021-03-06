//
//  UIImage+IMChat.m
//  IOS-IM
//
//  Created by ZhangGang on 13-9-17.
//  Copyright (c) 2013年 Archermind. All rights reserved.
//

#import "UIImage+IMChat.h"

@implementation UIImage (IMChat)

#pragma mark - Avatar styles
- (UIImage *)circleImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:YES
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)squareImageWithSize:(CGFloat)size
{
    return [self imageAsCircle:NO
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

//add by xishuaishuai 处理圆角图片
- (UIImage *)roundImageWithSize:(CGFloat)size
{
    return [self imageAsRound:YES
                   withDiamter:size
                   borderColor:[UIColor colorWithHue:0.0f saturation:0.0f brightness:0.8f alpha:1.0f]
                   borderWidth:1.0f
                  shadowOffSet:CGSizeMake(0.0f, 1.0f)];
}

- (UIImage *)imageAsRound:(BOOL)clipToCircle
              withDiamter:(CGFloat)diameter
              borderColor:(UIColor *)borderColor
              borderWidth:(CGFloat)borderWidth
             shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = 0.0;//diameter * 0.15f;
    CGFloat newSize = diameter; //+ increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero))
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    3.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
//    // draw border
//    // as circle or square
//    CGPathRef borderPath = CGPathCreateWithRect(imgRect, NULL);
//    
//    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
//    CGContextSetLineWidth(context, borderWidth);
//    CGContextAddPath(context, borderPath);
//    CGContextDrawPath(context, kCGPathFillStroke);
//    CGPathRelease(borderPath);
//    CGContextRestoreGState(context);
    
    // clip to circle
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithRoundedRect:imgRect cornerRadius:4.0];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
//end by xishuaishuai
- (UIImage *)imageAsCircle:(BOOL)clipToCircle
               withDiamter:(CGFloat)diameter
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
              shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = 0.0;//diameter * 0.15f;
    CGFloat newSize = diameter; //+ increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero))
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    3.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    
    // draw border
    // as circle or square
    CGPathRef borderPath = (clipToCircle) ? CGPathCreateWithEllipseInRect(imgRect, NULL) : CGPathCreateWithRect(imgRect, NULL);
    
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);//modidy by xishuaishuai borderColor
    CGContextSetLineWidth(context, borderWidth);
    CGContextAddPath(context, borderPath);
    [[UIColor clearColor] setFill];//设置要填充颜色。//add by xishuaishuai//有问题的话再打开
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(borderPath);
    CGContextRestoreGState(context);
    
    // clip to circle
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:imgRect];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Input bar
+ (UIImage *)inputBar
{
    return [[UIImage imageNamed:@"input-bar"] resizableImageWithCapInsets:UIEdgeInsetsMake(19.0f, 3.0f, 19.0f, 3.0f)];
}

+ (UIImage *)inputField
{
    return [[UIImage imageNamed:@"input-field"] resizableImageWithCapInsets:UIEdgeInsetsMake(20.0f, 12.0f, 18.0f, 18.0f)];
}

#pragma mark - Bubble cap insets
- (UIImage *)makeStretchableSquareIncoming
{
     return [self stretchableImageWithLeftCapWidth:20 topCapHeight:20];//modify by xishuaishuai 20 30 to 20 20
}

- (UIImage *)makeStretchableSquareOutgoing
{
//    return [self stretchableImageWithLeftCapWidth:20 topCapHeight:20];//modify by xishuaishuai 20 30 to 20 20
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
    
}


- (UIImage *)textImageStretchableIncoming
{
    //return [self stretchableImageWithLeftCapWidth:50 topCapHeight:30];
     return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
//    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(52.0f,34.0f,18.0f,34.0f)];
//    return [self stretchableImageWithLeftCapWidth:20 topCapHeight:40];  26.0f,17.0f,10.0f,17.0f
}

- (UIImage *)textImageStretchableOutgoing
{
    // return [self stretchableImageWithLeftCapWidth:50 topCapHeight:30];
//    return [self stretchableImageWithLeftCapWidth:30 topCapHeight:15];
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(26.0f,17.0f,10.0f,17.0f)];
    
    
}

////////////////////////////////////////////////////////////////////
#pragma mark 发送和接收文字
////////////////////////////////////////////////////////////////////
+ (UIImage *)bubbleSquareIncoming
{
    return nil;
    
//    return [MSG_RECIEVE_MSG_IMAGE textImageStretchableIncoming];
    
//    return [[UIImage imageNamed:@"ReceiverTextNodeBkg"] makeStretchableSquareIncoming];
}

+ (UIImage *)bubbleSquareIncomingSelected
{
    
    return nil;
    return [[UIImage imageNamed:@"IMChatReciveHL"] textImageStretchableIncoming];
    
//    return [[UIImage imageNamed:@"ReceiverTextNodeBkgHL"] makeStretchableSquareIncoming];
}

+ (UIImage *)bubbleSquareOutgoing
{
    
    return nil;
    
//    return [MSG_SEND_MSG_IMAGE textImageStretchableOutgoing];
//    return [[UIImage imageNamed:@"SenderTextNodeBkg"] makeStretchableSquareOutgoing];
}

+ (UIImage *)bubbleSquareOutgoingSelected
{
    return [[UIImage imageNamed:@"IMChatSendHL"] textImageStretchableOutgoing];
    
//    return [[UIImage imageNamed:@"SenderTextNodeBkgHL"] makeStretchableSquareOutgoing];
}

////////////////////////////////////////////////////////////////////
#pragma mark 发送和接收图片 
////////////////////////////////////////////////////////////////////
+ (UIImage *)bubbleImageOutgoing
{
//    return [MSG_SEND_MSG_IMAGE makeStretchableSquareOutgoing];//modify by xishuaishuai SenderImageNodeBorder
    
    return nil;
}

+ (UIImage *)bubbleImageIncoming
{
    return nil;
    
//    return [MSG_RECIEVE_MSG_IMAGE makeStretchableSquareOutgoing];//modify by xishuaishuai ReceiverImageNodeBorder
}

////////////////////////////////////////////////////////////////////
#pragma mark 发送和接收名片 
////////////////////////////////////////////////////////////////////
+ (UIImage *)bubbleVcardOutgoing
{
    
    return nil;
//    return [MSG_SEND_MSG_IMAGE makeStretchableSquareOutgoing];//SenderAppNodeBkg modify by xishuaishuai
}

+ (UIImage *)bubbleVcardOutgoingSelected
{
    return [[UIImage imageNamed:@"SenderAppNodeBkg_HL"] makeStretchableSquareOutgoing];
}

+ (UIImage *)bubbleVcardIncoming
{
    return nil;
    
//    return [MSG_RECIEVE_MSG_IMAGE makeStretchableSquareOutgoing];//ReceiverAppNodeBkg modify by xishuaishuai
}

+ (UIImage *)bubbleVcardIncomingSelected
{
    return [[UIImage imageNamed:@"ReceiverAppNodeBkg_HL"] makeStretchableSquareOutgoing];
}

@end
