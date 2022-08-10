//
//  RatingView.swift
//  AppStoreSearch
//
//  Created by injun on 2022/08/10.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure() {}
    func bind() {}
}
class RatingView: BaseView {
    var starNumber: Int = 5 {
        didSet { bind() }
    }
    
    var ratingValue: Int = 0 {
        didSet {
            bind()
        }
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 2
        view.backgroundColor = .white
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var starFillImage: UIImage? = {
        let image = UIImage(systemName: "star.fill")
        return image
    }()

    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star")
    }()
    
    override func configure() {
        super.configure()
        
        starNumber = 5
        addSubview(stackView)
        setConstraints()
    }
    
    override func bind() {
        super.bind()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        for _ in 0..<ratingValue {
            let startImageView = UIImageView()
            startImageView.image = starFillImage?.resized(to: CGSize(width: 15, height: 15)).withTintColor(.gray)
            stackView.addArrangedSubview(startImageView)
        }
        
        for _ in 0..<(5 - ratingValue) {
            let startImageView = UIImageView()            
            startImageView.image = starEmptyImage?.resized(to: CGSize(width: 15, height: 15)).withTintColor(.gray)
            stackView.addArrangedSubview(startImageView)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}
