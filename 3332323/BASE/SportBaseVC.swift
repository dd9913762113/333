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
import RxSwift

public class SportBaseVC: UIViewController {

    let disposeBag = DisposeBag()

    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        self.view.backgroundColor = UIColor.white

//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "top_back"), style: .plain, target: self, action: #selector(back))
        
 
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//    @objc
//    func back() {
//        self.navigationController?.popViewController(animated: true)
//    }
    
    deinit {
        SOUT("\(type(of: self))控制器被销毁了")
    }
}
