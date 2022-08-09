//
//  AppInfoCell.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
    static let cellID = "DetailInfoCell"
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "person.crop.square")?.withTintColor(.gray)
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
        topLabel.preferredMaxLayoutWidth = topLabel.frame.size.width
        bottomLabel.preferredMaxLayoutWidth = bottomLabel.frame.size.width
    }
    
    private func setUI() {
        contentView.addSubview(topLabel)
        contentView.addSubview(centerLabel)
        contentView.addSubview(bottomLabel)
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            centerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            centerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            centerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topLabel.bottomAnchor.constraint(equalTo: centerLabel.topAnchor, constant: 4),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 4),
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
    }
    
    // MARK: - configure
    func configure(item: AppInfoType) {
        let labels = labels(item: item)
        topLabel.text = labels.0
        centerLabel.text = labels.1
        bottomLabel.text = labels.2
        
        switch item {
        case .rating(_, let rating):            
            centerLabel.isHidden = false
            bottomLabel.isHidden = true
            imageView.isHidden = true
        case .developer:
            centerLabel.isHidden = true
            bottomLabel.isHidden = false
            imageView.isHidden = false
        default:
            centerLabel.isHidden = false
            bottomLabel.isHidden = false
            imageView.isHidden = true
        }
    }
    
    // MARK: - setLabels
    private func labels(item: AppInfoType) -> (String, String, String) {
        switch item {
        case let .rating(count, rating):
            return ("\(TextUtil.unitFormatted(count))개의 평가", rating.description, "")
        case let .advisory(rating):
            return ("연령", rating, "세")
        case let .ranking(rank, category):
            return ("차트", "#\(rank)", category)
        case let .developer(name):
            return ("개발자", "", name)
        case let .language(code, count):
            let bottomLabel = count < 1 ? String() : "+ \(count)개의 언어"
            return ("언어", code, bottomLabel)
        }
    }
}
