//
//  OnboardingViewModel.swift
//  Test
//
//  Created by Savka Mykhailo on 25.05.2023.
//

import Foundation

// MARK: - OnboardingViewModel
class OnboardingViewModel {
    
    // MARK: - Public properties
    var onboardingItems: [OnboardingModel] = []
    
    // MARK: - Private properties
    private let storeKitHandler = StoreKitHandler.shared
    
    // MARK: - Lifecycle
    init() {
        getOnboardingItems()
    }
    
    // MARK: - Public methods
    func purchasesButtonTapped() {
        storeKitHandler.getProducts()
    }
    
    func restoreButtonTapped() {
        storeKitHandler.restorePurchases()
    }
    
    func cancelButtonTapped() { }
    
    // MARK: - Private methods
    private func getOnboardingItems() {
        onboardingItems = [
            OnboardingModel(image: Constants.Onboarding.firstImage,
                            title: Constants.Onboarding.firstTitle,
                            description: Constants.Onboarding.firstDescription),
            OnboardingModel(image: Constants.Onboarding.secondImage,
                            title: Constants.Onboarding.secondTitle,
                            description: Constants.Onboarding.secondDescription),
            OnboardingModel(image: Constants.Onboarding.thirdImage,
                            title: Constants.Onboarding.thirdTitle,
                            description: Constants.Onboarding.thirdDescription),
            OnboardingModel(image: Constants.Onboarding.fourthImage,
                            title: Constants.Onboarding.fourthTitle,
                            description: Constants.Onboarding.fourthDescription)
        ]
    }
}
