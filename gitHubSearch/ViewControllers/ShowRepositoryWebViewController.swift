//
//  ShowRepositoryWebViewController.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit
import WebKit

class ShowRepositoryWebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    private var repository: Repository?
    private var webView: WKWebView!
    private var progressIndicator = UIProgressView(progressViewStyle: .default)
    
    func configure(with repository: Repository) {
        self.repository = repository
    }
    
    override func loadView() {
        let jsInjection = "document.body.style.background = \"#FEEACF\";"
        let userScript = WKUserScript(source: jsInjection, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = userContentController
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let repository = repository else {
            return
        }
        
        let webRequest = URLRequest(url: repository.url)
        webView.load(webRequest)
        
        //implementing the possibility to browse via back forward and reload actions
        let backBarButtonItem = UIBarButtonItem(title: " < Back ", style: .plain, target: self, action: #selector(backBattonTapped(sender:)))
        let reloadBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(reloadButtonTapped(sender:)))
        let forwardButtonItem = UIBarButtonItem(title: " Forward > ", style: .plain, target: self, action: #selector(forwardButtonTapped(sender:)))
        
        navigationItem.rightBarButtonItems = [forwardButtonItem, reloadBarButtonItem, backBarButtonItem]
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            showProgressIndicator()
            progressIndicator.setProgress(Float(webView.estimatedProgress), animated: true)
            
            if webView.estimatedProgress == 1.0 {
                hideProgressIndicator()
            }
        }
    }
}

// MARK: - WebView Delegate
extension ShowRepositoryWebViewController {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host {
            if host.contains("github.com") {
                decisionHandler(.allow)
                return
            }
        }
        
        let alertDialog = AlertDialog(title: nil, message: "You can't visit this site!")
        alertDialog.showAlert(in: self, completion: nil)
        
        decisionHandler(.cancel)
    }
}

// MARK: - Private Functions
extension ShowRepositoryWebViewController {
    @objc
    private func backBattonTapped(sender: UIBarButtonItem) {
        webView.goBack()
    }
    
    @objc
    private func forwardButtonTapped(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    @objc
    private func reloadButtonTapped(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    private func showProgressIndicator() {
        let alertView = UIAlertController(title: nil, message: "Loading page …", preferredStyle: .alert)
        
        progressIndicator.progressTintColor = .blue
        
        present(alertView, animated: true, completion: {
            let alertViewSize = alertView.view.frame.size
            self.progressIndicator.frame = CGRect(x: 15,
                                                  y: alertViewSize.height - 12,
                                                  width: alertViewSize.width - 30,
                                                  height: 2
            )
            alertView.view.addSubview(self.progressIndicator)
        })
    }
    
    private func hideProgressIndicator() {
        dismiss(animated: false, completion: nil)
    }
}
