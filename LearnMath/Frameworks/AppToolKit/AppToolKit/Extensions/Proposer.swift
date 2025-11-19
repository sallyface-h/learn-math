//
//  Proposer.swift
//  EmperorKit_Example
//
//  Created by 3commas on 3/5/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import AddressBook
import Contacts
import EventKit
import CoreLocation
import UserNotifications

public enum PrivateResource: Equatable {
    case photos

    public var isNotDeterminedAuthorization: Bool {
        switch self {
        case .photos:
            return PHPhotoLibrary.authorizationStatus() == .notDetermined
        }
    }

    public var isAuthorized: Bool {
        switch self {
        case .photos:
            return PHPhotoLibrary.authorizationStatus() == .authorized
        }
    }
}

public typealias Propose = () -> Void
public typealias ProposerAction = () -> Void

public func proposeToAccess(_ resource: PrivateResource, agreed successAction: @escaping ProposerAction, rejected failureAction: @escaping ProposerAction) {
    switch resource {
    case .photos:
        proposeToAccessPhotos(agreed: successAction, rejected: failureAction)
    }
}

private func proposeToAccessPhotos(agreed successAction: @escaping ProposerAction, rejected failureAction: @escaping ProposerAction) {
    PHPhotoLibrary.requestAuthorization { status in
        DispatchQueue.main.async {
            switch status {
            case .authorized:
                successAction()
            default:
                failureAction()
            }
        }
    }
}
