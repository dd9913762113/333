//
//  DownLoadListVC.swift
//  3332323
//
//  Created by dd on 25/7/2021.
//

import Foundation
import UIKit


private class DownLoadListCell: UITableViewCell {
    
    var changeBlock: ((DownLoadListCell) -> Void)?

    private var nameLabel = UILabel()
    private var downLoadBtn = UIButton()
//    private let downLoadBtn: UIButton = {
//        let btn =  UIButton(type: .custom)
//        btn.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 18)
//        btn.setTitleColor(UIColor.Color_6B6060, for: .normal)
//        btn.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
////        btn.setTitleColor(UIColor.Color_6B6060.withAlphaComponent(0.3), for: .disabled)
//        btn.setTitle("下载", for: .normal)
//        btn.setTitle("正在下载...", for: .selected)
//        btn.isUserInteractionEnabled = true
//        btn.addTarget(self, action: #selector(downLoadBtnPressed(_:)), for: .touchUpInside)
//        return btn
//    }()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DownLoadListCell
{
    func initSubviews() {
        self.nameLabel = UILabel()
        
        self.downLoadBtn =  UIButton(type: .custom)
        self.downLoadBtn.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 18)
        self.downLoadBtn.setTitleColor(UIColor.Color_6B6060, for: .normal)
        self.downLoadBtn.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
//        btn.setTitleColor(UIColor.Color_6B6060.withAlphaComponent(0.3), for: .disabled)
        self.downLoadBtn.setTitle("下载", for: .normal)
        self.downLoadBtn.setTitle("正在下载...", for: .selected)
        self.downLoadBtn.isUserInteractionEnabled = true
        self.downLoadBtn.addTarget(self, action: #selector(downLoadBtnPressed(_:)), for: .touchUpInside)
        
        contentView.insertSubview(self.nameLabel, aboveSubview: contentView)
        contentView.insertSubview(self.downLoadBtn, aboveSubview: contentView)

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(44)
        }
        
        downLoadBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.width.equalTo(88)
            make.height.equalTo(44)
        }
    }
    
    @objc func downLoadBtnPressed(_ sender: Any) {
         debugPrint(" downLoadBtnPressed ")
        changeBlock?(self)
        downLoadBtn.setTitle("正在下载...", for: .normal)
        
//        let URLStirng = URLStrings[indexPath.row]
//        self.downloadClosure = { cell in
//            appDelegate.sessionManager4.download(URLStirng, fileName: cell.URLStringLabel.text)
//        }
    }
    
    func updata( title : String) {
        self.nameLabel.text = title
    }
}



class DownLoadListVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    static let reuseIdentifier = "DownLoadListVCIdentifier"

    private var array = [mediaResModel]()
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonModel()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        tableView.register(DownLoadListCell.self, forCellReuseIdentifier: DownLoadListVC.reuseIdentifier)
        
        tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        tableView.reloadData()
        leftBackItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftBackItem() {
        let editingItem = UIBarButtonItem(title: "退出",
                                          style: .plain,
                                          target: self,
                                          action: #selector(leftBackItemPressed))
        navigationItem.leftBarButtonItems = [editingItem]
    }
    
    
    @objc func leftBackItemPressed() {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    
    
    
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DownLoadListVC.reuseIdentifier, for: indexPath)
        if let cell = cell as? DownLoadListCell {
            cell.updata(title: array[indexPath.row].title)
            cell.changeBlock = { cell in
                let urlStirng : String =  self.array[indexPath.row].videos.first ?? ""
                DownloadManager.shared.sessionManager.download(urlStirng, fileName: urlStirng)
                DownloadManager.shared.setDownloads(model: self.array[indexPath.row])
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let string = self.array[indexPath.row]
      
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
}
