//
//  DiscoverViewController.swift
//  Pollexa
//
//  Created by Emirhan Erdogan on 13/05/2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DiscoverViewController: UIViewController {

    // MARK: - Properties
    
    
    private let pollViewModel = PollViewModel()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var postCellViewModels: [PostViewModel] = []
    private let userImage = UIImageView()
    private let addBtn = UIButton()
    private let titleLabel = UILabel()
    private let backView = UIView()
    private let activePollsLabel = UILabel()
    private let pollDetailLabel = UILabel()
    private let arrowImage = UIImageView()
    
    
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PollTableViewCell.self, forCellReuseIdentifier: "PollCell")
        
        setupBindings()
        pollViewModel.fetchPosts()
        setupUI()
        
    }
  
    private func setupBindings(){
        pollViewModel.error.observe(on: MainScheduler.asyncInstance).subscribe { errorString in
            print(errorString)
        }.disposed(by: disposeBag)
        
        pollViewModel.posts.observe(on: MainScheduler.asyncInstance).subscribe { posts in
            self.postCellViewModels = posts.map { PostViewModel(post: $0) }
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    
    private func setupUI(){
        view.backgroundColor = .white
        view.addSubview(userImage)
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 16
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(28)
            make.width.height.equalTo(32)
        }
        userImage.image = UIImage(named: "avatar_1")
        
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(28)
            make.centerY.equalTo(userImage.snp.centerY)
            make.height.width.equalTo(60)
        }
        addBtn.setImage(UIImage(systemName: "plus"), for: .normal)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(28)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
        titleLabel.text = "Discover"
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 28)
        
        view.addSubview(backView)
        backView.backgroundColor = UIColor(named: "AccentColor")
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 20
        backView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            
            make.height.equalTo(78)
            make.left.equalToSuperview().offset(28)
            make.right.equalToSuperview().inset(28)
        }
        
        backView.addSubview(activePollsLabel)
        activePollsLabel.text = "2 Active Polls"
        activePollsLabel.textColor = .white
        activePollsLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
        activePollsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        backView.addSubview(pollDetailLabel)
        pollDetailLabel.text = "See Details"
        pollDetailLabel.textColor = .lightGray
        pollDetailLabel.font = UIFont(name: "Helvetica", size: 14)
        pollDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(activePollsLabel.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        backView.addSubview(arrowImage)
        arrowImage.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(28)
            make.height.width.equalTo(30)
            make.top.equalToSuperview().offset(24)
        }
        
        arrowImage.image = UIImage(systemName: "arrow.right.square.fill")
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.tintColor = .white
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(260)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension DiscoverViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollCell", for: indexPath) as! PollTableViewCell
        let postViewModel = postCellViewModels[indexPath.row]
        let post = postViewModel.post 
        let viewModel = PostViewModel(post: post)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}
