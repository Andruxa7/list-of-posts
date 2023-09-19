//
//  PostsTableViewController.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import UIKit

class PostsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var networkPostManager = NetworkPostsManager()
    var posts: [PostElement] = []
    var filteredPosts: [PostElement] = []
    var currentPosts: [PostElement] = []
    var currentPostID: Int!
    var currentFilter: ListFilter? = nil
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Posts"
        
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        loadPostData()
        navigationItemMenu()
    }
    
    
    // MARK: - LoadData
    private func loadPostData() {
        networkPostManager.onCompletionPostsData = { [weak self] postData in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.posts.append(contentsOf: postData.posts)
                self.refreshItems()
            }
        }
        networkPostManager.getPost()
    }
    
    
    // MARK: - LoadMenu
    func navigationItemMenu() {
        let defaultItem = UIAction(title: "default", image: UIImage(systemName: "arrow.clockwise")) { (_) in
            self.filterBy(type: .menuDefaultSettings)
        }
        
        let ratingItem = UIAction(title: "rating", image: UIImage(systemName: "lessthan.square")) { (_) in
            self.filterBy(type: .menuRating)
        }
        
        let dateItem = UIAction(title: "date", image: UIImage(systemName: "calendar.badge.clock")) { (_) in
            self.filterBy(type: .menuDate)
        }
        
        let allExpandItem = UIAction(title: "all cells Expand") { (_) in
            self.filterBy(type: .menuAllExpand)
        }
        
        var menu: UIMenu {
            return UIMenu(title: "Sort by", options: [.singleSelection], children: [defaultItem, dateItem, ratingItem, allExpandItem])
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.circle"), primaryAction: nil, menu: menu)
    }
    
    func filterBy(type: ListFilter) {
        switch type {
        case .menuDate:
            self.filteredPosts = self.posts.sorted { $0.timeshamp > $1.timeshamp }
            self.currentFilter = .menuDate
        case .menuRating:
            self.filteredPosts = self.posts.sorted { $0.likesCount > $1.likesCount }
            self.currentFilter = .menuRating
        case .menuAllExpand:
            for (index, _) in self.currentPosts.enumerated() {
                currentPosts[index].expanded = true
            }
            self.filteredPosts = self.currentPosts
            self.currentFilter = .menuAllExpand
        default:
            self.filteredPosts = self.posts.sorted { $0.postID < $1.postID }
            self.currentFilter = nil
        }
        
        refreshItems()
    }
    
    func refreshItems() {
        if currentFilter != nil {
            currentPosts = filteredPosts
        } else {
            currentPosts = posts
        }
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.reuseIdentifier, for: indexPath) as? PostsTableViewCell
        else {
            return UITableViewCell()
        }
        
        let post = currentPosts[indexPath.row]
        cell.configureCell(with: post, indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
}


// MARK: - PostsTableViewCellDelegate

extension PostsTableViewController: PostsTableViewCellDelegate {
    func cellClickedAt(indexPath: IndexPath) {
        currentPosts[indexPath.row].expanded.toggle()
        tableView.reloadData()
    }
}
