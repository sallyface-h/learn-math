import Foundation

protocol EZVideoDownloaderDelegate: AnyObject {
    func ezVideoDownloader(_ downloader: EZVideoDownloader, didUpdateProgress progress: Float, data: Data)
    func ezVideoDownloader(_ downloader: EZVideoDownloader, didFinishDownloadingWith data: Data)
    func ezVideoDownloader(_ downloader: EZVideoDownloader, didFailWithError error: Error)
}

class EZVideoDownloader: NSObject {
    weak var delegate: EZVideoDownloaderDelegate?
    
    private var dataTask: URLSessionDataTask?
    private var receivedData = Data()
    private var totalBytes: Int64 = 0
    
    private lazy var urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    func downloadVideo(from urlString: String) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "EZVideoDownloaderErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL string"])
            delegate?.ezVideoDownloader(self, didFailWithError: error)
            return
        }
        
        receivedData = Data()
        dataTask = urlSession.dataTask(with: url)
        dataTask?.resume()
    }
    
    func cancelDownload() {
        dataTask?.cancel()
    }
}

extension EZVideoDownloader: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        totalBytes = response.expectedContentLength
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        receivedData.append(data)
        let progress = Float(receivedData.count) / Float(totalBytes)
        DispatchQueue.main.async {
            self.delegate?.ezVideoDownloader(self, didUpdateProgress: progress, data: data)
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                self.delegate?.ezVideoDownloader(self, didFailWithError: error)
            } else {
                self.delegate?.ezVideoDownloader(self, didFinishDownloadingWith: self.receivedData)
            }
        }
    }
}
