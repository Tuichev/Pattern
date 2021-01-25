//
//  ViewController.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Actions
    @IBAction func showNextClicked(_ sender: Any) {
        let vc = ProfileViewController.Builder.default
        self.present(vc, animated: true, completion: nil)
    }
}

