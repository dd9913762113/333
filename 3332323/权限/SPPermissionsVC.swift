//
//  SPPermissionsVC.swift
//  3332323
//
//  Created by dd on 29/7/2021.
//

import Foundation
import UIKit
import SparrowKit

import SPPermissions
//import SPPermissionsCamera
//import SPPermissionsPhotoLibrary
//import SPPermissionsNotification
//import SPPermissionsMicrophone
//import SPPermissionsCalendar
//import SPPermissionsContacts
//import SPPermissionsReminders
//import SPPermissionsSpeechRecognizer
//import SPPermissionsLocationWhenInUse
//import SPPermissionsLocationAlways
//import SPPermissionsMotion
//import SPPermissionsMusic
//import SPPermissionsBluetooth
//import SPPermissionsTracking
//import SPPermissionsFaceID
//import SPPermissionsSiri
//import SPPermissionsHealth


class SPPermissionsVC: SPTableViewController {
    
    var availablePermissions: [SPPermissions.Permission] = [.camera, .photoLibrary, .notification, .microphone, .calendar, .contacts, .reminders, .speech, .locationWhenInUse, .locationAlways, .motion, .mediaLibrary, .bluetooth, /*.tracking,*/ /*.faceID,*/ .siri, .health]
    
    var selectedPermissions: [SPPermissions.Permission] = []
    
    // MARK: Init
    
    init() {
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .plain)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose Style"
        
        // Available styles: List, Dialog & Native.
        let segmentedControl = UISegmentedControl(items: ["List", "Dialog", "Native"])
        navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .play, target: self, action: #selector(self.requestPermissions))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: Actions
    
    @objc func requestPermissions() {
        if selectedPermissions.isEmpty { return }
        guard let segmentControl = navigationItem.titleView as? UISegmentedControl else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let controller = SPPermissions.list(selectedPermissions)
            controller.dataSource = self
            controller.delegate = self
            controller.present(on: self)
        case 1:
            let controller = SPPermissions.dialog(selectedPermissions)
            controller.dataSource = self
            controller.delegate = self
            // controller.allowSwipeDismiss = true
            // controller.showCloseButton = true
            controller.present(on: self)
        case 2:
            let controller = SPPermissions.native(selectedPermissions)
            controller.delegate = self
            // controller.allowSwipeDismiss = true
            // controller.showCloseButton = true
            controller.present(on: self)
        default:
            break
        }
    }
}

// MARK: - SPPermissions Data Source

extension SPPermissionsVC: SPPermissionsDataSource {
    
    func configure(_ cell: SPPermissionsTableViewCell, for permission: SPPermissions.Permission) {

        // Here you can customise cell, like texts or colors.
        
        /*
        cell.permissionTitleLabel.text = "Title"
        cell.permissionDescriptionLabel.text = "Description"
        */
        
        // If you need change icon, choose one of this:
        
        /*
        cell.permissionIconView.setPermissionType(.bluetooth)
        cell.permissionIconView.setCustomImage(UIImage.init(named: "custom-name"))
        cell.permissionIconView.setCustomView(YourView())
        */
    }
    
    func deniedAlertTexts(for permission: SPPermissions.Permission) -> SPPermissionsDeniedAlertTexts? {
        // You can create custom texts
        
        /*
         let texts = SPPermissionDeniedAlertTexts()
         texts.titleText = "Permission denied"
         texts.descriptionText = "Please, go to Settings and allow permission."
         texts.actionText = "Settings"
         texts.cancelText = "Cancel"
         return texts
         */
        
        // or use default texts.
        
        return .default
        
        // For hide alert, simple return nil.
        // return nil
    }
}

// MARK: - SPPermissions Delegate

extension SPPermissionsVC: SPPermissionsDelegate {
    
    func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        print("Example App: did hide with permissions", permissions.map { $0.debugName })
    }
    
    func didAllowPermission(_ permission: SPPermissions.Permission) {
        print("Example App: did allow", permission.debugName)
    }
    
    func didDeniedPermission(_ permission: SPPermissions.Permission) {
        print("Example App: did denied", permission.debugName)
    }
}


// MARK: - Table Data Source & Delegate
extension SPPermissionsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availablePermissions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let permission = availablePermissions[indexPath.row]
        cell.textLabel?.text = permission.localisedName
        cell.accessoryType = selectedPermissions.contains(permission) ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let permission = availablePermissions[indexPath.row]
        if selectedPermissions.contains(permission)  {
            cell?.accessoryType = .none
            selectedPermissions = selectedPermissions.filter { $0 != permission }
        } else {
            cell?.accessoryType = .checkmark
            selectedPermissions.append(permission)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose permissions"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "All need keys added. When you add `SPPermissions` to your project, need add some keys in Info.plist. See Readme.md for details."
    }
}
