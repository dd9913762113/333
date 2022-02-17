//
//  DownloadTaskCell.swift
//  3332323
//
//  Created by dd on 24/7/2021.
//

import Foundation
import SnapKit
import Kingfisher
import Tiercel

class DownloadTaskCell: UITableViewCell {
   
    let imageV = UIImageView(frame: .zero)
    var tapClosure: ((DownloadTaskCell) -> Void)?


    var titleLabel: UILabel = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 16)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    
    var speedLabel: UILabel = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    var bytesLabel: UILabel = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    
//    var controlButton: UIButton = {
//        let btn =  UIButton(type: .custom)
//        btn.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 18)
//        btn.setTitleColor(UIColor.Color_6B6060, for: .normal)
//        btn.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
//        btn.setTitleColor(UIColor.Color_6B6060.withAlphaComponent(0.3), for: .disabled)
//        btn.setTitle("完成", for: .normal)
////        btn.addTarget(self, action: #selector(handleCompleteAction), for: .touchUpInside)
//        return btn
//    }()
    var controlButton = UIButton()
    var progressView: UIProgressView  = {
        var pView = UIProgressView()
        pView.alpha = 0
        pView.trackTintColor = .clear
        pView.progressTintColor = UIColor.Color_6B6060
        return pView
    }()
    var timeRemainingLabel: UILabel  = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    var startDateLabel: UILabel  = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    var endDateLabel: UILabel  = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    var statusLabel: UILabel  = {
        let view = UILabel.init()
        view.font = UIFont.PingFang.regularFont(ofSize: 11)
        view.textColor = UIColor.Color_937C7C
        view.numberOfLines = 1
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews () {
        
        controlButton =  UIButton(type: .custom)
        controlButton.titleLabel?.font = UIFont.PingFang.regularFont(ofSize: 18)
        controlButton.setTitleColor(UIColor.Color_6B6060, for: .normal)
        controlButton.setTitleColor(UIColor.Color_6B6060, for: .highlighted)
        controlButton.setTitleColor(UIColor.Color_6B6060.withAlphaComponent(0.3), for: .disabled)
        controlButton.setTitle("完成", for: .normal)
        controlButton.isUserInteractionEnabled = true
        controlButton.addTarget(self, action: #selector(controlButtonPressed), for: .touchUpInside)
        
        contentView.insertSubview(imageV, aboveSubview: contentView)
        contentView.insertSubview(titleLabel, aboveSubview: contentView)
        contentView.insertSubview(speedLabel, aboveSubview: contentView)
        contentView.insertSubview(bytesLabel, aboveSubview: contentView)
        contentView.insertSubview(controlButton, aboveSubview: contentView)
        contentView.insertSubview(progressView, aboveSubview: contentView)
        contentView.insertSubview(timeRemainingLabel, aboveSubview: contentView)
        contentView.insertSubview(startDateLabel, aboveSubview: contentView)
        contentView.insertSubview(endDateLabel, aboveSubview: contentView)
        contentView.insertSubview(statusLabel, aboveSubview: contentView)

       
    }
    
    func setupConstraints()  {
        
        imageV.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(140)
            make.width.equalTo(140)

        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
        
        controlButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-22)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        timeRemainingLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
        
        
        startDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeRemainingLabel.snp_bottomMargin).offset(5)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
        
        endDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startDateLabel.snp_bottomMargin).offset(5)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
      
        bytesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(endDateLabel.snp_bottomMargin).offset(5)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
        speedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(endDateLabel.snp_bottomMargin).offset(5)
            make.left.equalTo(bytesLabel.snp_rightMargin).offset(15)
            make.height.equalTo(22)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(controlButton.snp_bottomMargin).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(22)
        }
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(bytesLabel.snp_bottomMargin).offset(-1)
            make.left.equalTo(imageV.snp_rightMargin).offset(10)
            make.height.equalTo(22)
        }
        
        
    }
    
    
    @objc func controlButtonPressed() {
        tapClosure?(self)
    }


  
    func updateProgress(_ task: Tiercel.DownloadTask) {
        progressView.observedProgress = task.progress
        bytesLabel.text = "\(task.progress.completedUnitCount.tr.convertBytesToString())/\(task.progress.totalUnitCount.tr.convertBytesToString())"
        speedLabel.text = task.speedString
        timeRemainingLabel.text = "剩余时间：\(task.timeRemainingString)"
        startDateLabel.text = "开始时间：\(task.startDateString)"
        endDateLabel.text = "结束时间：\(task.endDateString)"

        var image = #imageLiteral(resourceName: "suspend")
        switch task.status {
        case .suspended:
            statusLabel.text = "暂停"
            statusLabel.textColor = .black
        case .running:
            image = #imageLiteral(resourceName: "resume")
            statusLabel.text = "下载中"
            statusLabel.textColor = .blue
        case .succeeded:
            statusLabel.text = "成功"
            statusLabel.textColor = .green
        case .failed:
            statusLabel.text = "失败"
            statusLabel.textColor = .red
        case .waiting:
            statusLabel.text = "等待中"
            statusLabel.textColor = .orange
        default:
            image = controlButton.imageView?.image ?? #imageLiteral(resourceName: "suspend")
            break
        }
        controlButton.setImage(image, for: .normal)
    }

    
    
    
    func setCellData( model : mediaResModel)  {
        titleLabel.text = model.title
        
        let url = URL(string: (model.images.first ?? "") )
            KF.url(url)
                .fade(duration: 1)
                .loadDiskFileSynchronously()
                .scaleFactor(0.5)
                .set(to: imageV)
        

    }
    
}
