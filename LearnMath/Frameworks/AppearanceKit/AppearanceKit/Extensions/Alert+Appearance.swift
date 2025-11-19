//
//  Alert+Egg.swift
//  EmperorKit_Example
//
//  Created by 3commas on 3/5/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import AppToolKit

extension AppearanceX where Base: UIViewController {

    public func propose(to resource: PrivateResource, message: String? = nil, agreed successAction: @escaping ProposerAction, rejected failureAction: ProposerAction? = nil) {
        if !resource.isAuthorized {
            if resource.isNotDeterminedAuthorization {
                proposeToAccess(resource, agreed: successAction, rejected: {  failureAction?() })
            } else {
                alertNoPermission(to: resource, message: message, cancelAction: failureAction)
            }
        } else {
            successAction()
        }
    }

    private func alertNoPermission(to resource: PrivateResource, message: String? = nil, cancelAction: ProposerAction? = nil) {

        var title = "Alert.sorry".localized
        switch resource {
        case .photos:
            title = "Authority.album".localized
        }

        let t = message == nil ? nil : title

        showDialog(title: t, message: message ?? title, cancelTitle: "Alert.confirm".localized, confirmTitle: "Authority.setting".localized, withCancelAction: cancelAction, confirmAction: {
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        })
    }

    private func showDialog(title: String?, message: String, cancelTitle: String, confirmTitle: String, withCancelAction cancelAction : (() -> Void)?, confirmAction: (() -> Void)?) {

        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let cancelAction: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                cancelAction?()
            }
            alertController.addAction(cancelAction)

            let confirmAction: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmAction?()
            }
            alertController.addAction(confirmAction)

            self.base.present(alertController, animated: true, completion: nil)
        }
    }
}
