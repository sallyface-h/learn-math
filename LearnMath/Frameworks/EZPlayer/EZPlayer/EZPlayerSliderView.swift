//
//  EZPlayerSliderView.swift
//  EZPlayer
//
//  Created by Jackie on 7/31/24.
//

import UIKit

class EZPlayerSliderView: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        // 自定义轨道的大小
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 8.0))
    }
    
//    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
//        // 自定义滑块的位置和大小
//        let thumbRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
//        return thumbRect.offsetBy(dx: 0, dy: -5) // 调整滑块的垂直位置
//    }

}
