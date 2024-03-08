//
//  CrowdinService.swift
//  Mammoth
//
//  Created by Benoit Nolens on 08/03/2024
//  Copyright © 2024 The BLVD. All rights reserved.
//

import Foundation
import CrowdinSDK
import ArkanaKeys

struct l10n {
    public static func start() {
        let crowdinProviderConfig = CrowdinProviderConfig(hashString: ArkanaKeys.Global().crowdinDistributionString,
                                                          sourceLanguage: GlobalStruct.rootLocalization)
        
        let crowdinSDKConfig = CrowdinSDKConfig.config().with(crowdinProviderConfig: crowdinProviderConfig)
            .with(settingsEnabled: false)
        
        CrowdinSDK.startWithConfig(crowdinSDKConfig, completion: { })
    }
    
    public static func checkForSupportedLanguage() {
        // Fallback to root localization if current device language is not supported
        let supported = GlobalStruct.supportedLocalizations
        if let currentLanguage = self.getCurrentLocale() {
            if !supported.contains(currentLanguage) {
                CrowdinSDK.currentLocalization = GlobalStruct.rootLocalization
            } else {
                CrowdinSDK.currentLocalization = currentLanguage
            }
        } else {
            CrowdinSDK.currentLocalization = GlobalStruct.rootLocalization
        }
    }
    
    private static func getCurrentLocale() -> String? {
        return Locale.preferredLanguages[0]
    }
}