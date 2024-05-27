//
//  PostViewModel.swift
//  Pollexa
//
//  Created by Seyhun Koçak on 21.05.2024.
//

import UIKit

class PostViewModel {
    
     let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    var id: String {
        return post.id
    }
    
    var createdAt : Date{
        return post.createdAt
    }

    
    var content: String {
        return post.content
    }
    
    var options: [PostOptionViewModel] {
        return post.options.map { PostOptionViewModel(option: $0) }
    }


}
class PostOptionViewModel {
    private let option: Post.Option
    
    init(option: Post.Option) {
        self.option = option
    }
    
    var id: String {
        return option.id
    }
    
    var image: UIImage {
        return option.image
    }
}

class UserViewModel {
     let user: Post.User
    
    init(user: Post.User) {
        self.user = user
    }
    
    var id: String {
        return user.id
    }
    
    var username: String {
        return user.username
    }
    

}
