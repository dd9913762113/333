//
//  MainVC.swift
//  3332323
//
//  Created by dd on 20/7/2021.
//

import UIKit
import Foundation
import Luminous


private class TableViewCell: UITableViewCell {
    var nameLabel: UILabel
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MainVC: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    var array = [String]()
    var arrayVC = [UIViewController]()
    
    private var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
      
        self.array = ["DownLoad", "collectionview", "TVListVC",
                      "天女散花", "各种权限", "图片选择器",
                      "图文发布", "申请主播","JitsiMeet 音视频在线会议",
                      "EFQRCode 二维码","各大APP新闻页面\"样式\"","视频背景，无限重播",
                      "ping 检查","Traceroute路径","网络下载测速",
                      "ping和traceroute，域名诊断，收集诊断日志","浏览器上传文件到手机","网络数据缓存",
                      "pexels网络图片浏览器"]
        self.arrayVC = [DownLoadTabbar(), MediaCollectionView(), TVListVC(),
                        PreviewController(), SPPermissionsVC(), WXZLPhoto(),
                        PublishPostVC(),MineApplyAnchorVC(),JitsiMeetVC(),
                        EFQRCodeVC(),TheNewsViewController(),DK_BackgroundVideo(),
                        PINGTest(),DK_TracerouteVC(),NetworksSpeedViewController(),
                        DKNetDiagnoServiceVC(),DK_SGWiFiUploadVC(),CacheLastDataViewController(),
                        ImageCollectionsVC()]
        tableView.rowHeight = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
        
        self.showDeviceInfos()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let cell = cell as? TableViewCell {
            cell.nameLabel.text = array[indexPath.row]
        }
        return cell
    }

   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        if #available(iOS 14.0, *) {
//            let controller = PreviewController().wrapToNavigationController(prefersLargeTitles: false)
//        }
        if indexPath.row == 0 {
            let tabBar = DownLoadTabbar()
            if #available(iOS 13, *) {
                tabBar.modalPresentationStyle = .fullScreen
            }
            self.present(tabBar, animated: true, completion: nil)
            return
        }
        
        let controller = self.arrayVC[indexPath.row]

        navigationController?.pushViewController(controller, animated: true)

      
    }
    
    
    func showDNSInfos ()
    {
//        type  A AAAA ALL CAA CNAME DNAME NAPTR NSEC3PARAM SOA TLSA
//    https://dns.google/resolve?name=baidu.com&type=A
//    https://dns.google/
        
    }
    
    
    func showDeviceInfos ()
    {
        // MARK: Network
        
//        print("------------\nNetwork\n------------")
//        print("isConnectedViaCellular: \(Luminous.Network.isConnectedViaCellular)")
//        print("isConnectedViaWiFi: \(Luminous.Network.isConnectedViaWiFi)")
//        print("SSID: \(Luminous.Network.SSID)")
//        
//        
//        // MARK: Locale
//        
//        print("------------\nLocale\n------------")
//        print("currentCountry: \(Luminous.Locale.currentCountry)")
//        print("currentCurrency: \(Luminous.Locale.currentCurrency ?? "-")")
//        print("currentCurrencySymbol: \(Luminous.Locale.currentCurrencySymbol ?? "-")")
//        print("currentLanguage: \(Luminous.Locale.currentLanguage)")
//        print("currentTimeZone: \(Luminous.Locale.currentTimeZone)")
//        print("currentTimeZoneName: \(Luminous.Locale.currentTimeZoneName)")
//        print("decimalSeparator: \(Luminous.Locale.decimalSeparator ?? "-")")
//        print("usesMetricSystem: \(Luminous.Locale.usesMetricSystem)")
//        
//        
//        // MARK: Carrier
//        
//        print("------------\nCarrier\n------------")
//        print("allowsVOIP: \(Luminous.Carrier.isVoipAllowed ?? false)")
//        print("ISOCountryCode: \(Luminous.Carrier.ISOCountryCode ?? "-")")
//        print("mobileCountryCode: \(Luminous.Carrier.mobileCountryCode ?? "-")")
//        print("name: \(Luminous.Carrier.name ?? "-")")
//        print("networkCountryCode: \(Luminous.Carrier.mobileNetworkCode ?? "-")")
//        
//        
//        // MARK: Hardware
//        
//        print("------------\nHardware\n------------")
//        print("bootTime: \(Luminous.Hardware.bootTime)")
//        print("bootTime: \(Luminous.Hardware.physicalMemory(with: Luminous.MeasureUnit.megabytes))")
//        print("processorsNumber: \(Luminous.Hardware.processorsNumber)")
//        print("systemName: \(Luminous.Hardware.systemName)")
//        print("systemVersion: \(Luminous.Hardware.systemVersion)")
//        if #available(iOS 9.0, *) {
//            print("isLowPowerModeEnabled: \(Luminous.Hardware.isLowPowerModeEnabled)")
//        }
//        
//        
//        // MARK: Hardware - Screen
//        
//        print("------------\nScreen\n------------")
//        print("bounds: \(Luminous.Hardware.Screen.bounds)")
//        print("brightness: \(Luminous.Hardware.Screen.brightness)")
//        print("isScreenMirrored: \(Luminous.Hardware.Screen.isScreenMirrored)")
//        print("nativeBounds: \(Luminous.Hardware.Screen.nativeBounds)")
//        print("nativeScale: \(Luminous.Hardware.Screen.nativeScale)")
//        print("bounds: \(Luminous.Hardware.Screen.scale)")
////        print("snapshotOfCurrentView: \(Luminous.Hardware.Screen.snapshotOfCurrentView())")
//        
//        
//        // MARK: Hardware - Device
//        
//        print("------------\nDevice\n------------")
//        print("current: \(Luminous.Hardware.Device.current)")
//        print("identifierForVendor: \(Luminous.Hardware.Device.identifierForVendor ?? "-")")
//        print("orientation: \(Luminous.Hardware.Device.orientation)")
//        
//        
//        // MARK: Hardware - Accessory
//        
//        print("------------\nAccessory\n------------")
//        print("connectedAccessories: \(Luminous.Hardware.Accessory.connectedAccessories)")
//        print("connectedAccessoriesNames: \(Luminous.Hardware.Accessory.connectedAccessoriesNames)")
//        print("count: \(Luminous.Hardware.Accessory.count)")
//        print("isHeadsetPluggedIn: \(Luminous.Hardware.Accessory.isHeadsetPluggedIn)")
//        
//        
//        // MARK: Hardware - Sensors
//        
//        print("------------\nSensors\n------------")
//        print("isAccelerometerAvailable : \(Luminous.Hardware.Sensors.isAccelerometerAvailable)")
//        print("isGyroAvailable : \(Luminous.Hardware.Sensors.isGyroAvailable)")
//        print("isMagnetometerAvailable : \(Luminous.Hardware.Sensors.isMagnetometerAvailable)")
//        print("isDeviceMotionAvailable : \(Luminous.Hardware.Sensors.isDeviceMotionAvailable)")
//        
//        
//        // MARK: Audio
//        
//        print("------------\nAudio\n------------")
//        print("currentAudioOutputVolume : \(Luminous.Audio.currentAudioOutputVolume ?? -1.0)")
//        print("secondaryAudioShouldBeSilencedHint : \(Luminous.Audio.secondaryAudioShouldBeSilencedHint)")
//        
//        
//        // MARK: Disk
//        
//        print("------------\nDisk\n------------")
//        print("freeSpace: \(Luminous.Disk.freeSpace)")
//        print("freeSpaceInBytes: \(Luminous.Disk.freeSpaceInBytes)")
//        print("totalSpace: \(Luminous.Disk.totalSpace)")
//        print("totalSpaceInBytes: \(Luminous.Disk.totalSpaceInBytes)")
//        print("usedSpace: \(Luminous.Disk.usedSpace)")
//        print("usedSpaceInBytes: \(Luminous.Disk.usedSpaceInBytes)")
//        print("freeSpaceInPercentage: \(Luminous.Disk.freeSpaceInPercentage)%")
//        print("usedSpaceInPercentage: \(Luminous.Disk.usedSpaceInPercentage)%")
//        
//        
//        // MARK: Battery
//        
//        print("------------\nBattery\n------------")
//        print("level: \(Luminous.Battery.level ?? -1)")
//        print("state: \(Luminous.Battery.state)")
//        
//        
//        // MARK: Application
//        
//        print("------------\nApplication\n------------")
//        print("clipboardString: \(Luminous.Application.clipboardString ?? "-")")
//        print("version: \(Luminous.Application.version)")
    }
    
    
}








/**
 

 
 // 传入正确的 identifier 去作为检查目标
     [[MobileProvisionInfo shareInstance] checkAndProtectWithAppIdentifier:@"xxxxxxx"];
 
 
 
 
 //
 //  MobileProvisionInfo.h
 //
 //  Created by eric on 2019/6/22.
 //
 
 #import <Foundation/Foundation.h>

 NS_ASSUME_NONNULL_BEGIN

 /**
  iOS 安全防护之重签名防护，通过读取 embedded.mobileprovision ，取出里面相关信息比较
  注意：
  embedded.mobileprovision
  1、在 App Store 下载的 App 中不会存在，
  2、在模拟器 build 包也不会存在
  */
 @interface MobileProvisionInfo : NSObject

 + (instancetype)shareInstance;

 /**
  通过传入真实 AppIdentifier 来检查包是否为重签名的包
  */
 - (void)checkAndProtectWithAppIdentifier:(NSString *)appID;

 /**
  com.apple.developer.team-identifier
  @return team identifier
  */
 - (NSString *)getTeamIdentifier;

 /**
  application-identifier
  @return app identifier
  */
 - (NSString *)getAppIdentifier;

 /**
  com.apple.security.application-groups
  @return group id
  */
 - (NSString *)getGroupIdentifier;

 /**
  bunlde Identifier 与 AppIdentifier 区别是少个 team 头
  @return bundle id
  */
 - (NSString *)getBundleIdentifier;

 @end

 NS_ASSUME_NONNULL_END
 
 
 
 
 
 

 //
 //  MobileProvisionInfo.m
 //
 //  Created by eric on 2019/6/22.
 //

 #import "MobileProvisionInfo.h"

 @interface MobileProvisionInfo ()

 @property (nonatomic, strong) NSString *teamID;
 @property (nonatomic, strong) NSString *appID;
 @property (nonatomic, strong) NSString *groupID;
 @property (nonatomic, strong) NSString *bundleID;

 @end

 @implementation MobileProvisionInfo

 + (instancetype)shareInstance {
     static MobileProvisionInfo *_instance = nil;
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
         _instance = [[MobileProvisionInfo alloc] init];
         [_instance read];
     });
     return _instance;
 }

 #pragma mark - Private Methods

 - (void)read {
     // 读取 ipa 包中的 embedded.mobileprovision 文件内容, 真实内容是 xml 格式
     // 描述文件路径
     NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
     // 读取application-identifier 注意描述文件的编码要使用:NSASCIIStringEncoding
     NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
     NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
     for (int i = 0; i < embeddedProvisioningLines.count; i++) {
         if ([embeddedProvisioningLines[i] rangeOfString:@"com.apple.security.application-groups"].location != NSNotFound) {
             // application-identifier
             NSInteger fromPosition = [embeddedProvisioningLines[i + 2] rangeOfString:@"<string>"].location + 8;
             NSInteger toPosition = [embeddedProvisioningLines[i + 2] rangeOfString:@"</string>"].location;

             NSRange range;
             range.location = fromPosition;
             range.length = toPosition - fromPosition;

             NSString *group = [embeddedProvisioningLines[i + 2] substringWithRange:range];
             self.groupID = group;
         } else if ([embeddedProvisioningLines[i] rangeOfString:@"application-identifier"].location != NSNotFound) {
             // com.apple.security.application-groups
             NSInteger fromPosition = [embeddedProvisioningLines[i + 1] rangeOfString:@"<string>"].location + 8;
             NSInteger toPosition = [embeddedProvisioningLines[i + 1] rangeOfString:@"</string>"].location;

             NSRange range;
             range.location = fromPosition;
             range.length = toPosition - fromPosition;

             self.appID = [embeddedProvisioningLines[i + 1] substringWithRange:range];
             NSArray *identifierComponents = [self.appID componentsSeparatedByString:@"."];
             self.teamID = [identifierComponents firstObject];
             NSString *replaceStr = [NSString stringWithFormat:@"%@.", self.teamID];
             self.bundleID = [self.appID stringByReplacingOccurrencesOfString:replaceStr withString:@""];
         }

         if (self.teamID.length > 0 && self.appID.length > 0 && self.groupID.length > 0) {
             break;
         }
     }
 }

 #pragma mark - Public Methods

 - (void)checkAndProtectWithAppIdentifier:(NSString *)appID {
     // 对比签名ID
     if (![self.appID isEqual:appID] && appID.length > 0) {
         //exit
         exit(1);
     }
 }

 #pragma mark - Getter

 - (NSString *)getTeamIdentifier {
     return self.teamID;
 }

 - (NSString *)getAppIdentifier {
     return self.appID;
 }

 - (NSString *)getGroupIdentifier {
     return self.groupID;
 }

 - (NSString *)getBundleIdentifier {
     return self.bundleID;
 }

 @end
 
 
 
 */
