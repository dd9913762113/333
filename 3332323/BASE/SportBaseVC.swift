//
//  SportBaseVC.swift
//  3332323
//
//  Created by dd on 25/1/22.
//

import Foundation
import UIKit
import KSPlayer
import XYNav

public class SportBaseVC: UIViewController {

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "top_back"), style: .plain, target: self, action: #selector(back))

    }
    
//    @objc
//    func back() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    deinit {
        SOUT("\(type(of: self))控制器被销毁了")
    }
}
