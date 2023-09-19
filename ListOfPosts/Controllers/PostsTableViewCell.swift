//
//  PostsTableViewCell.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit
import SnapKit

class PostsTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = UITableViewCell.SelectionStyle.default
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //
    }
    
    
    //MARK: Elements
    let containerView: UIView = {
        // wrapper to contain all the subviews for the UITableViewCell
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()
    
    let previewTextLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byTruncatingTail
        // Setting the max number of allowed lines in previewText to 2
        label.numberOfLines = 2
        return label
    }()
    
    let likesLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let timeshampLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var expandButton: UIButton = {
        let btn = UIButton ()
        btn.frame = CGRect(x: 5, y: 50, width: 300, height: 20)
        btn.setTitle("Expand", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.backgroundColor = .darkGray
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
        btn.layer.cornerRadius = 6.0
        btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc func buttonClicked(sender: UIButton) {
        //
    }
    
    let likesImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imgView.tintColor = .systemRed
        return imgView
    }()
    
}
