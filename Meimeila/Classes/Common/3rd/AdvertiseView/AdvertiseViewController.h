//
//  AdvertiseViewController.h
//  zhibo
//
//  Created by 周焕强 on 16/5/17.
//  Copyright © 2016年 zhq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertiseViewController : UIViewController

@property (nonatomic, copy) NSString *adUrl;
- (BOOL)isFileExistWithFilePath:(NSString *)filePath;
- (NSString *)getFilePathWithImageName:(NSString *)imageName;
- (void)getAdvertisingImage:(NSString *)imageUrl;
@end
