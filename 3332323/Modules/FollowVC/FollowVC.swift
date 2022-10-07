//
//  FollowVC.swift
//  3332323
//
//  Created by dd on 25/1/22.
//

import Foundation
import Alamofire

public struct NetModel<T>: Convertible {

    public var data: T?

    public var status: NSInteger = -1

    public var msg: String = "无errMsg"

    public var err_msg: String = "无errMsg"

    public init() {}
}

class FollowVC: SportBaseVC {

    private lazy var startBtn : UIButton = {
        let startBtn = UIButton()
        startBtn.setTitle("start", for: .normal)
        startBtn.setTitleColor(UIColor.black, for: .normal)
        startBtn.titleLabel?.font = UIFont.pingFangRegular(16)
        startBtn.backgroundColor = R.Color.color_02a8a2
        startBtn.layer.cornerRadius = 6
        startBtn.layer.masksToBounds = true
        return startBtn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testGCD()
        
//        testAlarm()
        
        startBtn.rx.tap.bind {  [weak self] in
            print("button tapped")
            self?.testAlarm()
        }.disposed(by: disposeBag)
        
//        startBtn.rx.tap.subscribe(onNext: { [weak self] in
//
//            self?.testAlarm()
//
//        }).disposed(by: disposeBag)
        
        self.view.addSubview(startBtn)
   
        startBtn.snp.makeConstraints {
            (make) in
            make.leading.equalTo(10)
            make.trailing.equalTo(view).offset(-10)
            make.top.equalTo(120)
        }
    }
    
   
    
    
    func testGCD() {
        
        //        dispatch_semaphore_t semaphore = dispatch_semaphore_create(5)
        //        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //
        //        for (int i=0;i<100 ; i++) {
        //
        //            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //                //当i==5时，信号量计数<0了，for循环线程阻塞，不继续执行for循环里面同一线程的代码，等到前面5次异步执行完毕，信号量就会增加，紧接着继续执行for循环从而保证控制最大并发量的效果
        //                dispatch_async(queue, ^{
        //                    NSLog(@"i = %d",i);
        //                    //此处模拟一个 异步下载图片的操作
        //                    sleep(2);
        //                    dispatch_semaphore_signal(semaphore);
        //                });
        //           }
        
 
        
        
    }

    
     func testAlarm() {
//        AF.request("https://www.free-api.com/use/567").response { response in
//            debugPrint(response)
//        }
         
//         let string = "https://www.mxnzp.com/api/jokes/list?page=1&app_id=rgihdrm0kslojqvm&app_secret=WnhrK251TWlUUThqaVFWbG5OeGQwdz09"
//
//         AF.request(string).response { response in
//             debugPrint(response)
//         }
         
         
//         let ppp = {"app_id":"rgihdrm0kslojqvm",
//             "app_secret":"WnhrK251TWlUUThqaVFWbG5OeGQwdz09",
//             "page":"1"}
         
         let ppp = [
             "app_id": "rgihdrm0kslojqvm",
             "app_secret": "WnhrK251TWlUUThqaVFWbG5OeGQwdz09",
             "page": "1"
         ] as [String : Any]
         
         
         AF.request("https://www.mxnzp.com/api/jokes/list",
                    method : .get,
                    parameters:ppp
                    ).response { response in
             debugPrint("\n\n AF============================================= ")

             debugPrint(response)
             
             
//             let DCJokesModel = original.merge(with: response)

         }

         
    }
         
  
         
         
    
    
}



