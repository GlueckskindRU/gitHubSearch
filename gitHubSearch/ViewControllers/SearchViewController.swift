//
//  SearchViewController.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {
    private let networkController = NetworkController()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sortingSegmentedControl: UISegmentedControl!
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        performSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        logoImageView.kf.setImage(with: GlobalConsts.gitHubLogoURL)
    }
}

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch()
        return true
    }
}

// MARK: - Private Functions
extension SearchViewController {
    private func performSearch() {
        guard
            let repositoryName = nameTextField.text,
            !repositoryName.isEmpty else {
            let alertDialog = AlertDialog(title: nil, message: "Please enter the name of a repository you search.")
            alertDialog.showAlert(in: self, completion: nil)
            return
        }
        
        let isSortOrderDescending = sortingSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        let activityIndicator = ActivityIndicator()
        activityIndicator.start()
        
        networkController.performSearchRepositories(by: repositoryName, descendedSorting: isSortOrderDescending) {
            (result: Result<SearchRepositoriesResults>) in
            
            switch result {
            case .success(let searchResult):
                DispatchQueue.main.async {
                    activityIndicator.stop()
                    let searchResultsVC = SearchResultTableViewController()
                    searchResultsVC.configure(with: searchResult)
                    self.navigationController?.pushViewController(searchResultsVC, animated: true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    activityIndicator.stop()
                    let alertDialog = AlertDialog(title: nil, message: error.getError())
                    alertDialog.showAlert(in: self, completion: nil)
                }
            }
        }
    }
}
