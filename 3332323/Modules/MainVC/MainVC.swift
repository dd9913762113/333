//
//  MainVC.swift
//  3332323
//
//  Created by dd on 20/7/2021.
//

import UIKit
import Foundation
import Luminous
//import Swiftz
import RxSwift
import Kingfisher
import PhoneNumberKit

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
    var disposeBag: DisposeBag = .init()

    private var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true

        self.array = ["DownLoad", "SwiftDate 时间测试", "collectionview", "TVListVC",
                      "天女散花", "各种权限", "图片选择器",
                      "图文发布", "申请主播", "JitsiMeet 音视频在线会议",
                      "EFQRCode 二维码", "各大APP新闻页面\"样式\"", "视频背景，无限重播",
                      "ping 检查", "Traceroute路径", "网络下载测速",
                      "ping和traceroute，域名诊断，收集诊断日志", "浏览器上传文件到手机","网络数据缓存",
                      "pexels网络图片浏览器", "lottie-ios"]
        self.arrayVC = [DownLoadTabbar(), DK_SwiftDateVC(), MediaCollectionView(), TVListVC(),
                        PreviewController(), SPPermissionsVC(), WXZLPhoto(),
                        PublishPostVC(), MineApplyAnchorVC(), JitsiMeetVC(),
                        EFQRCodeVC(), TheNewsViewController(), DK_BackgroundVideo(),
                        PINGTest(), DK_TracerouteVC(), NetworksSpeedViewController(),
                        DKNetDiagnoServiceVC(), DK_SGWiFiUploadVC(), CacheLastDataViewController(),
                        ImageCollectionsVC(), DK_LottieTest()]
       
        
        self.setUpUI()
        
        self.showDeviceInfos()

    }
    
    func setUpUI() {
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
        tableView.rowHeight = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
        
        view.addSubview(thirdPartyReferView)
        view.addSubview(thirdPartyFriendInviteImageView)
        view.bringSubviewToFront(thirdPartyFriendInviteImageView)
       
        
        thirdPartyReferView.snp.makeConstraints { (make) in
            make.top.equalTo(-128)
            make.left.equalTo(13.7)
            make.right.equalTo(-13.7)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        thirdPartyFriendInviteImageView.snp.makeConstraints { (make) in
            make.right.equalTo(thirdPartyReferView)
            make.bottom.equalTo(thirdPartyReferView)
            make.width.equalTo(109)
            make.height.equalTo(104)
        }
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
    
    
    // 邀请好友悬浮球滚动范围
    lazy var thirdPartyReferView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = false
        return v
    }()
    /// 邀请好友悬浮球
    private lazy var thirdPartyFriendInviteImageView: UIImageView = {
        let im = UIImageView()
        im.isUserInteractionEnabled = true
        if let path = Bundle.main.path(forResource:"qst_thirdPartyFriendInvite", ofType:"gif") {
            let url = URL(fileURLWithPath: path)
            let provider = LocalFileImageDataProvider(fileURL: url)
            im.kf.setImage(with: provider)
        }
        
        let longTap = UIPanGestureRecognizer()
        im.addGestureRecognizer(longTap)
        
        longTap.rx.event.bind { [weak self] re in
           // 普通状态才可拖动
            guard let self = self else { return }
            
            let point = re.location(in: self.thirdPartyReferView)
            
            var endPointX: CGFloat = point.x

            var endPointY: CGFloat = point.y
            
            let half_width = im.frame.size.width/2
            
            let half_height = im.frame.size.height/2

            if re.state == .changed {

                if point.x < half_width {
                    endPointX = half_width
                }else if point.x > self.thirdPartyReferView.width - half_width {
                    endPointX = self.thirdPartyReferView.width - half_width
                }else {
                    endPointX = point.x
                }
                
                if point.y < half_height {
                    endPointY = half_height
                }else if point.y > self.thirdPartyReferView.height - half_height {
                    endPointY = self.thirdPartyReferView.height - half_height
                }else {
                    endPointY = point.y
                }

                im.snp.remakeConstraints({ make in
                    make.width.equalTo(109)
                    make.height.equalTo(104)
                    make.centerX.equalTo(endPointX+self.thirdPartyReferView.frame.minX)
                    make.centerY.equalTo(endPointY+self.thirdPartyReferView.frame.minY)
                })
            }
            
        }.disposed(by: disposeBag)
        
        let tap = UITapGestureRecognizer()
        im.addGestureRecognizer(tap)
        tap.rx.event.bind { [weak self] _ in
            guard let self = self else { return }
//            self.show_friendInviteWeb()
            DLog("悬浮球 点击了")
        }.disposed(by: self.disposeBag)
        return im
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func showDNSInfos ()
    {
//        type  A AAAA ALL CAA CNAME DNAME NAPTR NSEC3PARAM SOA TLSA
//    https://dns.google/resolve?name=baidu.com&type=A
//    https://dns.google/
        
    }
    
    
//    手机号码 和 国际区号 校验
    func isValidPhoneNumber(phoneNumber: String, countrieCodes: String) -> Bool {
           let phoneNumberKit = PhoneNumberKit()
           let countries = ["CN", "VN", "BR"]
   //        let countrieCodes = ["86", "84", "55"]
           let string = countrieCodes + phoneNumber
           for index in countries {
               do {
                   let phoneNumber4 = try phoneNumberKit.parse(string, withRegion: index)
   //                print("111111 \(phoneNumber4)")
                   print("111111 \(phoneNumber4.countryCode)")
                   if phoneNumber4.countryCode > 0  {
                       return true
                   } else {
                       return false
                   }
               }catch{
                   print("User creation failed with error: \(error)")
                   break
               }
           }
         return false
       }
    
    
    func showDeviceInfos() {
        
        let phoneNumber3 = "13987654321"
//            let phoneNumber3 = "936771362"
        let phoneNumber4 = "586072996" //越南
        
        let phoneNumber5 = "74772686"  //巴西
      
        let bool1 = self.isValidPhoneNumber(phoneNumber: phoneNumber3, countrieCodes: "86")
        print("111111111 bool1 = \(bool1)")
        let bool2 = self.isValidPhoneNumber(phoneNumber: phoneNumber3, countrieCodes: "84")
        print("111111111 bool2 = \(bool2)")
                                        
        let bool3 = self.isValidPhoneNumber(phoneNumber: phoneNumber4, countrieCodes: "+86")
        print("111111222 bool3 = \(bool3)")
        let bool4 = self.isValidPhoneNumber(phoneNumber: phoneNumber4, countrieCodes: "+84")
        print("111111222 bool4 = \(bool4)")
        
        let bool5 = self.isValidPhoneNumber(phoneNumber: phoneNumber5, countrieCodes: "+86")
        print("111111333 bool5 = \(bool5)")
        let bool6 = self.isValidPhoneNumber(phoneNumber: phoneNumber5, countrieCodes: "+84")
        print("111111333 bool6 = \(bool6)")
        let bool7 = self.isValidPhoneNumber(phoneNumber: phoneNumber5, countrieCodes: "55")
        print("111111333 bool7 = \(bool7)")
        
        
        // MARK: Network
        
        print("------------\nNetwork\n------------")
        print("isConnectedViaCellular: \(Luminous.Network.isConnectedViaCellular)")
        print("isConnectedViaWiFi: \(Luminous.Network.isConnectedViaWiFi)")
        print("SSID: \(Luminous.Network.SSID)")
        
        
        // MARK: Locale
        
        print("------------\nLocale\n------------")
        print("currentCountry: \(Luminous.Locale.currentCountry)")
        print("currentCurrency: \(Luminous.Locale.currentCurrency ?? "-")")
        print("currentCurrencySymbol: \(Luminous.Locale.currentCurrencySymbol ?? "-")")
        print("currentLanguage: \(Luminous.Locale.currentLanguage)")
        print("currentTimeZone: \(Luminous.Locale.currentTimeZone)")
        print("currentTimeZoneName: \(Luminous.Locale.currentTimeZoneName)")
        print("decimalSeparator: \(Luminous.Locale.decimalSeparator ?? "-")")
        print("usesMetricSystem: \(Luminous.Locale.usesMetricSystem)")
        
        
        // MARK: Carrier
        
        print("------------\nCarrier\n------------")
        print("allowsVOIP: \(Luminous.Carrier.isVoipAllowed ?? false)")
        print("ISOCountryCode: \(Luminous.Carrier.ISOCountryCode ?? "-")")
        print("mobileCountryCode: \(Luminous.Carrier.mobileCountryCode ?? "-")")
        print("name: \(Luminous.Carrier.name ?? "-")")
        print("networkCountryCode: \(Luminous.Carrier.mobileNetworkCode ?? "-")")
        
        
        // MARK: Hardware
        
        print("------------\nHardware\n------------")
        print("bootTime: \(Luminous.Hardware.bootTime)")
        print("bootTime: \(Luminous.Hardware.physicalMemory(with: Luminous.MeasureUnit.megabytes))")
        print("processorsNumber: \(Luminous.Hardware.processorsNumber)")
        print("systemName: \(Luminous.Hardware.systemName)")
        print("systemVersion: \(Luminous.Hardware.systemVersion)")
        if #available(iOS 9.0, *) {
            print("isLowPowerModeEnabled: \(Luminous.Hardware.isLowPowerModeEnabled)")
        }
        
        
        // MARK: Hardware - Screen
        
        print("------------\nScreen\n------------")
        print("bounds: \(Luminous.Hardware.Screen.bounds)")
        print("brightness: \(Luminous.Hardware.Screen.brightness)")
        print("isScreenMirrored: \(Luminous.Hardware.Screen.isScreenMirrored)")
        print("nativeBounds: \(Luminous.Hardware.Screen.nativeBounds)")
        print("nativeScale: \(Luminous.Hardware.Screen.nativeScale)")
        print("bounds: \(Luminous.Hardware.Screen.scale)")
//        print("snapshotOfCurrentView: \(Luminous.Hardware.Screen.snapshotOfCurrentView())")
        
        
        // MARK: Hardware - Device
        
        print("------------\nDevice\n------------")
        print("current: \(Luminous.Hardware.Device.identifierForVendor)")
        print("identifierForVendor: \(Luminous.Hardware.Device.identifierForVendor ?? "-")")
        print("orientation: \(Luminous.Hardware.Device.orientation)")
        
        
        // MARK: Hardware - Accessory
        
        print("------------\nAccessory\n------------")
        print("connectedAccessories: \(Luminous.Hardware.Accessory.connectedAccessories)")
        print("connectedAccessoriesNames: \(Luminous.Hardware.Accessory.connectedAccessoriesNames)")
        print("count: \(Luminous.Hardware.Accessory.count)")
        print("isHeadsetPluggedIn: \(Luminous.Hardware.Accessory.isHeadsetPluggedIn)")
        
        
        // MARK: Hardware - Sensors
        
        print("------------\nSensors\n------------")
        print("isAccelerometerAvailable : \(Luminous.Hardware.Sensors.isAccelerometerAvailable)")
        print("isGyroAvailable : \(Luminous.Hardware.Sensors.isGyroAvailable)")
        print("isMagnetometerAvailable : \(Luminous.Hardware.Sensors.isMagnetometerAvailable)")
        print("isDeviceMotionAvailable : \(Luminous.Hardware.Sensors.isDeviceMotionAvailable)")
        
        
        // MARK: Audio
        
        print("------------\nAudio\n------------")
        print("currentAudioOutputVolume : \(Luminous.Audio.currentAudioOutputVolume ?? -1.0)")
        print("secondaryAudioShouldBeSilencedHint : \(Luminous.Audio.secondaryAudioShouldBeSilencedHint)")
        
        
        // MARK: Disk
        
        print("------------\nDisk\n------------")
        print("freeSpace: \(Luminous.Disk.freeSpace)")
        print("freeSpaceInBytes: \(Luminous.Disk.freeSpaceInBytes)")
        print("totalSpace: \(Luminous.Disk.totalSpace)")
        print("totalSpaceInBytes: \(Luminous.Disk.totalSpaceInBytes)")
        print("usedSpace: \(Luminous.Disk.usedSpace)")
        print("usedSpaceInBytes: \(Luminous.Disk.usedSpaceInBytes)")
        print("freeSpaceInPercentage: \(Luminous.Disk.freeSpaceInPercentage)%")
        print("usedSpaceInPercentage: \(Luminous.Disk.usedSpaceInPercentage)%")
        
        
        // MARK: Battery
        
        print("------------\nBattery\n------------")
        print("level: \(Luminous.Battery.level ?? -1)")
        print("state: \(Luminous.Battery.state)")
        
        
        // MARK: Application
        
        print("------------\nApplication\n------------")
        print("clipboardString: \(Luminous.Application.clipboardString ?? "-")")
        print("version: \(Luminous.Application.version)")
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
