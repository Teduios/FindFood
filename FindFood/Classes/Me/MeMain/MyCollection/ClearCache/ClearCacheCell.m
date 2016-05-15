//
//  ClearCacheCell.m
//  FindFood
//
//  Created by tarena on 16/4/29.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "ClearCacheCell.h"

@implementation ClearCacheCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self clearCache];
}
//清除缓存
-(void)clearCache
{
    // 要列出来的目录
    NSString *path1=[NSHomeDirectory() stringByAppendingString:@"/Library/Caches/com.ibireme.yykit/images/data"];
    NSString *filePath1=path1;
    NSFileManager *myFileManager=[NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator;
    myDirectoryEnumerator=[myFileManager enumeratorAtPath:path1];
    //列举目录内容，可以遍历子目录
    while((path1=[myDirectoryEnumerator nextObject])!=nil)
    {
     [myFileManager removeItemAtPath:[filePath1 stringByAppendingPathComponent:path1] error:nil];
    }
    [self showBusyHUD:@"已清除缓存"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideBusyHUD];
    });
}


@end
