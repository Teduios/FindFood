//
//  MyHeaderImageCell.m
//  FindFood
//
//  Created by tarena on 16/4/28.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MyHeaderImageCell.h"
#import "UIImageView+RoundImageView.h"

#define kCACHESPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"image"]
@interface MyHeaderImageCell()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end
@implementation MyHeaderImageCell 

- (void)awakeFromNib {
    [((UIImageView *)[self viewWithTag:200]) setRoundLayer];
    NSData *imageData=[NSData dataWithContentsOfFile:kCACHESPATH];
    if (imageData) {
        ((UIImageView *)[self viewWithTag:200]).image=[UIImage imageWithData:imageData];
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:YES];
   
    // Configure the view for the selected state
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self changeHeaderImage];
   
}
-(void)changeHeaderImage
{
    UIActionSheet *sht = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机"otherButtonTitles:@"相册", nil];
    [sht showInView:self];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 2) {
       
    }else if(buttonIndex == 1){
        
        UIImagePickerController *imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        [self.viewController presentViewController:imagePicker animated:YES completion:nil];
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker = [UIImagePickerController new];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            //            imagePicker.allowsEditing = YES;
            [self.viewController presentViewController:imagePicker animated:YES completion:nil];
           
        }
        
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 取得编辑过的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ((UIImageView *)[self viewWithTag:200]).image = image;
    
    NSData *imageData=UIImagePNGRepresentation(image);
    [imageData writeToFile:kCACHESPATH atomically:YES];
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}
@end
