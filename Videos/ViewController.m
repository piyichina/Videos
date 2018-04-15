//
//  ViewController.m
//  Videos
//
//  Created by Yi on 2018/4/15.
//  Copyright © 2018年 Yi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)selectLeftButtonItems:(id)sender
{
    [JXTAlertTools showArrayActionSheetWith:self title:@"从xx导入视频" message:@"" callbackBlock:^(NSInteger btnIndex)
    {
        if (btnIndex==0)
        {
            
        }else if (btnIndex==1)
        {
            
        }else if (btnIndex==2)
        {
            [self presentDocumentPicker];
        }else if (btnIndex==3)
        {
            
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitleArray:@[@"本地",@"Drobox",@"其他应用程序",@"itunes文件共享"] otherButtonStyleArray:nil];
    
    
    
}
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
