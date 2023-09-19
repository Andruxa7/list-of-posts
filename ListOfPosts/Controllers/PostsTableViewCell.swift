//
//  PostsTableViewCell.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit
import SnapKit

protocol PostsTableViewCellDelegate: AnyObject {
    func cellClickedAt(indexPath: IndexPath)
}

class PostsTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var indexPath: IndexPath?
    weak var delegate: PostsTableViewCellDelegate?
    
    
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
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
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
    
    static let previewLabelSidePadding: CGFloat = 8
    
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
        if let indexPath = self.indexPath {
            delegate?.cellClickedAt(indexPath: indexPath)
        }
    }
    
    var expandButtonHeightConstraint: Constraint!
    
    let likesImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(systemName: "heart.fill"))
        imgView.tintColor = .systemRed
        return imgView
    }()
    
    
    //MARK: functions to add views and setup constraints
    func commonInit() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(previewTextLable)
        containerView.addSubview(likesImage)
        containerView.addSubview(likesLable)
        containerView.addSubview(timeshampLable)
        containerView.addSubview(expandButton)
        
        snapKitConstraints()
    }
    
    func snapKitConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(5)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
        
        previewTextLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(PostsTableViewCell.previewLabelSidePadding)
            make.trailing.equalTo(containerView.snp.trailing).offset(-PostsTableViewCell.previewLabelSidePadding)
        }
        
        likesImage.snp.makeConstraints { make in
            make.top.equalTo(previewTextLable.snp.bottom).offset(10)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalTo(expandButton.snp.top).offset(-6)
        }
        
        likesLable.snp.makeConstraints { make in
            make.centerY.equalTo(likesImage.snp.centerY)
            make.leading.equalTo(likesImage.snp.trailing).offset(3)
        }
        
        timeshampLable.snp.makeConstraints { make in
            make.centerY.equalTo(likesImage.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
        
        expandButton.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(5)
            make.trailing.equalTo(containerView.snp.trailing).offset(-5)
            make.bottom.equalTo(containerView.snp.bottom).offset(-5)
            
            expandButtonHeightConstraint = make.height.equalTo(0).constraint
        }
    }
    
    
    //MARK: function to configure the cells
    func configureCell(with post: PostElement, indexPath: IndexPath?) {
        titleLabel.text = "\(post.title)"
        previewTextLable.text = "\(post.previewText)"
        likesLable.text = "\(post.likesCount)"
        timeshampLable.text = "\(post.timeshamp)"
        
        let widthOfPreviewTextLable = self.contentView.frame.width - (2 * PostsTableViewCell.previewLabelSidePadding)
        
        if previewTextLable.countLines(width: widthOfPreviewTextLable) <= 2 {
            expandButton.isHidden = true
            expandButtonHeightConstraint.update(offset: 0)
        } else {
            expandButton.isHidden = false
            expandButtonHeightConstraint.update(offset: 20)
        }
        
        if (post.expanded) {
            previewTextLable.numberOfLines = 0
            expandButton.setTitle("Collapse", for: .normal)
        } else {
            previewTextLable.numberOfLines = 2
            expandButton.setTitle("Expand", for: .normal)
        }
        
        self.indexPath = indexPath
    }
}
