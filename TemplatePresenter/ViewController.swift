//
//  ViewController.swift
//  TemplatePresenter
//
//  Created by Stas Malinovsky on 11/29/18.
//  Copyright © 2018 Stas Malinovsky. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var htmlString: String!
    private var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.loadHTMLString(htmlString, baseURL: nil)
    }

}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.style.webkitTouchCallout='none';")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if let url = navigationAction.request.url {
                if url.lastPathComponent == "close" {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    let alert = UIAlertController(title: "Clicked link", message: url.absoluteString, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: false)
                }
            }

        default:
            break
        }

        decisionHandler(.allow)
    }
}
