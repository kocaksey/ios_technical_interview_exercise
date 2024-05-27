//
//  PollViewModel.swift
//  Pollexa
//
//  Created by Seyhun Koçak on 21.05.2024.
//

import Foundation
import RxSwift
import RxCocoa

class PollViewModel{
    
    let postProvider = PostProvider.shared
    
    let posts : PublishSubject<[Post]> = PublishSubject()
    let error : PublishSubject<String> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        
        postProvider.fetchAll { [weak self] result in
            guard let self = self else { return }
            
            
            switch result {
            case .success(let posts):
                self.posts.onNext(posts)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                self.error.onNext(error.localizedDescription)
            }
        }
    }
}
