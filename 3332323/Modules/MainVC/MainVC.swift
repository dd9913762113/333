//
//  MainVC.swift
//  3332323
//
//  Created by dd on 20/7/2021.
//

import UIKit
import Foundation
import Luminous

//import KSPlayer

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
                      "EFQRCode 二维码","各大APP新闻页面\"样式\"","视频背景，无限重播"]
        self.arrayVC = [DownLoadTabbar(), MediaCollectionView(), TVListVC(),
                        PreviewController(), SPPermissionsVC(), WXZLPhoto(),
                        PublishPostVC(),MineApplyAnchorVC(),JitsiMeetVC(),
                        EFQRCodeVC(),TheNewsViewController(),DK_BackgroundVideo()]
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
    
    
    
    func showDeviceInfos ()
    {
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
        print("current: \(Luminous.Hardware.Device.current)")
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
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
