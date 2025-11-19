//
//  WebViewController.swift
//  Alamofire
//
//  Created by Jackie on 9/1/24.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift

public protocol EggWebViewControllerDelegate: NSObjectProtocol {
    func webView(_ webView: WKWebView, redirect url: URL?, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    
    func webView(_ webView: WKWebView, messageBody body: [String: Any])
}

open class WebViewController: UIViewController {
    
    public var statusBarStyle: UIStatusBarStyle = .`default`
    
    public weak var delegate: EggWebViewControllerDelegate?
    
    public var titleString: String?
    
    public var webViewContentEdgeInsets: UIEdgeInsets = .zero
    
    public var progressColor: UIColor?
    
    public var htmlUrl: String? {
        didSet {
            guard let urlStr = htmlUrl else { return }
            webView.loadHTMLString(urlStr, baseURL: nil)
        }
    }
    
    public lazy var webView: WKWebView = {
        configuration.selectionGranularity = .character
        if #available(iOS 14.0, *) {
                configuration.defaultWebpagePreferences.allowsContentJavaScript = true
            } else {
                // iOS 13 及以下使用旧属性
                configuration.preferences.javaScriptEnabled = true
            }
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        let userContent = WKUserContentController()
        self.actionNames?.forEach { [weak self] in
            guard let `self` = self else { return }
            userContent.add(WebViewLeakAvoider(delegate: self), name: $0)
        }
        configuration.userContentController = userContent
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        }
        return webView
    }()
    
    fileprivate var hasReSetBackBtn = true
    
    public lazy final var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .bar)
        progressBar.backgroundColor = .clear
        progressBar.trackTintColor = .clear
        return progressBar
    }()
    
    public final let urlRequest: URLRequest
    
    private let disposeBag = DisposeBag()
    
    private final let configuration: WKWebViewConfiguration
    private final let activities: [UIActivity]?
    private final var actionNames: [String]?
    private final var token: String?
    
    public init(urlRequest: URLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), activities: [UIActivity]? = nil, actionNames: [String]? = nil, token: String? = nil) {
        self.configuration = configuration
        self.urlRequest = urlRequest
        self.activities = activities
        self.actionNames = actionNames
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    public convenience init(url: URL, actionNames: [String]? = nil, token: String? = nil) {
        self.init(urlRequest: URLRequest(url: url))
        self.actionNames = actionNames
        self.token = token
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest = URLRequest(url: URL(string: "http://")!)
        self.activities = nil
        self.actionNames = nil
        self.token = nil
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        view.addSubview(progressBar)
        
        webView.load(urlRequest)
        
        if let color = self.progressColor {
            progressBar.progressTintColor = color
        } else {
            let color: UIColor
            
            if #available(iOS 10.0, *) {
                color = UIColor(displayP3Red: CGFloat(60.0) / 255.0, green: CGFloat(119.0) / 255.0, blue: CGFloat(255.0) / 255.0, alpha: CGFloat(1.0))
            } else {
                color = UIColor(red: CGFloat(60.0) / 255.0, green: CGFloat(119.0) / 255.0, blue: CGFloat(255.0) / 255.0, alpha: CGFloat(1.0))
            }
            
            progressBar.progressTintColor = color
        }
        
        view.bringSubviewToFront(progressBar)
        progressBar.frame = CGRect(x: view.frame.minX,
                                   y: 0.0,
                                   width: view.frame.size.width,
                                   height: 2)
        
        // 设置标题
        if let titleString = self.titleString {
            navigationItem.title = titleString
        } else {
            let disposbale = webView.rx.observe(String.self, "title").subscribe({ [weak self] (x) in
                guard let sSelf = self, let result = x.element, let titleStr = result else {
                    return
                }
                sSelf.navigationItem.title = titleStr
            })
            disposbale.disposed(by: disposeBag)
        }
        
        // 监听进度
        let disposbale = webView.rx.observe(Float.self, "estimatedProgress").subscribe { (x) in
            guard let result = x.element, let progress = result else { return }
            let completed = progress == 1.0
            self.progressBar.setProgress(completed ? 0.0 : Float(progress), animated: !completed)
            UIApplication.shared.isNetworkActivityIndicatorVisible = !completed
        }
        disposbale.disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self,
                                                            action: #selector(didTapActionButton(_:)))
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.stopLoading()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        
        let insets = webViewContentEdgeInsets
        webView.scrollView.contentInset = insets
        webView.scrollView.scrollIndicatorInsets = insets
    }
    
    deinit {
        webView.stopLoading()
    }
    
    public func clearCache() {
        let array = [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache]
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: Set(array), modifiedSince: date, completionHandler: { })
    }
    
    @objc private func didTapActionButton(_ sender: UIBarButtonItem) {
        guard let url = urlRequest.url else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = sender
        present(activityVC, animated: true, completion: nil)
    }
}

extension WebViewController {
    
    fileprivate func addCloseBtn() {
        if self.webView.canGoBack {
            // 添加返回按钮
            let backWh: CGFloat = 40
            let backBtn = UIButton(type: .custom)
            backBtn.contentHorizontalAlignment = .left
            backBtn.imageView?.contentMode = .left
            backBtn.addTarget(self, action: #selector(didClickBackBtn), for: .touchUpInside)
            backBtn.frame = CGRect(x: 0, y: 0, width: backWh, height: backWh)
            backBtn.setImage(UIImage(named: "web_back", in: Configurations.bundle, compatibleWith: nil), for: .normal)
            let backItem = UIBarButtonItem(customView: backBtn)
            
            let spaceView = UIView()
            spaceView.frame = CGRect(x: 0, y: 0, width: 1.0, height: 1)
            let spaceItem = UIBarButtonItem(customView: spaceView)
            
            // 关闭按钮
            let closeWH: CGFloat = 40
            let closeBtn = UIButton(type: .custom)
            closeBtn.frame = CGRect(x: 0, y: 0, width: closeWH, height: closeWH)
            closeBtn.addTarget(self, action: #selector(didClickCloseBtn), for: .touchUpInside)
            closeBtn.setImage(UIImage(named: "web_close", in: Configurations.bundle, compatibleWith: nil), for: .normal)
            
            let closeItem = UIBarButtonItem(customView: closeBtn)
            navigationItem.setLeftBarButtonItems([backItem, spaceItem, closeItem], animated: false)
        } else {
            //            // 移除关闭按钮
            //            let backWh: CGFloat = 40.0
            //            let backBtn = UIButton(type: .custom)
            //            backBtn.backgroundColor = UIColor.green
            //            backBtn.contentHorizontalAlignment = .left
            //            backBtn.imageView?.contentMode = .left
            //            backBtn.addTarget(self, action: #selector(didClickBackBtn), for: .touchUpInside)
            //            backBtn.frame = CGRect(x: 0, y: 0, width: backWh, height: backWh)
            //            backBtn.setImage(UIImage(named: "web_back", in: Configure.bundle, compatibleWith: nil), for: .normal)
            //            let backItem = UIBarButtonItem(customView: backBtn)
            //
            //            navigationItem.setLeftBarButtonItems([backItem], animated: false)
        }
    }
    
    @objc func didClickBackBtn() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            guard let nav = navigationController else {
                return
            }
            if (nav.presentingViewController != nil || nav.presentedViewController != nil) && nav.children.count == 1 {
                dismiss(animated: true, completion: nil)
            } else {
                nav.popViewController(animated: true)
            }
        }
    }
    
    @objc func didClickCloseBtn() {
        guard let nav = navigationController else {
            return
        }
        if (nav.presentingViewController != nil || nav.presentedViewController != nil) && nav.children.count == 1 {
            dismiss(animated: true, completion: nil)
        } else {
            nav.popViewController(animated: true)
        }
    }
}

// MARK: - WKNavigationDelegate

extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    
    /// 网页加载完成
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 判断是否要添加关闭按钮
        if hasReSetBackBtn {
            addCloseBtn()
        }
        
        // 设置token
        if let token = self.token {
            let setTokens = "getToken('\(token)');"
            webView.evaluateJavaScript(setTokens) { (data, error) in
                if error == nil {
                    print("token设置成功")
                }
            }
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let delegate = delegate {
            delegate.webView(webView, redirect: navigationAction.request.url, decisionHandler: decisionHandler)
        } else {
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "确定", style: .cancel, handler: { _ in
            completionHandler()
        })
        
        alertController.addAction(confirmAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "确定", style: .default, handler: { _ in
            completionHandler(true)
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { _ in
            completionHandler(false)
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - WKScriptMessageHandler

extension WebViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? [String: Any] else { return }
        delegate?.webView(self.webView, messageBody: body)
    }
}

