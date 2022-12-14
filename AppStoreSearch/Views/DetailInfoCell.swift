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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let centerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.square")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingView: RatingView = {
        let ratingView = RatingView()
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        return ratingView
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
        contentView.addSubview(ratingView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            centerLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            centerLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            topLabel.bottomAnchor.constraint(equalTo: centerLabel.topAnchor, constant: -4),
            topLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -4),
            topLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bottomLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 4),
            bottomLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            bottomLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            ratingView.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: 4),
            ratingView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            ratingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
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
            ratingView.isHidden = false
            ratingView.ratingValue = Int(round(rating))
        case .developer:
            centerLabel.isHidden = true
            bottomLabel.isHidden = false
            imageView.isHidden = false
            ratingView.isHidden = true
        default:
            centerLabel.isHidden = false
            bottomLabel.isHidden = false
            ratingView.isHidden = true
            imageView.isHidden = true
        }
    }
    
    // MARK: - setLabels
    private func labels(item: AppInfoType) -> (String, String, String) {
        switch item {
        case let .rating(count, rating):
            return ("\(TextUtil.unitFormatted(count))?????? ??????", rating.description, "")
        case let .advisory(rating):
            return ("??????", rating, "???")
        case let .ranking(rank, category):
            return ("??????", "#\(rank)", category)
        case let .developer(name):
            return ("?????????", "", name)
        case let .language(code, count):
            let bottomLabel = count < 1 ? String() : "+ \(count)?????? ??????"
            return ("??????", code, bottomLabel)
        }
    }
}
