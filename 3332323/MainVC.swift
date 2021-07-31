//
//  MainVC.swift
//  3332323
//
//  Created by dd on 20/7/2021.
//

import UIKit
import Foundation
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
      
        self.array = ["DownLoad" , "collectionview" , "TVListVC" , "天女散花" , "各种权限" , "图片选择器" , "图文发布"]
        self.arrayVC = [DownLoadTabbar(), MediaCollectionView(), TVListVC(), PreviewController(), SPPermissionsVC(), WXZLPhoto() ,PublishPostVC()]
        tableView.rowHeight = 50
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.reloadData()
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
}








/**
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
