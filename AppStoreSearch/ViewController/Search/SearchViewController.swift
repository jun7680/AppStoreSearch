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
        searchBar.backgroundColor = .white
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.cornerRadius = 16
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        
        label.text = "검색결과가 없습니다.\n앱 ID를 확인해주세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        
        label.text = "에러가 발생했습니다.\n잠시후 다시 시도해 주세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
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
        view.addSubview(errorLabel)
        view.addSubview(emptyLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setViewModelAction() {
        viewModel.successAction = { [weak self] detailData, appInfoTypes, screenShots in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = true
                self?.emptyLabel.isHidden = true
                self?.navigationController?.pushViewController(
                    LookUpViewController(detail: detailData, appInfo: appInfoTypes, screenShots: screenShots),
                    animated: true
                )                
            }
        }
        
        // error handling
        viewModel.errorAction = { [weak self] in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = false
                self?.emptyLabel.isHidden = true
            }
        }
        
        // search result empty
        viewModel.emptyAction = { [weak self] in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = true
                self?.emptyLabel.isHidden = false
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
