//
//  ViewController.m
//  USBDriveForChen
//
//  Created by chen on 14/10/19.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "ViewController.h"

#import "UtilBottomControl.h"
#import "WifiViewController.h"
#import "FileCollectionViewCell.h"
#import "QHDialogView.h"

@interface ViewController ()<UtilBottomControlDelegate, UICollectionViewDataSource, UICollectionViewDelegate, FileCollectionViewCellDelegate>
{
    NSArray *_arData;
    NSMutableArray *_arFiles;
    UICollectionView *_filesListView;
    NSDictionary *_dicImgs;
    BOOL _bTransform;
    UITapGestureRecognizer *_tapGestureTel2;
    BOOL _bLine;
}

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

static NSString * const reuseIdentifier = @"collectionViewCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadFileList) name:kRELOAD_MAINTABLE object:nil];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"我的U盘";
    
    NSUInteger bottomHeight = 44;
    UtilBottomControl *utilbottomC = [[UtilBottomControl alloc] initWtihFrame:CGRectMake(0, self.view.height - bottomHeight, self.view.width, bottomHeight) data:_arData];
    utilbottomC.delegate = self;
    [self.view addSubview:utilbottomC];
    
    float nWidth = self.view.width/4;
    float nHeight = nWidth * 1.15;
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(nWidth, nHeight);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;//列距
    
    CGRect frame = CGRectMake(0, self.navigationController.navigationBar.bottom, self.view.width, self.view.height - self.navigationController.navigationBar.bottom - utilbottomC.height);
    _filesListView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    _filesListView.backgroundColor = [UIColor whiteColor];
    _filesListView.dataSource = self;
    _filesListView.delegate = self;
    [_filesListView registerClass:[FileCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_filesListView];
    
    [self showList];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)];
    [_filesListView addGestureRecognizer:lpgr];
    
    _tapGestureTel2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)];
    [_tapGestureTel2 setNumberOfTapsRequired:2];
    [_tapGestureTel2 setNumberOfTouchesRequired:1];
    [_tapGestureTel2 setEnabled:NO];
    [_filesListView addGestureRecognizer:_tapGestureTel2];
    
    [self loadFileList];
}

- (void)initData
{
    _arData = @[@"wifi", @"fold", @"photo", @"order", @"show"];
    [QHFileHelper moveFileToDocument:@"hello" type:@"txt"];
    [QHFileHelper writeFile:@"bye.txt" content:@"good bye"];
    
    _dicImgs = @{@"sound": [UIImage imageNamed:@"images/filesicon/img_file_sound.png"],
                 @"video": [UIImage imageNamed:@"images/filesicon/img_file_video.png"],
                 @"image": [UIImage imageNamed:@"images/filesicon/img_file_image.png"],
                 @"pdf"  : [UIImage imageNamed:@"images/filesicon/img_file_pdf.png"],
                 @"ppt"  : [UIImage imageNamed:@"images/filesicon/img_file_ppt.png"],
                 @"rar"  : [UIImage imageNamed:@"images/filesicon/img_file_rar.png"],
                 @"word" : [UIImage imageNamed:@"images/filesicon/img_file_word.png"],
                 @"xls"  : [UIImage imageNamed:@"images/filesicon/img_file_xls.png"],
                 @"other"  : [UIImage imageNamed:@"images/filesicon/img_file_default.png"]};
}

// load file list
- (void)loadFileList
{
    _arFiles = nil;
    [QHFileHelper readFiles:&_arFiles];
    [_filesListView reloadData];
}

- (UIImage *)toImageForhead:(NSString *)szType
{
    if ([szType isEqualToString:@"jpeg"] || [szType isEqualToString:@"png"] || [szType isEqualToString:@"git"] || [szType isEqualToString:@"jpg"])
        return [_dicImgs objectForKey:@"image"];
    else if ([szType isEqualToString:@"rar"] || [szType isEqualToString:@"zip"])
        return [_dicImgs objectForKey:@"rar"];
    else if ([szType isEqualToString:@"doc"] || [szType isEqualToString:@"docx"])
        return [_dicImgs objectForKey:@"word"];
    else if ([szType isEqualToString:@"xls"] || [szType isEqualToString:@"xlsx"])
        return [_dicImgs objectForKey:@"xls"];
    else if ([szType isEqualToString:@"mp3"])
        return [_dicImgs objectForKey:@"sound"];
    else if ([szType isEqualToString:@"mp4"])
        return [_dicImgs objectForKey:@"video"];
    else if ([szType isEqualToString:@"ppt"])
        return [_dicImgs objectForKey:@"ppt"];
    else if ([szType isEqualToString:@"pdf"])
        return [_dicImgs objectForKey:@"pdf"];
    else
        return [_dicImgs objectForKey:@"other"];
    
    return nil;
}

- (void)showList
{
    float nWidth = self.view.width/4;
    float nHeight = nWidth * 1.15;
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (_bLine)
    {
        nHeight = nWidth * 1.15;
        nWidth = self.view.width;
    }else
    {
//        nWidth = self.view.width/4;
    }
    _flowLayout.itemSize = CGSizeMake(nWidth, nHeight);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;//列距
    
    [_filesListView setCollectionViewLayout:_flowLayout animated:YES];
}

#pragma mark - action

- (void)openFile:(NSString *)file
{
    NSString *path = [QHFileHelper filePath:file];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    UIViewController *webFileViewController = [[UIViewController alloc] init];
    webFileViewController.view.frame = [UIScreen mainScreen].bounds;
    webFileViewController.navigationItem.title = @"文件查看";
    
    UIWebView* webView=[[UIWebView alloc] initWithFrame:self.view.frame];
    webView.scalesPageToFit=YES;
    NSURL* url=[NSURL fileURLWithPath:path];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [webFileViewController.view addSubview:webView];
    
    [self.navigationController pushViewController:webFileViewController animated:YES];
}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        if (_bTransform)
            return;
        
        for (FileCollectionViewCell *cell in [_filesListView visibleCells])
        {
            [cell showDelete:YES];
        }
        _bTransform = YES;
        [_tapGestureTel2 setEnabled:YES];
        [QHCommonUtil BeginWobble:_filesListView];
    }
}

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if(_bTransform==NO)
        return;
    
    for (FileCollectionViewCell *cell in [_filesListView visibleCells])
    {
        [cell showDelete:NO];
    }
    _bTransform = NO;
    [_tapGestureTel2 setEnabled:NO];
    [QHCommonUtil EndWobble:_filesListView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arFiles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    NSArray *ar = [[_arFiles objectAtIndex:indexPath.row] componentsSeparatedByString:@"."];
    NSString *name = [ar objectAtIndex:0];
    cell.iconTitleLabel.text = name;
    cell.delegate = self;
    if (ar.count > 1)
    {
        NSString *type = [ar objectAtIndex:1];
        cell.iconImageView.image = [self toImageForhead:type];
        if (_bTransform)
            cell.deleteView.hidden = NO;
        else
            cell.deleteView.hidden = YES;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_bTransform)
        return;
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSString *file = [_arFiles objectAtIndex:indexPath.row];
    [self openFile:file];
}

#pragma mark - UtilBottomControlDelegate

- (void)selectIndex:(NSUInteger)index
{
    switch (index)
    {
        case 1://wifi
        {
            WifiViewController *wifiVC = [[WifiViewController alloc] init];
            [self.navigationController pushViewController:wifiVC animated:YES];
            
            break;
        }
        case 5:
        {
            _bLine = !_bLine;
            [self showList];
            break;
        }
        default:
            break;
    }
}

#pragma mark = FileCollectionViewCellDelegate

- (void)deleteFileCell:(FileCollectionViewCell *)collectionViewCell
{
    NSString *appTitle = (NSString *)collectionViewCell.iconTitleLabel.text;
    QHDialogView *dialogV = [[QHDialogView alloc] initWithFrame:self.view.frame];
    [dialogV createDialogWithTitle:[NSString stringWithFormat:@"删除“%@”", appTitle] content:[NSString stringWithFormat:@"若删除“%@”，其所有数据也将被删除。", appTitle]];
    dialogV.sureBlock = ^(BOOL bSure)
    {
        NSIndexPath *indexPath = [_filesListView indexPathForCell:collectionViewCell];
        NSString *path = [QHFileHelper filePath:[_arFiles objectAtIndex:indexPath.row]];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSError *error;
        if(![fm removeItemAtPath:path error:&error])
        {
            NSLog(@"%@ can not be removed because:%@", path, error);
        }
        [_arFiles removeObjectAtIndex:indexPath.row];
        
        [_filesListView deleteItemsAtIndexPaths:@[indexPath]];
        [QHCommonUtil EndWobble:_filesListView];
        [QHCommonUtil BeginWobble:_filesListView];
    };
    [self.view addSubview:dialogV];
}


@end
