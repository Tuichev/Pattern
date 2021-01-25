//
//  ImageExtension.swift
//

import UIKit
import SDWebImage

extension UIImage {
    
    enum AssetName: String {
        // Navigation
        case back
        
        // TabBar
        case live, home, schedule, search, more
        
        // More
        case audioIcon, bellIcon, callUsIcon, downloadsIcon, frequenciesIcon, pathIcon, signOutIcon, settingsIcon
        
        // EditProfile
        case editPhotoIcon
        
        // AppIcons
        case facebookIcon, instagramIcon, twitterIcon, whatsAppIcon
        
        // Placeholder
        case defaultPlaceholder
        
        // SignIn
        case signInLogo, signInBackground, unhidePassword, hidePassword
        
        // Select profile
        case plus, editIcon
        
        // Home
        case bannerInfo, bannerPlay, bannerShare, success, sectionHeaderViewAll
        
        // MyList
        case primaryButtonIcon
        
        // Navigation
        case plusLogo
        
        // ContactUs
        case connectUsIcon, mailIcon, websiteIcon
        case viberIcon, whatsUpIcon, telegramIcon, instagramIconB, facebookIconB, twitterIconB, youtudeIcon
        
        //Player
        case airPlay, chromecast, episodes, fastForward, fastForwardBig, fullScreen, muted, nextPlay, playerPause, playerPlay, playerShare, rewind, rewindBig, unmuted
        
        // End page
        case download
        
        // Language
        case tickLanguage
    }
    
    convenience init!(assetName: AssetName) {
        self.init(named: assetName.rawValue)
    }
}

// Using extension give us advantage of replacing the library with other ones with ease.
protocol ImageLoadable {
    func setImage(from url: URL, completion: ((UIImage) -> Void)?)
}

extension ImageLoadable where Self: UIImageView {
    
    func setImage(from url: URL, completion: ((UIImage) -> Void)? = nil) {
        self.sd_setImage(with: url, placeholderImage: UIImage.init(assetName: .defaultPlaceholder), completed: nil)
    }
    
    func setImageWithOutPlaceholder(from url: URL, completion: ((UIImage) -> Void)? = nil) {
        self.sd_setImage(with: url, completed: nil)
    }
}

extension UIImageView: ImageLoadable {}
 
