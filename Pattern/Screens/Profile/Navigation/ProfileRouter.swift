//
//  ProfileRouter.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation

//look at #2 Router in Comments file
protocol ProfileRouterProtocol {
    init(view: ProfileViewControllerProtcol)
    func showEditProfile()
}

class ProfileRouter: ProfileRouterProtocol {
    private unowned let view: ProfileViewControllerProtcol
    
    required init(view: ProfileViewControllerProtcol) {
        self.view = view
    }
    
    func showEditProfile() {
        DispatchQueue.main.async {
            let vc = ProfileViewController.Builder.editProfile
            self.view.presentVC(vc)
        }
    }
}
