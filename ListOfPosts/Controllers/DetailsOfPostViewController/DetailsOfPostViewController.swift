//
//  DetailsOfPostViewController.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit

class DetailsOfPostViewController: UIViewController {

    //MARK: Elements
    var pictureImageView = UIImageView()
    var likesImageView = UIImageView()
    var titleLabel = UILabel()
    var textLabel = UILabel()
    var likesLable = UILabel()
    var timeshampLable = UILabel()
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

}
