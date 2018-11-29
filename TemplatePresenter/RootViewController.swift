//
//  RootViewController.swift
//  TemplatePresenter
//
//  Created by Stas Malinovsky on 11/29/18.
//  Copyright © 2018 Stas Malinovsky. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textField = UITextField()
        textField.text = "http://10.0.1.3:83/api/v1/templates/"
        textField.delegate = self
        textField.borderStyle = .line
        textField.becomeFirstResponder()
        view.addSubview(textField)
        view.backgroundColor = .white
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16)
        let heightConstraint = textField.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func getTemplate(_ path: String) {
        
        let url = URL(string: path)!
        
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            defer { self.dataTask = nil }
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200, let utf8Text = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    let vc = ViewController()
                    vc.htmlString = utf8Text
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        dataTask?.resume()
    }
}

extension RootViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        getTemplate(textField.text!)
        return true
    }
}
