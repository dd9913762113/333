//
//  ViewController.swift
//  3332323
//
//  Created by dd on 9/7/2021.
//

import UIKit
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

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    var array = [String]()
    var tableView = UITableView()
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
      
        self.array = ["collectionview","TelegramVideo"]

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
        
        
        if indexPath.row == 0 {
//           let   controller = MediaCollectionView()
//            navigationController?.pushViewController(controller, animated: true)
        }else{
        
        }
      
    }
}



/**
 
 
 
 
 
 
 Multiple commands produce '/Users/dd/Library/Developer/Xcode/DerivedData/3332323-grviwsrcykznwdbngxminucmeojb/Build/Products/Debug-iphonesimulator/3332323.app/gas-preprocessor.pl':
 1) Target '3332323' (project '3332323') has copy command from '/Users/dd/Desktop/ddd/3332323/3332323/Media/ffmpeg/Sources/FFMpeg/gas-preprocessor.pl' to '/Users/dd/Library/Developer/Xcode/DerivedData/3332323-grviwsrcykznwdbngxminucmeojb/Build/Products/Debug-iphonesimulator/3332323.app/gas-preprocessor.pl'
 2) Target '3332323' (project '3332323') has copy command from '/Users/dd/Desktop/ddd/3332323/3332323/Media/ffmpeg/Sources/gas-preprocessor.pl' to '/Users/dd/Library/Developer/Xcode/DerivedData/3332323-grviwsrcykznwdbngxminucmeojb/Build/Products/Debug-iphonesimulator/3332323.app/gas-preprocessor.pl'

 
 
 */
