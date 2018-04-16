//
//  ViewController.m
//  Videos
//
//  Created by Yi on 2018/4/15.
//  Copyright © 2018年 Yi. All rights reserved.
//

#import "ViewController.h"
#import "FetchResult.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()<UIDocumentPickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property   (nonatomic,strong)FetchResult   *fetchResult;
@property   (nonatomic,strong)UIImagePickerController   *imagePickerController;
@end

@implementation  ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    _fetchResult    =   [FetchResult shareResult];
    [_fetchResult setBlock:^(NSMutableArray *videoArray,NSMutableArray *imageArray)
     {
         
     }];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        //NSLog(@"相册");
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //    _imagePickerController.mediaTypes   =   @[(NSString *)kUTTypeMovie];
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        
    }else{
        //如果是视频
        NSURL *url = info[UIImagePickerControllerMediaURL];
        //播放视频
        
//        _videoUrl = url;
        //保存视频至相册（异步线程）
//        NSString *urlStr = [url path];
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
//                
//                UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
//            }
//        });
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 图片保存完毕的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextIn {
    
}

#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
    }
}
- (IBAction)selectLeftButtonItems:(id)sender
{
    [JXTAlertTools showArrayActionSheetWith:self title:@"从xx导入视频" message:@"" callbackBlock:^(NSInteger btnIndex)
    {
        if (btnIndex==1)
        {
            [self   openIphoneAblum];
        }else if (btnIndex==2)
        {
            [self presentDocumentPicker];
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitleArray:@[@"本地",@"其他应用程序"] otherButtonStyleArray:nil];
}
#pragma mark --iOS11打开文件管理器app
- (void)presentDocumentPicker {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
                                                                                                                          inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    
}
#pragma mark --打开手机相册读取本地视频
- (void)openIphoneAblum
{
    [self selectImageFromAlbum];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
