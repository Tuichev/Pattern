//
//  ProfilePresenter.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import Foundation

protocol ProfilePresenterProtocol {
    init(view: ProfileViewControllerProtcol)
}

class ProfilePresenter: ProfilePresenterProtocol {
    private unowned let view: ProfileViewControllerProtcol
    private var repository: ProfileRepositoryProtocol = ProfileRepository()
    private var profile = ProfileLocalEntity()
    
    required init(view: ProfileViewControllerProtcol) {
        self.view = view
        
        self.getProfile()
    }
    
    func getProfile() {
        //TODO: add loader
        repository.getProfile() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                var tempProfile = ProfileLocalEntity()
                
                if let name = data.name {
                    tempProfile.name = name.description
                }
      
                self.profile = tempProfile
                break
                
            case .failure(let error):
                break
            }
        }
    }
    
    func updateProfile(_ profile: ProfileLocalEntity) {
        var tempProfile = ProfileNetworkEntity()
        tempProfile.name = Int(self.profile.name)
        
        repository.updateProfile(data: tempProfile) { [weak self] result in
            guard let self = self else { return }
            
            //this line just for example of routing
            self.view.router.showEditProfile()
        }
    }
    
}
