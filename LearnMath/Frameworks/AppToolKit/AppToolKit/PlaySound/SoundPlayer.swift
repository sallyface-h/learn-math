import Foundation
import AudioToolbox

public enum SoundType: String {
    case btnClick = "click_sound"
    case success  = "success_sound"
    case wrong    = "wrong_sound"
}

public class SoundPlayer {
    
    public static let shared = SoundPlayer()
    
    private let tag: String = "Sound"
    private var soundIDs: [String: SystemSoundID] = [:]
    
    private init() {}
    
    public func loadSound(type: SoundType, fileExtension: String = "wav") {
        guard let url = Configurations.bundle.url(forResource: type.rawValue, withExtension: fileExtension) else {
            info_print(tag, message: "无法找到音频文件: \(type.rawValue).\(fileExtension)")
            return
        }
        
        var soundID: SystemSoundID = 0
        let status = AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        
        if status == kAudioServicesNoError {
            soundIDs[type.rawValue] = soundID
            info_print(tag, message: "加载音频文件成功: \(type.rawValue)")
        } else {
            info_print(tag, message: "加载音频文件时出错: \(type.rawValue). 错误代码: \(status)")
        }
    }
    
    public func playSound(type: SoundType) {
        guard let soundID = soundIDs[type.rawValue] else {
            info_print(tag, message: "未找到音频: \(type.rawValue)")
            return
        }
        
        AudioServicesPlaySystemSound(soundID)
    }
    
    public func disposeSound(type: SoundType) {
        guard let soundID = soundIDs[type.rawValue] else {
            info_print(tag, message: "未找到音频: \(type.rawValue)")
            return
        }
        
        let status = AudioServicesDisposeSystemSoundID(soundID)
        if status == kAudioServicesNoError {
            soundIDs.removeValue(forKey: type.rawValue)
            info_print(tag, message: "释放音频成功: \(type.rawValue)")
        } else {
            info_print(tag, message: "释放音频失败: \(type.rawValue). 错误代码: \(status)")
        }
    }
    
    deinit {
        for (type, soundID) in soundIDs {
            AudioServicesDisposeSystemSoundID(soundID)
            info_print(tag, message: "释放音频: \(type)")
        }
        soundIDs.removeAll()
    }
}
