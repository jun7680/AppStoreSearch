//
//  DescriptionCell.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/09.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    static let cellID = "DescriptionCell"
    var moreAction: (() -> Void)?
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 3
        label.lineBreakMode = .byCharWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("더 보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.backgroundColor = .white
        button.layer.zPosition = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        return button
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
        addMoreButtonGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setUI() {
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(divider)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: divider.topAnchor, constant: 8),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            moreButton.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 6)
        ])
    }
    
    func configure(item: DetailData) {
        descriptionLabel.text = item.description
    }
    
    private func addMoreButtonGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = .init(x: -20, y: 0, width: 20, height: 20)
        gradientLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = .init(x: 0.0, y: 1)
        gradientLayer.endPoint = .init(x: 1, y: 1)
        moreButton.layer.addSublayer(gradientLayer)
    }
    
    @objc private func didTapMoreButton() {
        if let moreAction = moreAction {
            moreAction()
            descriptionLabel.numberOfLines = 0
            moreButton.isHidden = true
        }
    }
}
