//
//  MediaCollectionView.swift
//  demo-iOS
//
//  Created by dd on 18/7/2021.
//  Copyright © 2021 kintan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
//import ObjectMapper
import KSPlayer

let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth  = UIScreen.main.bounds.size.width


class MediaCollectionView : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    
    private var collectionView: UICollectionView?
    private var viewModel: multimediaModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        getJsonModel()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 5
        let www : CGFloat = (ScreenWidth - margin * 3)/2
        layout.itemSize = CGSize.init(width: www, height: www)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 10, right: 5)
        
        collectionView = UICollectionView.init(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(HomeVidelItem.self, forCellWithReuseIdentifier: HomeVidelItem.description())
        self.view.addSubview(collectionView!)
        
        collectionView?.backgroundColor = .clear
        collectionView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
      
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVidelItem.description(), for: indexPath) as! HomeVidelItem
        let itemModel = self.viewModel?.list[indexPath.row]
        item.setModelData(model: itemModel)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let controller = MediaPlay()
        
        let urlStr = self.viewModel?.list[indexPath.row].videos.first ?? ""
        let name = self.viewModel?.list[indexPath.row].title ?? ""
        let coverImageURL = URL(string: self.viewModel?.list[indexPath.row].images.first ?? "")
        debugPrint("player url = " + urlStr)
        let resource =  KSPlayerResource(url: URL(string: urlStr)!, options: KSOptions(), name: String(name),cover:coverImageURL)
        
        controller.resource = resource
//        controller.videoURL = self.viewModel?.list[indexPath.row].videos[0]
        navigationController?.pushViewController(controller, animated: true)

    }
    
    
}


extension MediaCollectionView {
    
    func getJsonModel () {
        guard let path = Bundle.main.path(forResource: "333333", ofType: "json") else { return }
            
        let localData = NSData.init(contentsOfFile: path)! as Data
            
        do {
                 
               
            let banner = try JSONDecoder().decode(multimediaModel.self, from: localData)
//                  if let banners = banner.list {
                self.viewModel = banner
//                  }
              
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
