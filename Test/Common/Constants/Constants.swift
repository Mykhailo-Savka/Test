//
//  Constants.swift
//  Test
//
//  Created by Savka Mykhailo on 25.05.2023.
//

import UIKit

// MARK: - Constants
struct Constants {
    static let termsOfUseURL = URL(string: "https://assistai.guru/documents/tos.html")!
    static let privacyPolicyURL = URL(string: "https://assistai.guru/documents/privacy.html")!
    static let subscriptionURL = URL(string: "https://assistai.guru/documents/subscription.html")!
    static let continueButton = "Continue"
    static let subscribeButton = "Try Free & Subscribe"
    static let restoreButton = "Restore Purchase"
    static let cancelButtonIcon = UIImage(named: "cancelIcon")
    static let attributedString = "By continuing you accept our:\n"
    static let termsOfUse = "Terms of Use"
    static let secondAttributedString = ", "
    static let privacyPolicy = "Privacy Policy "
    static let fourthAttributedString = "and "
    static let subscriptionTerms = "Subscription Terms"
    static let onboardingItemWidth = UIScreen.main.bounds.width - 64
    static let onboardingItemSpacing = 16.0
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - onboardingItemWidth) / 2.0
    }
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
    
    // MARK: - Colors
    struct Colors {
        static let cellBackgroundColor = UIColor(named: "background_color")
        static let textColor = UIColor(named: "text_color")
        static let backgroundColor = UIColor(patternImage: UIImage(named: "backgroundImage")!)
        static let buttonTitleColor = UIColor(named: "button_title_color")
        static let dotHighlightedColor = UIColor(named: "dot_highlighted_color")
        static let dotColor = UIColor(named: "dot_color")
        static let restoreButtonColor = UIColor(named: "restore_button_color")
        static let termsColor = UIColor(named: "terms_color")
    }
    
    // MARK: - Onboarding
    struct Onboarding {
        static let firstImage = #imageLiteral(resourceName: "firstIllustration")
        static let secondImage = #imageLiteral(resourceName: "secondIllustration")
        static let thirdImage = #imageLiteral(resourceName: "thirdIllustration")
        static let fourthImage = #imageLiteral(resourceName: "fourthIllustration")
        static let firstTitle = "Your Personal\nAssistant"
        static let secondTitle = "Get assistance\nwith any topic"
        static let thirdTitle = "Perfect copy\nyou can rely on"
        static let fourthTitle = "Upgrade for Unlimited\nAI Capabilities"
        static let firstDescription = "Simplify your life\nwith an AI companion"
        static let secondDescription = "From daily tasks to complex\nqueries, we’ve got you covered"
        static let thirdDescription = "Generate professional\ntexts effortlessly"
        static let fourthDescription = "7-Day Free Trial,\nthen $19.99 /month, auto-renewable"
    }
}
