//
//  WifiViewController.m
//  USBDriveForChen
//
//  Created by chen on 14/11/2.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "WifiViewController.h"
#import "HTTPServer.h"

@interface WifiViewController () <WebFileResourceDelegate>
{
    UILabel *_urlLabel;
    NSMutableArray *_arFiles;
    HTTPServer *_httpServer;
}

@end

@implementation WifiViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_MAINTABLE object:nil];
    [_httpServer stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 30)];
    _urlLabel.textAlignment = NSTextAlignmentCenter;
    _urlLabel.backgroundColor = [UIColor clearColor];
    _urlLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_urlLabel];
    
    [QHFileHelper readFiles:&_arFiles];
    
    // set up the http server
    _httpServer = [[HTTPServer alloc] init];
    [_httpServer setType:@"_http._tcp."];
    [_httpServer setPort:2014];
    [_httpServer setName:@"CocoaWebResource"];
    [_httpServer setupBuiltInDocroot];
    _httpServer.fileResourceDelegate = self;
    
    NSError *error;
    BOOL serverIsRunning = [_httpServer start:&error];
    NSString *url;
    if(!serverIsRunning)
    {
        NSLog(@"Error starting HTTP Server: %@", error);
        url = error.description;
    }else
        url = [NSString stringWithFormat:@"http://%@:%d", [_httpServer hostName], [_httpServer port]];
    NSLog(@"%@", url);
    _urlLabel.text = url;
}

#pragma mark WebFileResourceDelegate
// number of the files
- (NSInteger)numberOfFiles
{
    return [_arFiles count];
}

// the file name by the index
- (NSString*)fileNameAtIndex:(NSInteger)index
{
    return [_arFiles objectAtIndex:index];
}

// provide full file path by given file name
- (NSString*)filePathForFileName:(NSString*)filename
{
    NSString *path = [QHFileHelper filePath:filename];
    return path;
}

// handle newly uploaded file. After uploading, the file is stored in
// the temparory directory, you need to implement this method to move
// it to proper location and update the file list.
- (void)newFileDidUpload:(NSString*)name inTempPath:(NSString*)tmpPath
{
    if (name == nil || tmpPath == nil)
        return;
    NSString *path = [QHFileHelper filePath:name];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    if (![fm moveItemAtPath:tmpPath toPath:path error:&error])
    {
        NSLog(@"can not move %@ to %@ because: %@", tmpPath, path, error );
    }
    _arFiles = nil;
    [QHFileHelper readFiles:&_arFiles];
}

// implement this method to delete requested file and update the file list
- (void)fileShouldDelete:(NSString*)fileName
{
    NSString *path = [self filePathForFileName:fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error;
    if(![fm removeItemAtPath:path error:&error])
    {
        NSLog(@"%@ can not be removed because:%@", path, error);
    }
    _arFiles = nil;
    [QHFileHelper readFiles:&_arFiles];
}

@end
