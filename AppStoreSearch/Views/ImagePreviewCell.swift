//
//  ImagePreviewCell.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/10.
//

import UIKit

class ImagePreviewCell: UICollectionViewCell {
    static let cellID = "ImagePreviewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUI() {
        addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(url: URL) {
        imageView.setImage(url: url)
    }
}
