//
//  BaseWebController.swift
//  3332323
//
//  Created by dd on 25/1/22.
//

import Foundation
import UIKit
import WebKit

public class BaseWebController: SportBaseVC {
    
    public var titleText: String = ""
    
    public var url: String = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        _setUI()
        reloadUrl()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideProgress()
    }
    
    lazy var _wkView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.processPool = WKProcessPool()
        let wkView = WKWebView(frame: .zero, configuration: config)
        wkView.uiDelegate = self
        wkView.navigationDelegate = self
        wkView.customUserAgent = ""
        return wkView
    }()
}

extension BaseWebController {
    private func _setUI() {
        self.title = titleText
        self.view.addSubview(self._wkView)
        self._wkView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func reloadUrl() {
        showProgress()
        self._wkView.load(URLRequest(url: URL(string: url)!, timeoutInterval: 15))
    }
}

extension BaseWebController:WKUIDelegate, WKNavigationDelegate {
    
    private func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        hideProgress()
    }
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        hideProgress()
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideProgress()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideProgress()
        showMessage("刷新失败，请检查网络是否通畅！")
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hideProgress()
        showMessage("刷新失败，请检查网络是否通畅！")
    }
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust, let trust = challenge.protectionSpace.serverTrust {
            // 创建凭据对象
            let cred = URLCredential(trust: trust)
            // 告诉服务器信任证书
            completionHandler(.useCredential, cred)
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
