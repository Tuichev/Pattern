//
//  ProfileViewController.swift
//  Pattern
//
//  Created by Vlad Tuichev on 25.01.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet private weak var buttonShowEdit: UIButton!
    
    private var presenter: ProfilePresenterProtocol!
    private var settings: Settings!
    private(set) var router: ProfileRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.router = ProfileRouter(view: self)
        setupViews()
    }
    
    private func setupViews() {
        self.applySettings()
    }
    
    private func applySettings() {
        self.title = self.settings.title
        self.view.backgroundColor = self.settings.backgroundColor
        self.buttonShowEdit.isHidden = !self.settings.showNextButton
    }
    
    func setupPresenter(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
    
    func setupSettings(_ settings: Settings) {
        self.settings = settings
    }
    
    @IBAction func showEditProfileClicked(_ sender: UIButton) {
        router.showEditProfile()
    }
}
