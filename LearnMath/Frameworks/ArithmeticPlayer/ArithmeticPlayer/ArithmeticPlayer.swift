//
//  ArithmeticPlayer+OC.swift
//  ArithmeticPlayer_Example
//
//  Created by Jackie on 7/30/24.
//  Objective-C 可调用版本
//

import UIKit
import EZPlayer
import SnapKit
import AppearanceKit
import ArithmeticKit
import ProgressHUD

@objc public enum ArithmeticPlayerFullScreenModeOC: Int {
    case portrait
    case landscape
}

@objcMembers
public class ArithmeticPlayer: UIView {

    public static let TAG: String = "ArithmeticPlayer"

    private weak var embeddedContentView: UIView?
    private var player: EZPlayer?

    // MARK: - Public 属性

    public var fullScreenMode: ArithmeticPlayerFullScreenModeOC {
        switch self.player?.fullScreenMode {
        case .landscape:
            return .landscape
        default:
            return .portrait
        }
    }

    // MARK: - 初始化

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.ap.color(ColorSet.black)
        self.alpha = 0.0
        NotificationCenter.default.post(name: Notification.Name.enterTutorial, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.post(name: Notification.Name.leaveTutorial, object: nil)
        ProgressHUD.dismiss()
    }

    // MARK: - 公共方法 (Objective-C 可调用)

    /// 播放视频
    @objc public func playVideo(_ url: String, title: String) {
        self.player?.stop()
        var videoUrl: URL?
        if url.contains("http") {
            videoUrl = URL(string: url)
        } else {
            videoUrl = URL(fileURLWithPath: url)
        }
        guard let videoUrl = videoUrl else { return }

        self.player = EZPlayer()
        self.player?.floatMode = .none
        self.player?.fullScreenMode = .landscape
        self.player?.allowsExternalPlayback = false
        self.player?.autoLandscapeFullScreenLandscape = true
        self.player?.videoGravity = .aspect
        self.player?.fullScreenStatusbarBackgroundColor = UIColor.clear
        self.player?.backButtonBlock = { [weak self] mode in
            if mode == .fullscreen {
                if self?.embeddedContentView == nil && self?.player?.lastDisplayMode != .float {
                    self?.stopPlayer()
                    self?.hidePlayer()
                }
            } else {
                self?.stopPlayer()
                self?.hidePlayer()
            }
        }

        let w: CGFloat = self.frame.size.width
        let y: CGFloat = UIWindow.key?.safeAreaInsets.top ?? 0.0
        let h: CGFloat = self.frame.size.height - y - (UIWindow.key?.safeAreaInsets.bottom ?? 0.0)
        let contentView = UIView(frame: CGRect(x: 0, y: y, width: w, height: h))
        contentView.backgroundColor = UIColor.ap.color(ColorSet.black)
        self.addSubview(contentView)
        self.embeddedContentView = contentView

        self.player?.playWithURL(videoUrl, embeddedContentView: contentView, title: title)
    }

    /// 停止播放器
    @objc public func stopPlayer() {
        self.player?.stop()
        self.player?.view.removeFromSuperview()
        self.player = nil
        self.embeddedContentView = nil
    }

    /// 显示播放器
    @objc public func showWithCompletion(_ completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
        } completion: { finished in
            completion?()
        }
    }

    /// 隐藏播放器
    @objc public func hidePlayer() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0.0
        } completion: { finished in
            self.stopPlayer()
            self.removeFromSuperview()
        }
    }

}
