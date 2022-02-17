//
//  DownloadManager.swift
//  3332323
//
//  Created by dd on 27/7/2021.
//

import Foundation
import UIKit

import Tiercel
import KeychainAccess



class DownloadManager: NSObject {
    public let Defaults = UserDefaults.standard
    public static let shared = DownloadManager()
    
    let downloadKey : String = "downloadKey"
    let sessionManager1 = SessionManager("ViewController1", configuration: SessionConfiguration())

    var sessionManager: SessionManager = {
        var configuration = SessionConfiguration()
        configuration.allowsCellularAccess = true
        configuration.maxConcurrentTasksLimit = 3
        let path = Cache.defaultDiskCachePathClosure("MiTao")
        let cacahe = Cache("ViewController2", downloadPath: path)
        let manager = SessionManager("ViewController2", configuration: configuration, cache: cacahe, operationQueue: DispatchQueue(label: "com.Tiercel.SessionManager.operationQueue"))
        return manager
    }()
    var downloadList = [mediaResModel]()
    
    
    override init() {
        
        super.init()
        self.getDownLoads()
        
    }
    
    public func downloadBackground (_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void)
    {
        let downloadManagers = [sessionManager1 , sessionManager]
        for manager in downloadManagers {
            if manager.identifier == identifier {
                manager.completionHandler = completionHandler
                break
            }
        }
    }
    

    
}

//MARK: 增删改查
extension DownloadManager
{
    private var filePath: String {
         let manager = FileManager.default
         let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
         print("this is the url path in the documentDirectory \(String(describing: url))")
         return (url!.appendingPathComponent("Data").path)
     }
     

    func getDownLoads()
     {
        
        MTCacheManager.sharedInstance.getObjectsForKey(downloadKey) { (result :[mediaResModel]?) in
            guard let model = result else{
                print("获取失败了")
                self.downloadList = [mediaResModel]()
                return
            }
            self.downloadList = model
        }
         
     }
    
    func getDownLoadsBlock(completionHandler: @escaping ([mediaResModel])->()){
        MTCacheManager.sharedInstance.getObjectsForKey(downloadKey) { (result :[mediaResModel]?) in
            guard let model = result else{
                print("获取失败了")
                self.downloadList = [mediaResModel]()
                return
            }
            self.downloadList = model
            completionHandler(model)
        }
    }
    
     
     func setDownloads(model : mediaResModel)
     {
        
        if self.downloadList.contains(where: {$0.id == model.id})
        {
//          需要修改吗？
            return
        }else{
            
//            self.downloadList.insert(model, at: 0)
            self.downloadList.append(model)
            MTCacheManager.sharedInstance.setObject(self.downloadList, forKey: downloadKey)
         }
     }
    
    func removeDownLoads(model : mediaResModel) -> Bool {
        if self.downloadList.contains(where: {$0.id == model.id})
        {
            guard let index = self.downloadList.firstIndex(where: { $0.id == model.id }) else { return false }
            var array =  self.downloadList
            array.remove(at: index)
            self.downloadList = array
            MTCacheManager.sharedInstance.setObject(self.downloadList, forKey: downloadKey)
            return true
        }else{
            return false
        }
    }
    
}
