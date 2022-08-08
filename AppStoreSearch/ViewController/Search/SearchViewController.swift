//
//  ViewController.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/08.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "앱 ID를 입력하세요."
        searchBar.searchBarStyle = .prominent
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.cornerRadius = 16
        
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationController()
        setUI()
        setConstraints()
        setViewModelAction()
    }
    
    // navigation controller setting
    private func setNavigationController() {
        navigationItem.title = "검색"
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
    }
    
    private func setUI() {
        searchBar.delegate = self
        view.addSubview(searchBar)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setViewModelAction() {
        viewModel.successAction = { [weak self] dto in
            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(LookUpViewController(), animated: true)                
            }
        }
    }
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let appID = Int(searchBar.text ?? "") else { return }
        viewModel.searchWithAppId(appID)
    }
}
