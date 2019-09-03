//
//  SearchResultCell.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit

import Kingfisher

class SearchResultCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Consts.nameFont
        label.textColor = Consts.textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Consts.descriptionFont
        label.textColor = Consts.textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Consts.restFonts
        label.textColor = Consts.textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Consts.restFonts
        label.textColor = Consts.textColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Consts.authorFont
        label.textColor = Consts.textColor
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = Layout.avatarSize / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    func configure(with repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        var languageText = "Language: "
        languageText += repository.language ?? "N/A"
        languageLabel.text = languageText
        starsLabel.text = "Stars: \(repository.stars)"
        authorLabel.text = repository.owner.author
        avatarImage.kf.setImage(with: repository.owner.avatarURL)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutInit()
    }
    
    private func layoutInit() {
        contentView.addSubview(nameLabel)
        nameLabel.sizeToFit()
        contentView.addSubview(descriptionLabel)
        descriptionLabel.sizeToFit()
        contentView.addSubview(languageLabel)
        languageLabel.sizeToFit()
        contentView.addSubview(starsLabel)
        starsLabel.sizeToFit()
        contentView.addSubview(authorLabel)
        authorLabel.sizeToFit()
        contentView.addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.topBottomMargin),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.LeadingTrailingMargin),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Layout.verticalMargin),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.LeadingTrailingMargin),
            
            languageLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Layout.verticalMargin),
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.LeadingTrailingMargin),
            
            starsLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: Layout.verticalMargin),
            starsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.LeadingTrailingMargin),
            contentView.bottomAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: Layout.topBottomMargin),
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.topBottomMargin),
            authorLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: Layout.horizontalMargin),
            contentView.trailingAnchor.constraint(equalTo: authorLabel.trailingAnchor, constant: Layout.LeadingTrailingMargin),
            authorLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImage.leadingAnchor),
            
            avatarImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Layout.verticalMargin),
            avatarImage.leadingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: Layout.horizontalMargin),
            avatarImage.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor, constant: Layout.horizontalMargin),
            avatarImage.leadingAnchor.constraint(equalTo: starsLabel.trailingAnchor, constant: Layout.horizontalMargin),
            contentView.trailingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: Layout.LeadingTrailingMargin),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: avatarImage.bottomAnchor, constant: Layout.topBottomMargin),
            
            avatarImage.widthAnchor.constraint(equalToConstant: Layout.avatarSize),
            avatarImage.heightAnchor.constraint(equalToConstant: Layout.avatarSize),
            ])
    }
}

extension SearchResultCell {
    private struct Consts {
        //name Label
        static let nameFont: UIFont = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.medium)
        //description
        static let descriptionFont: UIFont = UIFont.systemFont(ofSize: 22)
        //language + stars
        static let restFonts: UIFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        //author
        static let authorFont: UIFont = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)
        //colors
        static let textColor: UIColor = .black
    }
    
    private struct Layout {
        static let topBottomMargin: CGFloat = 16
        static let LeadingTrailingMargin: CGFloat = 32
        static let verticalMargin: CGFloat = 8
        static let horizontalMargin: CGFloat = 16
        //avatar
        static let avatarSize: CGFloat = 75
    }
}

