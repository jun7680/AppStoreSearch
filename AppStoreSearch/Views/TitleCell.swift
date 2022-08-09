//
//  TitleCell.swift
//  AppStoreSearch
//
//  Created by 옥인준 on 2022/08/09.
//

import UIKit

class TitleCell: UICollectionViewCell {
    static let cellID = "TitleCell"
    
    private let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(white: 0.3, alpha: 0.3).cgColor
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 26
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let appTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(appIcon)
        contentView.addSubview(appTitle)
        contentView.addSubview(subTitle)
        contentView.addSubview(installButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            appIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            appIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            appIcon.heightAnchor.constraint(equalToConstant: 96),
            appIcon.widthAnchor.constraint(equalToConstant: 96),
            appTitle.topAnchor.constraint(equalTo: appIcon.topAnchor),
            appTitle.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 16),
            subTitle.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 8),
            subTitle.leadingAnchor.constraint(equalTo: appTitle.leadingAnchor),
            installButton.leadingAnchor.constraint(equalTo: appTitle.leadingAnchor),
            installButton.bottomAnchor.constraint(equalTo: appIcon.bottomAnchor),
            installButton.widthAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func configure(item: DetailData) {
        if let url = item.imageURL {
            appIcon.setImage(url: url)
        }
        
        appTitle.text = item.title
        subTitle.text = item.subTitle
    }
}
