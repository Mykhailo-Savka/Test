//
//  OnboardingViewController.swift
//  Test
//
//  Created by Savka Mykhailo on 24.05.2023.
//

import UIKit

// MARK: - OnboardingViewController
final class OnboardingViewController: UIViewController {
    
    // MARK: - Private properties
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.onboardingItemSpacing
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.id)
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = Constants.collectionViewContentInset
        view.decelerationRate = .fast
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    private lazy var restorePurchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.restoreButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(Constants.Colors.restoreButtonColor, for: .normal)
        button.isHidden = true
        
        button.addTarget(self, action: #selector(onRestoreButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Constants.cancelButtonIcon, for: .normal)
        button.isHidden = true
        
        button.addTarget(self, action: #selector(onCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.continueButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.setTitleColor(Constants.Colors.buttonTitleColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 28
        
        button.addTarget(self, action: #selector(onContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = .zero
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.textAlignment = .center
        return textView
    }()
    
    private lazy var customPageControl: CustomPageControl = {
        let customPageControl = CustomPageControl()
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.numberOfPages = onboardingViewModel.onboardingItems.count
        customPageControl.currentPage = 0
        customPageControl.isHidden = true
        return customPageControl
    }()
    
    private var onboardingViewModel = OnboardingViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.backgroundColor
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    @objc private func onContinueButton() {
        let collectionViewCenter = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)
        guard let indexPathForCenterCell = collectionView.indexPathForItem(at: collectionViewCenter) else { return }
        let currentVisibleIndex = indexPathForCenterCell.item
        let nextItemIndex = currentVisibleIndex + 1
        
        currentPageChanged(for: nextItemIndex, indexPath: indexPathForCenterCell)
    }
    
    @objc private func onRestoreButton() {
        onboardingViewModel.restoreButtonTapped()
    }
    
    @objc private func onCancelButton() {
        onboardingViewModel.cancelButtonTapped()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        addSubviews()
        setupTermsAndConditions()
        setupAutoLayout()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        view.addSubview(termsTextView)
        view.addSubview(customPageControl)
        view.addSubview(restorePurchaseButton)
        view.addSubview(cancelButton)
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([
            view.bottomAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 34),
            view.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 86),
            view.bottomAnchor.constraint(equalTo: customPageControl.bottomAnchor, constant: 50),
            view.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 18),
            
            termsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: 37),
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsTextView.heightAnchor.constraint(equalToConstant: 28),
            
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 31),
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 28),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            customPageControl.heightAnchor.constraint(equalToConstant: 4),
            customPageControl.widthAnchor.constraint(equalToConstant: 91),
            customPageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            restorePurchaseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            restorePurchaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17),
            restorePurchaseButton.heightAnchor.constraint(equalToConstant: 18),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
            cancelButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupTermsAndConditions() {
        let font = UIFont.systemFont(ofSize: 12)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: style
        ]
        let mainColorAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: Constants.Colors.textColor ?? .black]
        
        let mainTextAttributes = attributes.merging(mainColorAttribute) { _, _ in }
        
        let mainAttributedString = NSMutableAttributedString(string: Constants.attributedString,
                                                             attributes: mainTextAttributes)
        
        let firstURL = Constants.termsOfUseURL.absoluteString
        let firstAttributedString = Constants.termsOfUse.urlAttributedString(with: font,
                                                                             url: firstURL)
        
        let secondAttributedString = NSMutableAttributedString(string: Constants.secondAttributedString,
                                                               attributes: mainTextAttributes)
        
        let secondURL = Constants.privacyPolicyURL.absoluteString
        let thirdAttributedString = Constants.privacyPolicy.urlAttributedString(with: font,
                                                                                url: secondURL)
        
        let fourthAttributedString = NSMutableAttributedString(string: Constants.fourthAttributedString,
                                                               attributes: mainTextAttributes)
        
        let thirdURL = Constants.subscriptionURL.absoluteString
        let fifthAttributedString = Constants.subscriptionTerms.urlAttributedString(with: font,
                                                                                    url: thirdURL)
        
        mainAttributedString.append(firstAttributedString)
        mainAttributedString.append(secondAttributedString)
        mainAttributedString.append(thirdAttributedString)
        mainAttributedString.append(fourthAttributedString)
        mainAttributedString.append(fifthAttributedString)
        termsTextView.attributedText = mainAttributedString
    }
    
    private func currentPageChanged(for nextItemIndex: Int, indexPath: IndexPath) {
        if nextItemIndex > 0, nextItemIndex < (collectionView.numberOfItems(inSection: indexPath.section) - 1) {
            termsTextView.isHidden = true
            customPageControl.isHidden = false
            customPageControl.currentPage = nextItemIndex
        } else {
            termsTextView.isHidden = false
            customPageControl.isHidden = true
        }
        
        if nextItemIndex < collectionView.numberOfItems(inSection: indexPath.section) {
            let nextIndexPath = IndexPath(item: nextItemIndex, section: indexPath.section)
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            
            if nextItemIndex == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
                continueButton.setTitle(Constants.subscribeButton, for: .normal)
                restorePurchaseButton.isHidden = false
                cancelButton.isHidden = false
            }
        } else if nextItemIndex == collectionView.numberOfItems(inSection: indexPath.section) {
            onboardingViewModel.purchasesButtonTapped()
        }
    }
}

// MARK: - UITextViewDelegate implementation
extension OnboardingViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout implementation
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Constants.onboardingItemWidth + Constants.onboardingItemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left,
                                              y: scrollView.contentInset.top)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.onboardingItemWidth,
                      height: collectionView.bounds.height)
    }
}

// MARK: - UICollectionViewDataSource implementation
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingViewModel.onboardingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.id,
                                                      for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(with: onboardingViewModel.onboardingItems[indexPath.row])
        return cell
    }
}

