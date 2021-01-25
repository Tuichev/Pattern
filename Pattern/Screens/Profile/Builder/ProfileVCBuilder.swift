//
//  ProfileVCBuilder.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import UIKit
//ALWAYS CREATE THIS FILE
extension ProfileViewController {
    typealias Controller = ProfileViewController
    typealias Presenter = ProfilePresenter
    
    class Builder {
        class var `default`: Controller {
            let vc = Controller.fromStoryboard
            let presenter = Presenter(view: vc)
            var settings = Settings()
            settings.title = "Profile"
            settings.showNextButton = true
            
            vc.setupSettings(settings)
            vc.setupPresenter(presenter)
            
            return vc
        }
        
        class var editProfile: Controller {
            let vc = Controller.fromStoryboard
            let presenter = Presenter(view: vc)
            var settings = Settings()
            settings.title = "Edit Profile"
            settings.backgroundColor = .blue
            
            vc.setupSettings(settings)
            vc.setupPresenter(presenter)
            
            return vc
        }
    }
}
