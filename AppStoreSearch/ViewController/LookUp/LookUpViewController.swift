//
//  LookUpViewController.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import UIKit

class LookUpViewController: UIViewController {
    var detail: DetailData
    var appInfo: [AppInfoType]
    var screenShots: [URL]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        
        return collectionView
    }()
    
    init(detail: DetailData, appInfo: [AppInfoType], screenShots: [URL]) {
        self.detail = detail
        self.appInfo = appInfo
        self.screenShots = screenShots
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setCollectionView()
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env -> NSCollectionLayoutSection? in
            switch section {
            case 0: // Detail최상산 부분 앱 다운받기 section
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                      widthDimension: .fractionalWidth(1.0),
                      heightDimension: .fractionalHeight(0.78)))
                item.contentInsets = NSDirectionalEdgeInsets(
                  top: 2,
                  leading: 2,
                  bottom: 2,
                  trailing: 2)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
                
            case 1: // 앱 정보(평가, 연령, 차트 등등). section
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                      widthDimension: .fractionalWidth(1.0),
                      heightDimension: .fractionalHeight(0.78)))
                item.contentInsets = NSDirectionalEdgeInsets(
                  top: 2,
                  leading: 2,
                  bottom: 2,
                  trailing: 2)
                
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .estimated(1)),
                    subitems: [item]
                )
            
                group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
                
                return section
            
            case 2: // 스크린샷
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .fractionalHeight(2.5)
                                     )
                )
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                      heightDimension: .estimated(150)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                return section
                
            default: // 앱 설명
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .fractionalHeight(2.5)
                                     )
                )
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1),
                                      heightDimension: .estimated(1)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
            
        }
        
        return layout
    }
}

extension LookUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1: // 앱 정보
            return appInfo.count
        case 2: // 스크린샷
            return screenShots.count
        default: // 앱 최상단 section 및 설명 section
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
