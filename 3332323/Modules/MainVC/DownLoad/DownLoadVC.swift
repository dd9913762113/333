//
//  DownLoadVC.swift
//  3332323
//
//  Created by dd on 24/7/2021.
//

import Foundation
import UIKit
import Tiercel


class DownLoadVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    static let reuseIdentifier = "DownLoadVCIdentifier"

    var sessionManager = DownloadManager.shared.sessionManager
    
    private var array = [mediaResModel]()
    private var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 检查磁盘空间
//        let free = UIDevice.current.tr.freeDiskSpaceInBytes / 1024 / 1024
//        print("手机剩余储存空间为： \(free)MB")
       
        sessionManager.logger.option = .default
        
//        self.array = DownloadManager.shared.downloadList

//        getJsonModel()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 164

        tableView.register(DownloadTaskCell.self, forCellReuseIdentifier: DownLoadVC.reuseIdentifier)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
//        tableView.reloadData()
        
        configureNavigationItem()
        setupManager()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        updateUI()
//        tableView.reloadData()
        DownloadManager.shared.getDownLoadsBlock { result in
            self.array = result
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configureNavigationItem() {
        let editingItem = UIBarButtonItem(title: tableView.isEditing ? "完成" : "编辑",
                                          style: .plain,
                                          target: self,
                                          action: #selector(toggleEditing))
        navigationItem.rightBarButtonItems = [editingItem]
    }
    
    @objc func toggleEditing() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        configureNavigationItem()
    }

    func updateUI() {
//        totalTasksLabel.text = "总任务：\(sessionManager.succeededTasks.count)/\(sessionManager.tasks.count)"
//        totalSpeedLabel.text = "总速度：\(sessionManager.speedString)"
//        timeRemainingLabel.text = "剩余时间： \(sessionManager.timeRemainingString)"
//        let per = String(format: "%.2f", sessionManager.progress.fractionCompleted)
//        totalProgressLabel.text = "总进度： \(per)"
    }
    
    func updateSwicth() {
//        taskLimitSwitch.isOn = sessionManager.configuration.maxConcurrentTasksLimit < 3
//        cellularAccessSwitch.isOn = sessionManager.configuration.allowsCellularAccess
    }

    
    func setupManager() {

        // 设置manager的回调
        sessionManager.progress { [weak self] (manager) in
            self?.updateUI()
            
        }.completion { [weak self] (task) in
            self?.updateUI()
            if task.status == .succeeded {
                // 下载成功
                print("所有任务下载完成")

            } else {
                // 其他状态
            }
        }
        
        sessionManager.tasks.first {
            $0.status == .running
        
        }
    }
    
    
    
    
    // MARK: - Table View
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DownLoadVC.reuseIdentifier, for: indexPath) as! DownloadTaskCell
        cell.setCellData(model: array[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let string = self.array[indexPath.row]
        
        if indexPath.row == 0 {
//           let   controller = MediaCollectionView()
//            navigationController?.pushViewController(controller, animated: true)
        }else{
        
        }
      
    }
    
    // 由于cell是循环利用的，不在可视范围内的cell，不应该去更新cell的状态
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let task = sessionManager.tasks.safeObject(at: indexPath.row) else { return }

        task.progress { _ in }.success { _ in } .failure { _ in }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let task = sessionManager.tasks.safeObject(at: indexPath.row) else { return }
            sessionManager.remove(task, completely: false) { [weak self] _ in
                self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.updateUI()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        sessionManager.moveTask(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
 
    // 每个cell中的状态更新，应该在willDisplay中执行
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let task = sessionManager.tasks.safeObject(at: indexPath.row),
            let cell = cell as? DownloadTaskCell else { return }
                
        
        let model = array[indexPath.row]
        if ((model.videos.first?.elementsEqual(task.fileName)) != nil) {
            cell.titleLabel.text = model.title
            debugPrint( "********************************************")
            debugPrint( task.fileName )
            debugPrint( task.url )
            
            debugPrint( model.title as Any )
            debugPrint( model.videos.first as Any )
            debugPrint( "********************************************")

        }else{
            cell.titleLabel.text = task.fileName
        }
        cell.updateProgress(task)

        // task的闭包引用了cell，所以这里的task要用weak
        cell.tapClosure = { [weak self] cell in
            guard let indexPath = self?.tableView.indexPath(for: cell),
                let task = self?.sessionManager.tasks.safeObject(at: indexPath.row)
                else { return }
            switch task.status {
            case .waiting, .running:
                self?.sessionManager.suspend(task)
            case .suspended, .failed:
                self?.sessionManager.start(task)
            default: break
            }
        }

        task.progress { [weak cell] (task) in
                cell?.updateProgress(task)
            }
            .success { [weak cell] (task) in
                cell?.updateProgress(task)
                // 下载任务成功了

            }
            .failure { [weak cell] (task) in
                cell?.updateProgress(task)
                if task.status == .suspended {
                    // 下载任务暂停了
                }

                if task.status == .failed {
                    // 下载任务失败了
                }
                if task.status == .canceled {
                    // 下载任务取消了
                }
                if task.status == .removed {
                    // 下载任务移除了
                }
            }
    }
    
    
    
    
    
    
    
    func getJsonModel () {
        
        guard let path = Bundle.main.path(forResource: "333333", ofType: "json") else { return }
        let localData = NSData.init(contentsOfFile: path)! as Data
        do {
            let banner = try JSONDecoder().decode(multimediaModel.self, from: localData)
            self.array = banner.list
        } catch {
            debugPrint(error)
            debugPrint("banner===ERROR")
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
}
