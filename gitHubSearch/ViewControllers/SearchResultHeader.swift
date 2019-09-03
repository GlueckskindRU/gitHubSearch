//
//  SearchResultHeader.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit

class SearchResultHeader: UITableViewHeaderFooterView {
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.medium)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Repositories found: "
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    func configure(with foundNumber: Int) {
        captionLabel.text = "Repositories found: \(foundNumber)"
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layoutSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layoutSetup()
    }
    
    func layoutSetup() {
        contentView.addSubview(captionLabel)
        captionLabel.sizeToFit()
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.margin),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
            contentView.trailingAnchor.constraint(equalTo: captionLabel.trailingAnchor, constant: Layout.margin),
            contentView.bottomAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: Layout.margin)
            ])
    }
}

extension SearchResultHeader {
    private struct Layout {
        static let margin: CGFloat = 8
    }
}
