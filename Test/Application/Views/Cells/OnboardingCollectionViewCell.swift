//
//  OnboardingCollectionViewCell.swift
//  Test
//
//  Created by Savka Mykhailo on 25.05.2023.
//

import UIKit

// MARK: - OnboardingCollectionViewCell
final class OnboardingCollectionViewCell: UICollectionViewCell {
    static let id = "OnboardingCollectionViewCell"
    
    // MARK: - Private properties
    private lazy var onboardingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.Colors.cellBackgroundColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var onboardingImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        description.textColor = .white
        description.numberOfLines = 0
        description.textAlignment = .center
        return description
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with onboarding: OnboardingModel) {
        onboardingImage.image = onboarding.image
        titleLabel.text = onboarding.title
        descriptionLabel.text = onboarding.description
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubviews()
        setupAutoLayout()
    }
    
    private func addSubviews() {
        contentView.addSubview(onboardingView)
        onboardingView.addSubview(onboardingImage)
        onboardingView.addSubview(titleLabel)
        onboardingView.addSubview(descriptionLabel)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            onboardingView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            onboardingView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            onboardingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            onboardingImage.topAnchor.constraint(equalTo: onboardingView.topAnchor, constant: 50),
            onboardingImage.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 24),
            onboardingImage.heightAnchor.constraint(equalToConstant: 343),
            onboardingImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: onboardingImage.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: onboardingView.leadingAnchor, constant: 24),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
