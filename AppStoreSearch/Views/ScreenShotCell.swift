//
//  ScreenShotCell.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
    static let cellID = "ScreenShotCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUI() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    // MARK: - configure
    
    func configure(url: URL) {
        imageView.setImage(url: url)
    }
}
