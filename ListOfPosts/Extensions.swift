//
//  Extensions.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import Foundation
import UIKit

var imageCahce = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageFrom(urlString: String) {
        if let image = imageCahce.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCahce.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UILabel {
    func countLines(width: CGFloat) -> Int {
        guard let myText = self.text as NSString? else {
          return 0
        }
        // Call self.layoutIfNeeded() if your view uses auto layout
        let rect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: self.font as Any],
                                            context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
      }
}
