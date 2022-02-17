//
//  EFQRCodeVC.swift
//  3332323
//
//  Created by dd on 17/2/22.
//

import Foundation
import UIKit

//class EFQRCodeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
class EFQRCodeVC: SportBaseVC, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor(red: 97.0 / 255.0, green: 207.0 / 255.0, blue: 199.0 / 255.0, alpha: 1)

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

//        navigationController?.navigationBar.isHidden = false
    }

    func setupViews() {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 48)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "EFQRCode\(version == "" ? "" : "\n\(version)")"
        titleLabel.numberOfLines = 0
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            (make) in
            make.top.leading.equalTo(0)
            make.width.equalTo(view)
            make.height.equalTo(view).dividedBy(2.5)
        }

        let tableView = UITableView()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = true
        #if os(iOS)
        tableView.separatorColor = .white
        #endif
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            (make) in
            make.leading.equalTo(0)
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(view).dividedBy(3)
        }

        let bottomLabel = UIButton(type: .system)
        bottomLabel.titleLabel?.font = .systemFont(ofSize: 16)
        bottomLabel.setTitleColor(.white, for: .normal)
        bottomLabel.setTitle("https://github.com/EFPrefix/EFQRCode", for: .normal)
        #if os(iOS)
        bottomLabel.addTarget(self, action: #selector(openBlog), for: .touchDown)
        #endif
        view.addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints {
            (make) in
            make.leading.equalTo(0)
            make.bottom.equalTo(-20)
            make.height.equalTo(20)
            make.width.equalTo(view)
        }
    }
    
    @objc func openBlog() {
        if let tryUrl = URL(string: "https://github.com/EFPrefix/EFQRCode") {
            if #available(iOS 10.0, tvOS 10.0, *) {
                UIApplication.shared.open(tryUrl)
            } else {
                UIApplication.shared.openURL(tryUrl)
            }
        }
    }

    // MARK: - UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        #if os(iOS)
        navigationController?.pushViewController(
            [RecognizerController.self, GeneratorController.self][indexPath.row].init(), animated: true
        )
        #else
        navigationController?.pushViewController(GeneratorController(), animated: true)
        #endif
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if os(iOS)
        return 2
        #else
        return 1
        #endif
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zeroHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zeroHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        #if os(iOS)
        let text = [NSLocalizedString("Recognizer", comment: "Menu option to QR code scanning page"),
                    NSLocalizedString("Generator", comment: "Menu option to QR code generation page")][indexPath.row]
        #else
        let text = NSLocalizedString("Generator", comment: "Menu option to QR code generation page")
        #endif
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.textLabel?.text = text
        let backView = UIView()
        backView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.64)
        cell.selectedBackgroundView = backView
        let imageView = UIImageView(image: UIImage(named: text))
        imageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        imageView.contentMode = .scaleAspectFit
        cell.accessoryView = imageView
        return cell
    }

    #if os(iOS)
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !UIDevice.current.model.contains("iPad") {
            if 1 == indexPath.row {
                cell.separatorInset = UIEdgeInsets(
                    top: 15, left: 0, bottom: 0, right: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
                )
            }
        }
    }
    #endif
}
