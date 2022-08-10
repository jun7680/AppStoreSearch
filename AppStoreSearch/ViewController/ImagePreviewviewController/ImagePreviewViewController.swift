//
//  ImagePreviewViewController.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/10.
//

import UIKit
import QuickLook

class ImagePreviewViewController: UIViewController {
    
    var url: [URL]
    var selectIndex: Int = 0
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collectionView.isPagingEnabled = true
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: ImagePreviewCell.cellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(url: [URL], selectIndex: Int) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setConstraints()
        
    }
    
    private func setUI() {
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.dataSource = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env -> NSCollectionLayoutSection? in
            return self?.bannerSection()
        }
        
        return layout
    }
        
    private func bannerSection() -> NSCollectionLayoutSection {
        // section 아이템 사이즈
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // section group size
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        let section = NSCollectionLayoutSection(group: group)
        section.visibleItemsInvalidationHandler = { [weak self] visibleItems, offset, env in
            if let selectIndex = self?.selectIndex, selectIndex != 0 {
                let currentPage = Int(max(0, round(offset.x / env.container.contentSize.width * CGFloat(selectIndex))))
                
                self?.collectionView.setContentOffset(CGPoint(x: currentPage, y: 0), animated: false)
            }
        }
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
}

extension ImagePreviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return url.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ImagePreviewCell.cellID,
            for: indexPath
        ) as? ImagePreviewCell else { return .init() }
        
        cell.configure(url: url[indexPath.row])
        
        return cell
    }
}
