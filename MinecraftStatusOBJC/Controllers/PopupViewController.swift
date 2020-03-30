//
//  PopupViewController.swift
//  MinecraftStatusOBJC
//
//  Created by Turner Eison on 3/30/20.
//  Copyright © 2020 Turner Eison. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "This view is written in Swift!"
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        let dismissButton = UIButton()
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(.systemBlue, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.centerXAnchor.constraint(equalTo: label.centerXAnchor, constant: 0),
            dismissButton.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: 32)
        ])
    }
    
    @objc func dismissButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
