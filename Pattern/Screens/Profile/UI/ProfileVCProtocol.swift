//
//  ProfileVCProtocol.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import UIKit

protocol ProfileViewControllerProtcol: class {
    var router: ProfileRouterProtocol! { get }
    
    //TODO: do this in base protocols
    func pushVC(_ vc: UIViewController)
    func presentVC(_ vc: UIViewController)
}

extension ProfileViewController: ProfileViewControllerProtcol {
    func pushVC(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentVC(_ vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
}
