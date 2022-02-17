//
//  MineApplyAnchorVC.swift
//  3332323
//
//  Created by dd on 5/2/22.
//

import Foundation


class MineApplyAnchorVC: SportBaseVC {


//    var array1  = [["*直播赛事"],["关于我们","检测更新","清理缓存"]]
//    var array2  = [[" "],[" "," ","190M"]]
    var array1  = ["*直播赛事","*直播经验","*真实姓名","联系方式","","*身份证号","*身份证正面照","*身份证反面照","*手持身份证正面照","*个人简介","推荐人","*电话号码","",""]
    var array2  = ["*直播赛事","*直播经验","*真实姓名","联系方式","","*身份证号","*身份证正面照","*身份证反面照","*手持身份证正面照","*个人简介","推荐人","*电话号码","",""]


     
    lazy var _tableView: UITableView = {
        let _tableView = UITableView()
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.backgroundColor = .white
        _tableView.showsHorizontalScrollIndicator = false
        _tableView.showsVerticalScrollIndicator = false
        _tableView.separatorStyle = .none
        _tableView.rowHeight = 55;
        _tableView.estimatedRowHeight =  UITableView.automaticDimension;
        _tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        _tableView.register(GroupEmptyCell.self, forCellReuseIdentifier: GroupEmptyCell.reuseId)
        _tableView.register(MyFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")

        return _tableView
    }()
    
    let backView = UIView()
    private lazy var loginOutBtn : UIButton = {
        let loginOutBtn = UIButton()
        loginOutBtn.setTitle("提交", for: .normal)
        loginOutBtn.setTitleColor(UIColor.init(hex: "#FFFFFF"), for: .normal)
        loginOutBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        loginOutBtn.backgroundColor = R.Color.color_02a8a2
        loginOutBtn.addTarget(self, action: #selector(loginOutBtnPressed), for: .touchUpInside)
        loginOutBtn.layer.cornerRadius = 6
        loginOutBtn.layer.masksToBounds = true
        return loginOutBtn
    }()
    
    @objc public func loginOutBtnPressed() {
        SOUT("")
       
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "成为主播"

        _setMainView()

    }
    
    private func _setMainView() {
        
        view.addSubview(_tableView)
        _tableView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }

        backView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 70)
        backView.addSubview(loginOutBtn)

        loginOutBtn.frame = CGRect(x: 15, y: 25, width: kScreenW-30, height: 44)

        _tableView.tableFooterView = backView
        _tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        _tableView.separatorColor = R.Color.color_E0E0E0
    }
    
    
    
    
    
    
}





extension MineApplyAnchorVC: UITableViewDelegate, UITableViewDataSource {


//    func numberOfSections(in tableView: UITableView) -> Int {
//        return array1.count
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array1.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: GroupEmptyCell.reuseId, for: indexPath) as! GroupEmptyCell
        
        if indexPath.section == 0 {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.setdata(array1: array1,array2: array2, indexPath: indexPath)

        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            SOUT("x悬浮窗播放")
            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            SOUT("关于我们")
//            let controller = MineAboutUS()
//            controller.view.backgroundColor = .white
//            controller.title = "关于我们"
//            self.navigationController?.pushViewController(controller, animated: true)

        } else if indexPath.section == 1 && indexPath.row == 1 {
            SOUT("检测更新")
//            self.getMainConfigOrUpdate(isUpdate: true)

            
        } else if indexPath.section == 1 && indexPath.row == 2 {
            SOUT("清理缓存")

//            DispatchQueue.main.async {
//                JFPopupView.popup.loading()
//                self.clearCache()
//            }
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                JFPopupView.popup.hideLoading()
//                JFPopupView.popup.toast(hit: "清理缓存成功")
//                self.array2[1][2] = "0 M"
//                self._tableView.reloadSections(IndexSet(integersIn: 1...1), with: .none)
//
//            }
//
            
        }else{
            SOUT("点击了 行：\(indexPath.section) 列：\(indexPath.row)")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as? MyFooterView
        
        if section == 1 {
            return UIView()
        }

        return footer
    }
    
}





private class GroupEmptyCell: UITableViewCell {
    static let reuseIdentifier = "GroupEmptyCell"

    private lazy var _titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.pingFangRegular(16)
    }
    
    
    private lazy var _rightLabel = UILabel().then {
        $0.textColor = R.Color.color_b7b7bf
        $0.font = UIFont.pingFangRegular(14)
        $0.textAlignment = .right
    }
    
    private var _lineLabel = UILabel().then {
        $0.backgroundColor = R.Color.color_E0E0E0
    }

    
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        initSubviews()
    }
    
    func initSubviews() {
        contentView.insertSubview(self._titleLabel, aboveSubview: contentView)
        contentView.insertSubview(self._rightLabel, aboveSubview: contentView)


        self._titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(1)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(200)
            make.height.equalTo(54)
        }
        
        self._rightLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
    }
    
    func setdata(array1 : [String], array2 : [String], indexPath : IndexPath) {
        self._titleLabel.text = array1[indexPath.row]
        self._rightLabel.text = array2[indexPath.row]
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attributeImageString (imageName : String, string : String) -> NSMutableAttributedString {
        let attributedStr = NSMutableAttributedString()
            
        let bubbleTeaAttachment = NSTextAttachment()
        bubbleTeaAttachment.image = UIImage(named: imageName)
        bubbleTeaAttachment.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
        attributedStr.append(NSAttributedString(attachment: bubbleTeaAttachment))
        let string1 = NSAttributedString(string: " ")
        attributedStr.append(string1)

        let string = NSAttributedString(
            string: string,
            attributes: [
                NSAttributedString.Key.font: UIFont.pingFangRegular(12),
                NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#333333")
                ]
        )
        attributedStr.append(string)
        return attributedStr
    }
}


private class MyFooterView: UITableViewHeaderFooterView {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let _vv = UIView()
        _vv.frame = CGRect(x: 0, y: -1, width: kScreenW, height: 6)
        _vv.backgroundColor = R.Color.color_E0E0E0

        self.addSubview(_vv)
    }
    
    
}

