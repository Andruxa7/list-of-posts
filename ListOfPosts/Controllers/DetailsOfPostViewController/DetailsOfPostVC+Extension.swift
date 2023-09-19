//
//  DetailsOfPostVC+Extension.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit
import SnapKit

extension DetailsOfPostViewController {
    
    // MARK:- Add the subviews
    func addViews() {
        
        pictureImageView.contentMode = .scaleAspectFit
        
        likesImageView = UIImageView(image: UIImage(systemName: "heart.fill"))
        likesImageView.tintColor = .systemRed
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 0
        
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.numberOfLines = 0
        
        likesLable.font = UIFont.systemFont(ofSize: 12)
        likesLable.textAlignment = .left
        likesLable.lineBreakMode = .byTruncatingTail
        
        timeshampLable.font = UIFont.systemFont(ofSize: 12)
        timeshampLable.textAlignment = .right
        timeshampLable.lineBreakMode = .byTruncatingTail
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(pictureImageView)
        containerView.addSubview(likesImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(textLabel)
        containerView.addSubview(likesLable)
        containerView.addSubview(timeshampLable)
        
        setupConstraints()
    }
    
    // MARK:- Setup Constraints
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.leading.equalTo(scrollView.snp.leading)
            make.trailing.equalTo(scrollView.snp.trailing)
            make.width.equalTo(scrollView.snp.width)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        
        pictureImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pictureImageView.snp.bottom).offset(12)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }
        
        likesImageView.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(20)
            make.leading.equalTo(containerView.snp.leading).offset(8)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalTo(containerView.snp.bottom).offset(-16)
        }
        
        likesLable.snp.makeConstraints { make in
            make.centerY.equalTo(likesImageView.snp.centerY)
            make.leading.equalTo(likesImageView.snp.trailing).offset(3)
        }
        
        timeshampLable.snp.makeConstraints { make in
            make.centerY.equalTo(likesImageView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-8)
        }
    }
}

