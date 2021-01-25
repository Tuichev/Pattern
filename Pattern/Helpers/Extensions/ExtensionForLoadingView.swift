//
//  ExtensionForLoadingView.swift
//

import UIKit

extension UIViewController {
    func blockScreenViewStart(flag: Bool) {
        
        DispatchQueue.main.async {
            guard let currentWindow = UIApplication.shared.keyWindow else { return }
            let tag = TagsGlobalViews.blockScreen.rawValue
            
            for subview in currentWindow.subviews where subview.tag == tag {
                guard let blv: BlockUILoadingView = subview as? BlockUILoadingView else {
                    subview.removeFromSuperview()
                    return
                }
                
                blv.dismissView()
                break
            }
            
            guard flag else { return }
            
            let blview: BlockUILoadingView = .fromNib()
            blview.frame = UIScreen.main.bounds
            blview.tag = tag
            blview.activityIndicator.color = UIColor.appColor(.white)
            currentWindow.addSubview(blview)
        }
    }
    
    func inBlockScreenViewStart(flag: Bool) {
        DispatchQueue.main.async {
            
            guard let currentWindow = UIApplication.shared.keyWindow else {
                return
            }
            
            let tag = TagsGlobalViews.inBlockScreen.rawValue
            
            for subview in currentWindow.subviews where subview.tag == tag {
                subview.removeFromSuperview()
                break 
            }
            
            guard flag else { return }
            
            let heightContainer: CGFloat = 80.0
            
            let width = UIScreen.main.bounds.width
            let height = UIScreen.main.bounds.height
            
            let container = UIView.init(frame: CGRect(x: 0, y: 0, width: heightContainer, height: heightContainer))
            container.tag = tag
            
            container.center = CGPoint(x: width / 2, y: height / 2)
            container.layer.cornerRadius = 10
            container.clipsToBounds = true
            container.backgroundColor = UIColor.clear
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: heightContainer / 4, y: heightContainer / 4, width: heightContainer / 2, height: heightContainer / 2))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .whiteLarge
            loadingIndicator.color = .white
            let transform: CGAffineTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            loadingIndicator.transform = transform
            loadingIndicator.startAnimating()
            
            container.addSubview(loadingIndicator)
            currentWindow.addSubview(container)
        }
    }
}
