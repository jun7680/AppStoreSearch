//
//  HeaderView.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/09.
//

import UIKit

// Headerview
class HeaderView: UICollectionReusableView {
    static let cellID = "HeaderView"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "미리보기"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(headerLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
