//
//  SearchResultTableViewController.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    private var searchResult: SearchRepositoriesResults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: GlobalConsts.repositoryCell)
        tableView.register(SearchResultHeader.self, forHeaderFooterViewReuseIdentifier: GlobalConsts.searchResultsHeader)
        
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: GlobalConsts.searchResultsHeader) as? SearchResultHeader {
            header.configure(with: searchResult.totalFound)
            tableView.tableHeaderView = header
        }
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    func configure(with result: SearchRepositoriesResults) {
        self.searchResult = result
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            
            tableView.tableHeaderView = headerView
            
            tableView.layoutIfNeeded()
        }
        
        navigationItem.title = "Search result"
    }
}

extension SearchResultTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GlobalConsts.repositoryCell, for: indexPath) as? SearchResultCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: searchResult.repositories[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = ShowRepositoryWebViewController()
        destinationVC.configure(with: searchResult.repositories[indexPath.row])

        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

