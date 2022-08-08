//
//  TitleCell.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/09.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    private let appIcon: UIImageView = UIImageView()
    private let appTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private installButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
}
