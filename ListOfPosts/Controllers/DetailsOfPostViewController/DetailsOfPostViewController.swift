//
//  DetailsOfPostViewController.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit

class DetailsOfPostViewController: UIViewController {
    
    //MARK: Elements
    var scrollView = UIScrollView()
    var containerView = UIView()
    var pictureImageView = UIImageView()
    var likesImageView = UIImageView()
    var titleLabel = UILabel()
    var textLabel = UILabel()
    var likesLable = UILabel()
    var timeshampLable = UILabel()
    
    var networkPostManager = NetworkPostsManager()
    var currentPostDetails: PostDetails!
    var currentPostID: Int!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addViews()
        loadPostDetailsData()
    }
    
    
    // MARK: - Load and display current post
    private func loadPostDetailsData() {
        networkPostManager.onCompletionPostDetailsData = { [weak self] postDetailsData in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.currentPostDetails = postDetailsData
                self.displayPost()
            }
        }
        if let currentPostID = self.currentPostID {
            networkPostManager.getPost(from: currentPostID)
        }
    }
    
    func displayPost() {
        if let post = currentPostDetails {
            titleLabel.text = "\(post.post.title)"
            textLabel.text = "\(post.post.text)"
            likesLable.text = "\(post.post.likesCount)"
            timeshampLable.text = "\(post.post.timeshamp)"
            
            let urlString = post.post.postImage
            pictureImageView.loadImageFrom(urlString: urlString)
        } else {
            print("ERROR No Data")
        }
    }
    
}
