//
//  DK_TracerouteVC.m
//  Traceroute
//
//  Created by Bryan Yuan on 1/5/17.
//  Copyright © 2017 Bryan Yuan. All rights reserved.
//

#import "DK_TracerouteVC.h"
#import "NetworkTagsCollectionViewCell.h"
#import "TracerouteTagsDataSources.h"
#import "SimplePing.h"
#include <sys/socket.h>
#include <netdb.h>

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#define XY_TILT_COLOR  COLOR_WITH_HEX(0x005ead)

@interface DK_TracerouteVC ()  <SimplePingDelegate, UITextFieldDelegate>

@property BOOL isBegin;
@property NSDate *startDate;
@property (nonatomic , strong) SimplePing *traceRoute;
@property NSTimer *sendTimer;
@property NSTimer *sendTimeoutTimer;
@property TracerouteTagsDataSources *tagsDataSource;
@property NSInteger sendCountDown;
@property NSInteger sendTimeout;
@property NSInteger sendSequence;
@property int currentTTL;               // ttl increase from number 1
@property NSInteger packetCountPerTTL;  // per RTT, send out 3 packets

@property (nonatomic) UITextField *tagHostTextField;
@property (nonatomic) UITextField *tagTextField;
@property (nonatomic) NSString *ipAddress;
@property (nonatomic) NSString *icmpSrcAddress;


@end

static NSString *kTracertTagCellID = @"tracertTagCellID";
#define TRACERT_MAX_TTL 30
#define TRACERT_BUTTON_TITLE_START   @"Tracert"
#define TRACERT_BUTTON_TITLE_STOP  @"Stop"

@implementation DK_TracerouteVC

-(UITextField *)hostTextField
{
    if (!_hostTextField) {
        _hostTextField = [[UITextField alloc] init];
        _hostTextField.text = @"192.168.1.1";
        _hostTextField.textColor = [UIColor blackColor];
        _hostTextField.font = [UIFont systemFontOfSize:18];
    }
    return _hostTextField;
}

-(UIButton *)tracertButton
{
    if (!_tracertButton) {
        _tracertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tracertButton setTitle:@"Tracert" forState:UIControlStateNormal];
        [_tracertButton setTitle:@"Tracert" forState:UIControlStateHighlighted];
        _tracertButton.titleLabel.textColor = [UIColor whiteColor];
        [_tracertButton setBackgroundColor:XY_TILT_COLOR];
        [_tracertButton addTarget:self action:@selector(tracertButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _tracertButton;
}


- (void)tracertButtonClicked:(id)sender
{
    [self resignTextFirstResponder];
    
    NSString *host = self.hostTextField.text;
    if (!host || [host isEqualToString:@""]) {
        return;
    }
    
    if (self.traceRoute) {
        [self appendText:@"terminated"];
        [self stop];
    } else {
        [self clearTextView];
        [self start:host];
    }
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 70 + 88, [UIScreen mainScreen].bounds.size.width - 40, 76) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        _collectionView.allowsSelection = YES;
        _collectionView.userInteractionEnabled = YES;
        [_collectionView registerClass:[NetworkTagsCollectionViewCell class] forCellWithReuseIdentifier:kTracertTagCellID];

    }
    return _collectionView;
}

-(UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}


-(void)_setMainView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:self.hostTextField aboveSubview:self.view];
    [self.view insertSubview:self.tracertButton aboveSubview:self.view];
    [self.view insertSubview:self.collectionView aboveSubview:self.view];
    [self.view insertSubview:self.textView aboveSubview:self.view];
    
    
    self.hostTextField.frame  = CGRectMake(20, 20 +88, [UIScreen mainScreen].bounds.size.width - 140, 42);
    self.tracertButton.frame  = CGRectMake(CGRectGetMaxX(self.hostTextField.frame)+10, 20 +88, 100, 42);
//    self.collectionView.frame = CGRectMake(20, 70, [UIScreen mainScreen].bounds.size.width - 40, 76);
    self.textView.frame       = CGRectMake(20, CGRectGetMaxY(self.collectionView.frame)+20, [UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 120 - 120);

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self _setMainView];
    
//    [self.collectionView registerClass:[NetworkTagsCollectionViewCell class] forCellWithReuseIdentifier:kTracertTagCellID];
    self.tagsDataSource = [[TracerouteTagsDataSources alloc] init];
    self.title = TRACERT_BUTTON_TITLE_START;
    
    [self decorateUIs];
    
    [self.textView setSelectable:NO];
    self.hostTextField.delegate = self;
    self.hostTextField.keyboardType = UIKeyboardTypeASCIICapable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)confirmQuit
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)decorateUIs
{
    self.tracertButton.layer.cornerRadius = 15.0f;
    [self.tracertButton setBackgroundColor:XY_TILT_COLOR];
    
    UIImageView *leftHostImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 42, 42)];
    leftHostImageView.contentMode = UIViewContentModeCenter;
    UIImage *leftHostImage = [UIImage imageNamed:@"pingLoc"];
    [leftHostImageView setImage:leftHostImage];
    self.hostTextField.leftView = leftHostImageView;
    self.hostTextField.leftViewMode = UITextFieldViewModeAlways;
    self.hostTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}


- (void)pingerWillStart
{
    [self.tracertButton.titleLabel setText:TRACERT_BUTTON_TITLE_STOP];
    [self.tracertButton setTitle:TRACERT_BUTTON_TITLE_STOP forState:UIControlStateNormal];
}
- (void)pingerDidStop
{
    [self.tracertButton.titleLabel setText:TRACERT_BUTTON_TITLE_START];
    [self.tracertButton setTitle:TRACERT_BUTTON_TITLE_START forState:UIControlStateNormal];
}

- (void)start:(NSString *)host
{
    [self pingerWillStart];
    
    self.traceRoute = [[SimplePing alloc] initWithHostName:host];
    self.traceRoute.delegate = self;
    [self.traceRoute start];
}

- (void)stop
{
    [self.sendTimer invalidate];
    self.sendTimer = nil;
    [self.sendTimeoutTimer invalidate];
    self.sendTimeoutTimer = nil;
    
    [self.traceRoute stop];
    self.traceRoute = nil;
    
    [self pingerDidStop];
}
- (void)sendPingWithTTL:(int)ttl
{
    self.packetCountPerTTL = 0;
    
    [self.traceRoute setTTL:ttl];
    [self.traceRoute sendPingWithData:nil];
    
    self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(checkSingleRoundTimeout) userInfo:nil repeats:NO];
    
}

- (void)invalidSendTimer
{
    [self.sendTimer invalidate];
    self.sendTimer = nil;
}

- (void)checkSingleRoundTimeout
{
    NSString *msg;
    switch (self.packetCountPerTTL) {
        case 0:
            msg = [NSString stringWithFormat:@"#%ld *  *  *\n", (long)self.sendSequence];
            break;
        case 1:
            msg = [NSString stringWithFormat:@"  *  *\n"];
            break;
        case 2:
            msg = [NSString stringWithFormat:@"  *\n"];
            break;
            
        default:
            break;
    }
    [self appendText:msg];
    
    [self sendPing];
}

- (BOOL)sendPing
{
    NSLog(@"sendPing ttl %d", self.currentTTL);
    self.currentTTL += 1;
    if (self.currentTTL > TRACERT_MAX_TTL) {
        NSString *msg = [NSString stringWithFormat:@"TTL exceed the Max, stop the test"];
        [self appendText:msg];
        [self stop];
        return NO;
    }
    
    [self sendPingWithTTL:self.currentTTL];
    return YES;
}

- (void)resignTextFirstResponder
{
    [self.hostTextField resignFirstResponder];
}

- (void)clearTextView
{
    [self.textView setText:@""];
}


- (void)appendText:(NSString *)msg
{
    __weak DK_TracerouteVC *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.textView insertText:msg];
        [weakSelf.textView insertText:@"\n"];
        [weakSelf.textView setNeedsDisplay];
        
        NSRange visibleRange = NSMakeRange(weakSelf.textView.text.length-2, 1);
        [weakSelf.textView scrollRangeToVisible:visibleRange];
    });
}

- (void)appendTextInline:(NSString *)msg
{
    __weak DK_TracerouteVC *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.textView insertText:msg];
        [weakSelf.textView setNeedsDisplay];
        
        NSRange visibleRange = NSMakeRange(weakSelf.textView.text.length-2, 1);
        [weakSelf.textView scrollRangeToVisible:visibleRange];
    });
}

- (void)promptInputTag
{
    //__weak BackupAPInfoViewController *weakSelf = self;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Host/IP";
        textField.text = self.hostTextField.text;
        UIImageView *leftUserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        leftUserImageView.contentMode = UIViewContentModeCenter;
        UIImage *leftUserImage = [UIImage imageNamed:@"inputLoc"];
        [leftUserImageView setImage:leftUserImage];
        textField.leftView = leftUserImageView;
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.borderStyle = UITextBorderStyleNone;
        
        self.tagHostTextField = textField;
        self.tagHostTextField.delegate = self;
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Tag";
        UIImageView *leftUserImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        leftUserImageView.contentMode = UIViewContentModeCenter;
        UIImage *leftUserImage = [UIImage imageNamed:@"inputTag"];
        [leftUserImageView setImage:leftUserImage];
        textField.leftView = leftUserImageView;
        textField.leftViewMode = UITextFieldViewModeAlways;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        textField.borderStyle = UITextBorderStyleNone;
        
        self.tagTextField = textField;
    }];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    UIAlertAction* switchAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             [self tagConfirmButtonClicked:nil];
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:switchAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)tagConfirmButtonClicked:(id)sender
{
    NSLog(@"%s", __func__);
    NSString *host = self.tagHostTextField.text;
    NSString *tag = self.tagTextField.text;
    NSLog(@"tag %@", self.tagTextField.text);
    
    [self.tagsDataSource insertEntryWithTitle:tag host:host];
    [self.collectionView reloadData];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    #define NETWORKS_HOST_ALPHABATES @"0123456789-.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    NSCharacterSet *forbidCharSet = [[NSCharacterSet characterSetWithCharactersInString:NETWORKS_HOST_ALPHABATES] invertedSet];
    NSRange specialCharRange = [string rangeOfCharacterFromSet:forbidCharSet];
    if (NSNotFound != specialCharRange.location) {
        return NO;
    }
    
    return YES;
}

#pragma mark - SimplePingDelegate

- (NSString *)displayAddressForAddress:(NSData *)address
{
    
#define	NI_MAXHOST	1025
#define	NI_NUMERICHOST	0x00000002
    int         err;
    NSString *  result;
    char        hostStr[NI_MAXHOST];
    
    result = nil;
    
    if (address != nil) {
        err = getnameinfo(address.bytes, (socklen_t) address.length, hostStr, sizeof(hostStr), NULL, 0, NI_NUMERICHOST);
        if (err == 0) {
            result = @(hostStr);
        }
    }
    
    if (result == nil) {
        result = @"?";
    }
    
    return result;
}

- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
{
    NSLog(@"%s", __func__);
    self.ipAddress = [self displayAddressForAddress:address];
    NSLog(@"%@", self.ipAddress);
    NSString *msg = [NSString stringWithFormat:@"Tracert %@ (%@)\n", self.hostTextField.text, self.ipAddress];
    [self appendText:msg];
    
    self.currentTTL = 1; // init ttl
    [self sendPingWithTTL:self.currentTTL];
    
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error
{
    NSLog(@"%s", __func__);
    NSLog(@"%@\n%@\n%@", error, error.domain, error.userInfo);
    
    NSString *msg = [NSString stringWithFormat:@"Failed to resolve %@", self.hostTextField.text];
    [self appendText:msg];
    [self stop];
}

- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"%s", __func__);
    NSLog(@"#%u sent", sequenceNumber);
    self.sendSequence = sequenceNumber;
    self.startDate = [NSDate date];
}


- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error
{
    NSLog(@"%s", __func__);
    NSLog(@"%@ %d %@", packet, sequenceNumber, error);
}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber
{
    NSLog(@"%s", __func__);
    [self invalidSendTimer];
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    NSLog(@"Host responsed in %0.2lf ms", interval*1000);
    NSLog(@"#%u received, size=%zu", sequenceNumber, (unsigned long)packet.length);
    [self.sendTimeoutTimer invalidate];
    if (sequenceNumber != self.sendSequence) {
        return;
    }
    NSString *msg = [NSString stringWithFormat:@"#%u reach the destination %@, test completed", sequenceNumber, self.ipAddress];
    [self appendText:msg];
    
    [self stop];
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
{
    NSLog(@"%s", __func__);
    NSString *msg;
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    NSLog(@"Host responsed in %0.2lf ms", interval*1000);
    
    NSString *srcAddr = [self.traceRoute srcAddrInIPv4Packet:packet];
    if (0 == self.packetCountPerTTL) {
        self.icmpSrcAddress = srcAddr;
        self.packetCountPerTTL += 1;
        msg = [NSString stringWithFormat:@"#%ld %@   %0.2lfms", (long)self.sendSequence, self.icmpSrcAddress, interval*1000];
    } else {
        self.packetCountPerTTL += 1;
        msg = [NSString stringWithFormat:@" %0.2lfms", interval*1000];
    }
    
    [self appendTextInline:msg];
    
    if (3 == self.packetCountPerTTL) {
        [self invalidSendTimer];
        [self appendText:@"\n"];
        
        [self sendPing];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize collectionViewSize = collectionView.bounds.size;
    CGFloat width = collectionViewSize.width;
    CGFloat height = collectionViewSize.height;
    CGSize cellSize = CGSizeMake(width/5, height/3);
    return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 2);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 2);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.tagsDataSource count] + 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NetworkTagsCollectionViewCell *cell = (NetworkTagsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTracertTagCellID forIndexPath:indexPath];
    
    if (indexPath.row == self.tagsDataSource.count) {
        UIColor *defaultColor = [self.tagsDataSource colorAtIndex:NSUIntegerMax];
        UIColor *defaultBorderColor = [self.tagsDataSource borderColorAtIndex:NSUIntegerMax];
        [cell setLabelTitle:@"+" color:defaultColor borderColor:defaultBorderColor];
        //[cell setDottedBorder];
        return cell;
    }
    
    cell.backgroundColor = [UIColor redColor];
    NSString *cellTitle = [self.tagsDataSource titleAtIndex:indexPath.row];
    UIColor *cellColor = [self.tagsDataSource colorAtIndex:indexPath.row];
    UIColor *cellBorderColor = [self.tagsDataSource borderColorAtIndex:indexPath.row];
    [cell setLabelTitle:cellTitle color:cellColor borderColor:cellBorderColor];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)showError:(NSString *)msg
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %ld", __func__, (long)indexPath.row);
    if (indexPath.row == self.tagsDataSource.count) {
        if (7 == self.tagsDataSource.count) {
            [self showError:@"reach the max tags, cannot proceed"];
            return;
        }
        
        // prompt user to add tag
        if ([self.hostTextField.text length] <= 0) {
            [self showError:@"Please input destination address"];
            return;
        }
        [self promptInputTag];
        return;
    }
    
    [self.hostTextField setText:[self.tagsDataSource hostAtIndex:indexPath.row]];
}

@end
