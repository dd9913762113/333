//
//  ImageCollectionsVC.swift
//  3332323
//
//  Created by dd on 6/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import Alamofire
import DaisyNet
import HandyJSON

class ImageCollectionsVC: SportBaseVC {
    
    let urlStr = "https://api.pexels.com/v1/curated?page=2&per_page=40"
    let params: [String: Any] = [:]
    let HTTPHeader = ["name":"Authorization","value":"563492ad6f9170000100000130b85a0db6a441e9ae2088499c81d876"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getHeadData()
        self.getHttpData()
       
    }
    
    func getHeadData() {
        let str = "https://raw.githubusercontent.com/dd9913762113/sources/main/s/api_images"
        HN.GET(url: str).success { (response) in
            debugPrint("response = \(response)")
            guard let data = try? JSONSerialization.data(withJSONObject: response) else {return  }

//            let imagesModel = try? JSONDecoder().decode(ImagesModel.self, from: data)
//            if (imagesModel?.pageProps?.assets?.count ?? 0 > 0 ) {
//                debugPrint("imagesModel.pageProps.count \(imagesModel?.pageProps?.assets?.count)")
//            }
        }.failed { (error) in
            debugPrint("failed: \(error)")
        }
    }
    
    
    func getHttpData () {
        
//        let h = ["Authorization": "563492ad6f9170000100000130b85a0db6a441e9ae2088499c81d876"]
//
//        HN.GET(url: urlStr, parameters: params, headers: h).success { (response) in
//            debugPrint("success: \(response)")
//        }.failed { (error) in
//            debugPrint("failed: \(error)")
//        }
/**
 
 https://www.shutterstock.com/zh/search/pretty-girl?sort=random
 
 https://www.shutterstock.com/zh/search/sexy?image_type=photo&page=4
 这个网站抓到的请求图片api的地址
 search
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/search/pretty-girl.json?image_type=photo&term=pretty-girl
 sort=random
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/search/pretty-girl.json?sort=random&term=pretty-girl
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/search/pretty-girl.json?term=pretty-girl
 video
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/video/search/pretty-girl.json?term=pretty-girl
 music
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/music/search/pretty-girl.json?term=pretty-girl
 editorial
 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/editorial/search/pretty-girl.json?term=pretty-girl
 
 */
        
//                 https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/search/pretty-girl.json?image_type=photo&term=pretty-girl
        let str = "https://www.shutterstock.com/_next/data/KGer2kScfnZ-SJdu8tu_8/zh/_shutterstock/search/sexy.json?image_type=photo&page=4&term=sexy"
        HN.GET(url: str).success { (response) in
//            debugPrint("success: \(response)")
            
            guard let data = try? JSONSerialization.data(withJSONObject: response) else {return  }
//                let decoder = JSONDecoder()
//                decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
//                return try? decoder.decode(type, from: data)
            
            let imagesModel = try? JSONDecoder().decode(ImagesModel.self, from: data)
            if (imagesModel?.pageProps?.assets?.count ?? 0 > 0 ) {
                debugPrint("imagesModel.pageProps.count \(imagesModel?.pageProps?.assets?.count)")
            }

            
//            pageProps pageProps[]  index.  displays  "260Nw" "600W" "1500W"   "src" "width" "height"
        }.failed { (error) in
            debugPrint("failed: \(error)")
        }
        
    }
    
    
    
    
    
}



/*
 
 
 
 <script>var T={"apiUrl":"https:\/\/edit.telegra.ph","datetime":1665048654,"pageId":"ded3229a1a3272a3ef23c","editable":true};(function(){var b=document.querySelector('time');if(b&&T.datetime){var a=new Date(1E3*T.datetime),d='January February March April May June July August September October November December'.split(' ')[a.getMonth()],c=a.getDate();b.innerText=d+' '+(10>c?'0':'')+c+', '+a.getFullYear()}})();</script>
 https://edit.telegra.ph/_tl_editor/pageId/ded3229a1a3272a3ef23c

 https://telegra.ph/file/34fd4a1aee917e6dfbd50.jpg
 
 https://telegra.ph/file/6b269dc403a2bafbaef55.jpg
 https://telegra.ph/file/b96166e062f7a68a1bcb1.jpg
 https://telegra.ph/
 https://telegra.ph/
 https://telegra.ph/
 <article id="_tl_editor" class="tl_article_content"><h1>彤萱《夜幕下的精灵》 [克拉女神]<br></h1><address><a href="https://t.me/TujimBot" target="_blank">百万图集免费看 👉🏻 点击关注</a><br></address>
 <img src="/file/6b269dc403a2bafbaef55.jpg"><img src="/file/b96166e062f7a68a1bcb1.jpg"><img src="/file/be852e6d318ac38221918.jpg"><img src="/file/c75bb28cd6f66679e0029.jpg"><img src="/file/e2e08dd8170b76409f781.jpg"><img src="/file/a63554fab17c0945eae43.jpg"><img src="/file/e5ec7351d86ade4ec70e0.jpg"><img src="/file/074eaffae3497ea32a823.jpg"><img src="/file/344dd7dc51a669980b64e.jpg"><img src="/file/ddc646f52535ab98173e7.jpg"><img src="/file/9bd7adb5362b8f784b565.jpg"><img src="/file/9365c0c8b39844279f0bf.jpg"><img src="/file/62d18f8e4d6698347a2f3.jpg"><img src="/file/f7ca6041901a6ae41c78a.jpg"><img src="/file/e1752299cfc9b40001ed5.jpg"><img src="/file/1018909bac4b9985ca2aa.jpg"><img src="/file/4c3d80afb0747f9595d57.jpg"><img src="/file/a51a3f87bac44871b10bd.jpg"><img src="/file/1da9f8ccdb4326cf875c3.jpg"><img src="/file/c817cb13417e2591f3b7c.jpg"><img src="/file/f01fcdf311a02cdab6674.jpg"><img src="/file/3c8b0b40a892abb5d52fa.jpg"><img src="/file/8bb15686c363d79a4ea69.jpg"><img src="/file/e9b7b6bbec3c7284879ea.jpg"><img src="/file/865fa176575efe3167e6d.jpg"><img src="/file/5717df644b2e1da2a1d62.jpg"><img src="/file/41482401a14fb6d0b2358.jpg"></article>

 
 
 */
