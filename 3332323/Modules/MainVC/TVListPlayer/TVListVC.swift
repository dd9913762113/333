//
//  TVListVC.swift
//  3332323
//
//  Created by dd on 28/7/2021.
//

import Foundation
import UIKit
import KSPlayer

class TVListVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    static let reuseIdentifier = "DownLoadListVCIdentifier"
    private var resources = [KSPlayerResource]()
    
    private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loadCachem3u8()
        if self.resources.count == 0 {
            self.updatem3u8("https://iptv-org.github.io/iptv/countries/cn.m3u")
        }
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44

        tableView.register(TVListCell.self, forCellReuseIdentifier: TVListVC.reuseIdentifier)
        
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
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.resources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVListVC.reuseIdentifier, for: indexPath)
        if let cell = cell as? TVListCell {
//            cell.updata(title: array[indexPath.row].title)
            cell.updata(title: self.resources[indexPath.row].name)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let string = self.array[indexPath.row]
        let controller = MediaPlay()
        controller.resource = self.resources[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }


    
    private func loadCachem3u8() {
        guard var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        path.appendPathComponent("cache.m3u8")
        if FileManager.default.fileExists(atPath: path.path) {
            do {
                let data = try Data(contentsOf: path)
                guard let string = String(data: data, encoding: .utf8) else {
                    return
                }
                resources.removeAll()
                resources.append(contentsOf: parsem3u8(string: string))
            } catch {}
        }
    }

    private func updatem3u8(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let string = String(data: data, encoding: .utf8) else {
                return
            }
            self.saveToDocument(data: data, filename: "cache.m3u8")
            self.resources.removeAll()
            self.resources.append(contentsOf: self.parsem3u8(string: string))
        }.resume()
    }
    
    private func parsem3u8(string: String) -> [KSPlayerResource] {
        string.components(separatedBy: "#EXTINF:").compactMap { content in
            let array = content.split(separator: "\n")
            guard array.count > 1, let url = URL(string: String(array[1])) else {
                return nil
            }
            guard let name = array[0].split(separator: ",").last else {
                return nil
            }
            return KSPlayerResource(url: url, options: KSOptions(), name: String(name))
        }
    }

    private func saveToDocument(data: Data, filename: String) {
        guard var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        path.appendPathComponent(filename)
        if FileManager.default.fileExists(atPath: path.absoluteString) {
            do {
                try FileManager.default.removeItem(at: path)
            } catch {}
        }
        do {
            try data.write(to: path)
        } catch {}
    }
    
}




private class TVListCell: UITableViewCell {
    
    var changeBlock: ((TVListCell) -> Void)?

    private var nameLabel = UILabel()
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TVListCell
{
    func initSubviews() {
        self.nameLabel = UILabel()
        
        contentView.insertSubview(self.nameLabel, aboveSubview: contentView)

        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(44)
        }

    }


    
    func updata( title : String) {
        self.nameLabel.text = title
    }
}
