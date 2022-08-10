//
//  LookUpViewController.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/08.
//

import UIKit

class LookUpViewController: UIViewController {
    
    var detailData: DetailData
    var appInfo: [AppInfoType]
    var screenShots: [URL]
    var installButtonPosition: CGFloat = 0
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: TitleCell.cellID)
        collectionView.register(DetailInfoCell.self, forCellWithReuseIdentifier: DetailInfoCell.cellID)
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: ScreenShotCell.cellID)
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: DescriptionCell.cellID)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.cellID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    init(detail: DetailData, appInfo: [AppInfoType], screenShots: [URL]) {
        self.detailData = detail
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
        setNavigation()
        setCollectionView()
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // 앱 타이틀 레이아웃
    private func appTitleLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .estimated(200)
            ),
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    // 앱 정보 레이아웃(가로 스크롤)
    private func appInfoLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.5),
            heightDimension: .absolute(100)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.5),
            heightDimension: .absolute(100)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: appInfo.count
        )
        
        group.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 15)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    // 스크린샷 레이아웃
    private func screenShotLayout() -> NSCollectionLayoutSection {
        let fractionWidth = 210 * CGFloat(screenShots.count)
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .absolute(210),
                              heightDimension: .absolute(400))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(fractionWidth),
            heightDimension: .absolute(400)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: screenShots.count
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .topLeading
            )
        ]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        return section
    }
    
    // 앱 설명
    private func appDescriptionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .estimated(100))
        )
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .estimated(100)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, env -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch section {
            case 0: // Detail최상단 부분 앱 다운받기 section
                return self.appTitleLayout()
                
            case 1: // 앱 정보(평가, 연령, 차트 등등). section
                return self.appInfoLayout()
                
            case 2: // 스크린샷
                return self.screenShotLayout()
                
            default: // 앱 설명
                return self.appDescriptionLayout()
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
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TitleCell.cellID,
                for: indexPath
            ) as? TitleCell else { return .init() }
            cell.configure(item: detailData)
            installButtonPosition = cell.frame.maxY
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DetailInfoCell.cellID,
                for: indexPath
            ) as? DetailInfoCell else { return .init() }
            
            cell.configure(item: appInfo[indexPath.row])
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ScreenShotCell.cellID,
                for: indexPath
            ) as? ScreenShotCell else { return .init() }
            
            cell.configure(url: screenShots[indexPath.row])
            
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DescriptionCell.cellID,
                for: indexPath
            ) as? DescriptionCell else { return .init() }
            
            cell.moreAction = {
                collectionView.collectionViewLayout.invalidateLayout()
            }
            
            cell.configure(description: detailData.description)
            return cell
        default: return .init()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.cellID,
                for: indexPath
            )
            
            return headerView
        default:
            return .init()
        }
    }
}

extension LookUpViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.present(ImagePreviewViewController(url: screenShots, selectIndex: indexPath.row), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > installButtonPosition {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor(white: 0.3, alpha: 0.3).cgColor
            imageView.layer.cornerCurve = .continuous
            imageView.layer.cornerRadius = 12
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFit
            if let url = detailData.imageURL {
                imageView.setImage(url: url)
            }
            navigationItem.titleView = imageView
        } else {
            navigationItem.titleView = nil
        }
    }
}

