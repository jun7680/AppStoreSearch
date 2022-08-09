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
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white: 0.3, alpha: 0.3).cgColor
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 26
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setUI() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - configure
    
    func configure(url: URL) {
        imageView.setImage(url: url)
    }
}
