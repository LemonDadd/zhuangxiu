//
//  UploadPicViewController.m
//  HeLanDou
//
//  Created by 关云秀 on 2019/1/28.
//  Copyright © 2019 博源启程. All rights reserved.
//

#import "UploadPicViewController.h"
#import "ACActionSheet.h"
#import "JJImagePicker.h"

@interface UploadPicViewController ()<ACActionSheetDelegate>

@property (nonatomic, strong)UIImageView *pic;

@end

@implementation UploadPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"下拉"] style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _pic = [UIImageView new];
    [self.view addSubview:_pic];
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)right {
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择",@"保存图片", nil];
    [actionSheet show];
}

#pragma mark - ACActionSheet delegate
- (void)actionSheet:(ACActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[JJImagePicker sharedInstance] showImagePickerWithType:JJImagePickerTypeCamera InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
            self.pic.image = image;
        }];
    }
    if (buttonIndex == 1) {
        [[JJImagePicker sharedInstance] showImagePickerWithType:JJImagePickerTypePhoto InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
            self.pic.image = image;
        }];
    }
    
    if (buttonIndex == 2) {
        
    }
}

- (void)save {

}

- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
