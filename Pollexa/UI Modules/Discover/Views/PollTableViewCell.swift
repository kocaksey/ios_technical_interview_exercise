//
//  PollTableViewCell.swift
//  Pollexa
//
//  Created by Seyhun Koçak on 21.05.2024.
//

import UIKit
import SnapKit

class PollTableViewCell: UITableViewCell {
    
    let iconImageView = UIImageView()
    let nameLabel = UILabel()
    let questionLabel = UILabel()
    let firstImage = UIImageView()
    let secondImage = UIImageView()
    let dateLabel = UILabel()
    let firstPercentageLabel = UILabel()
    let secondPercentageLabel = UILabel()
    let numberOfVotesLabel = UILabel()
    let voteTimeLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupUI(){
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(questionLabel)
        contentView.addSubview(firstImage)
        contentView.addSubview(secondImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(numberOfVotesLabel)
        contentView.addSubview(voteTimeLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(30)
        }
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 16
        
        voteTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.left)
            make.top.equalTo(iconImageView.snp.bottom).offset(16)
            make.width.equalTo(220)
        }
        voteTimeLabel.textColor = .lightGray
        voteTimeLabel.font = UIFont(name: "Helvetica-Bold", size: 11)
        
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(8)
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.width.equalTo(100)
        }
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(28)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.width.equalTo(100)
        }
        dateLabel.font = UIFont(name: "Helvetica", size: 14)
        dateLabel.textColor = .lightGray
        
        questionLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.left)
            make.top.equalTo(voteTimeLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(16)
        }
        questionLabel.numberOfLines = 0
        questionLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        firstImage.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.left)
            make.top.equalTo(questionLabel.snp.bottom).offset(8)
            make.width.equalTo(160)
            make.height.equalTo(120)
        }
        firstImage.clipsToBounds = true
        firstImage.layer.cornerRadius = 5
        
        numberOfVotesLabel.snp.makeConstraints { make in
            make.left.equalTo(firstImage.snp.left)
            make.top.equalTo(firstImage.snp.bottom).offset(8)
            make.width.equalTo(120)
        }
        numberOfVotesLabel.textColor = .lightGray
        numberOfVotesLabel.font = UIFont(name: "Helvetica" ,size: 14)
        

        
        secondImage.snp.makeConstraints { make in
            make.left.equalTo(firstImage.snp.right).offset(4)
            make.top.equalTo(questionLabel.snp.bottom).offset(8)
            make.width.equalTo(160)
            make.height.equalTo(120)
        }
        secondImage.clipsToBounds = true
        secondImage.layer.cornerRadius = 5

        firstImage.addSubview(firstPercentageLabel)
        firstPercentageLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        firstPercentageLabel.textColor = .white
        
        secondImage.addSubview(secondPercentageLabel)
        secondPercentageLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        secondPercentageLabel.textColor = .white
    }
    
    func configure(with viewModel: PostViewModel) {
        let daysSince = calculateDaysSince(date: viewModel.createdAt)
        dateLabel.text = "\(daysSince) days ago"
        nameLabel.text = viewModel.post.user.username
        iconImageView.image = viewModel.post.user.image
        questionLabel.text = viewModel.content
        iconImageView.image = viewModel.post.user.image
        if let firstOption = viewModel.options.first {
            firstImage.image = firstOption.image
        }
        if viewModel.options.count > 1 {
            secondImage.image = viewModel.options[1].image
        }
        configureImageLabels()
        configureVoteNumber()
        configureVoteTime()


    }
    private func configureImageLabels() {
        let firstImagePercentage = Int.random(in: 0...100)
        let secondImagePercentage = 100 - firstImagePercentage
        
        firstPercentageLabel.text = "\(firstImagePercentage)%"
        secondPercentageLabel.text = "\(secondImagePercentage)%"
    }
    private func configureVoteNumber(){
        let number = Int.random(in: 47...200)
        numberOfVotesLabel.text = "\(number) Total Votes"
    }
    private func configureVoteTime(){
        let number = Int.random(in: 1...3)
        
        switch number {
        case 1:
            let mins = Int.random(in: 2...59)
            voteTimeLabel.text = "LAST VOTED \(mins) MINUTES AGO"
        case 2:
            let hours = Int.random(in: 2...23)
            voteTimeLabel.text = "LAST VOTED \(hours) HOURS AGO"
        default:
            let days = Int.random(in: 2...18)
            voteTimeLabel.text = "LAST VOTED \(days) DAYS AGO"

        }
    }
    
    private func calculateDaysSince(date: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day], from: date, to: now)
        return components.day ?? 0
    }

}
