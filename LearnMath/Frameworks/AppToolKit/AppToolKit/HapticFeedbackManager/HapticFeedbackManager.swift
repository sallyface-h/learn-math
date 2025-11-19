//
//  HapticFeedbackManager.swift
//  AppToolKit_Example
//
//  Created by Jackie on 2024/7/29.
//  Copyright © 2024 3commas. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreHaptics
import AVFoundation

public class HapticFeedbackManager {
    
    private static let tag: String = "HapticFeedback"
    
    private static var isSilentModeOn: Bool {
        var currentSystemSoundVolume: Float = 0.0
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            currentSystemSoundVolume = AVAudioSession.sharedInstance().outputVolume
        } catch {
            info_print(tag, message: "Failed to get system volume: \(error.localizedDescription)")
        }
        return currentSystemSoundVolume == 0.0
    }
    
    private static func checkSilentMode() -> Bool {
        if isSilentModeOn {
            info_print(tag, message: "Device is in silent mode. Haptic feedback disabled.")
            return true
        }
        return false
    }
    
    // UIImpactFeedbackGenerator
    public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        guard !checkSilentMode() else { return }
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    // UINotificationFeedbackGenerator
    public static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        guard !checkSilentMode() else { return }
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    // UISelectionFeedbackGenerator
    public static func selection() {
        guard !checkSilentMode() else { return }
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    // AudioServicesPlaySystemSound
    public static func standardVibration() {
        guard !checkSilentMode() else { return }
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    // Core Haptics (iOS 13+)
    public static func customHaptic() {
        guard !checkSilentMode() else { return }
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            let engine = try CHHapticEngine()
            try engine.start()
            
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
            
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            info_print(tag, message: "Failed to play haptic: \(error.localizedDescription)")
        }
    }
    
}
