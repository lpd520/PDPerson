//
//  PDPhotoManagerVC.m

//
//  Created by mac on 2018/8/2.
//  Copyright © 2018年 QingYe. All rights reserved.
//

#import "PDPhotoManagerVC.h"
#import "UIImage+PD.h"
#import "PDNetworking.h"
#import "PDUploadParam.h"

@interface PDPhotoManagerVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic,strong)UIImagePickerController *imgPickVC;

@end

@implementation PDPhotoManagerVC

-(UIImagePickerController *)imgPickVC{
    if (!_imgPickVC) {
        _imgPickVC = [[UIImagePickerController alloc] init];
        _imgPickVC.delegate = self;
    }
    return _imgPickVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)uploadPhoto:(UIImage *)pic{
    [SVProgressHUD showStatesMsge:nil time:0];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    PDUploadParam *pm = [[PDUploadParam alloc] initWithImage:pic Type:PDUploadQuantityCategoryMulti];
    [arr addObject:pm];
    
    [[PDNetworking sharedInstance] uploadWithURLString:@"" parameters:nil uploadParam:arr success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSString * imgUrlStrings = responseObject[@"data"];
        NSLog(@"......>%@",imgUrlStrings);
//        self.imgUrls = [NSMutableArray arrayWithArray:[responseObject[@"data"] componentsSeparatedByString:@","]];
        if (imgUrlStrings.length>0) {
            self.imgURLCallbackBlock(imgUrlStrings);
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showNOmessage:@"上传失败，请稍后再试"];
        self.imgURLCallbackBlock(nil);
    }];
    
}

// 选择照片
-(void)beginChoosePhotoFromAlbums{
    // 设置照片来源为相册
    self.imgPickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imgPickVC.allowsEditing = YES;
    // 展示选取照片控制器
    [self presentViewController:self.imgPickVC animated:YES completion:^{
    }];
}

// 拍照
-(void)beginTakePhotoWithCamera{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [SVProgressHUD showNOmessage:@"未检测到摄像头"];
        [self dismissViewControllerAnimated:YES completion:nil];
        return ;
    }
    
    // 设置照片来源为相机
    self.imgPickVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 设置（默认）前置or后置摄像头
    self.imgPickVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.imgPickVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    // 展示选取照片控制器
    [self presentViewController:self.imgPickVC animated:NO completion:nil];
}

// 代理方法
#pragma mark - 代理方法  当得到照片或视频后，调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // 选取完图片后，跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // ke yi 裁剪   UIImagePickerControllerEditedImage(只能在相册选择中)
    //UIImagePickerControllerOriginalImage
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //提交后台
    [self uploadPhoto:image];
}

//取消选取调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.imgURLCallbackBlock(nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
