//
//  ViewController.swift
//  Stocks
//
//  Created by Mehmet Deniz Cengiz on 7/8/22.
//

import UIKit

class WatchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupSearchController()
    }
    
    private func setupSearchController() {
        let resultVC = SearchResultsViewViewController()
        let searchVC = UISearchController(searchResultsController: resultVC)
        searchVC.searchResultsUpdater = self
        navigationItem.searchController = searchVC
    }


}

extension WatchListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        // optimize to reduce number of searches for when user stops typing
        //call api to search
        //update results controller
        
        print(query)
    }
}
