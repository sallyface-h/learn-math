//
//  Color+Emperor.swift
//  EmperorKit_Example
//
//  Created by 3commas on 2/24/21.
//  Copyright © 2021 3commas. All rights reserved.
//

import UIKit
import AppearanceKit

public enum ColorSet: AppearanceKit.ColorSet {
    /// 白色
    case white
    /// 黑色
    case black
    /// 主色
    case main
    /// 主文本字体颜色
    case title
    /// 副文本字体颜色
    case subTitle
    /// 背景颜色
    case bg
    /// 深橙色
    case deepOrange
    /// 橙色
    case orange
    /// 深蓝色
    case deepBlue
    /// 蓝色
    case blue
    /// 绿色
    case green
    /// 浅绿色
    case lightGreen
    /// 粉色
    case pink
    /// 深粉色
    case deepPink
    /// 深粉色2
    case deepPink2
    /// 浅粉色
    case lightPink
    /// 紫色
    case purple
    /// 阴影
    case shadow
    /// 技能页面的阴影
    case skillBorder
    /// 技能页面的阴影
    case skillShadow
    /// 技能页面的字体
    case skillTitle
    /// 选项的阴影
    case optionsShadow
    /// 标题字体
    case headerSectionTitle
    /// 边框颜色
    case borderColor
    /// 边框阴影
    case borderShadow
    /// 进度的背景
    case progressBg
    /// scope的背景
    case scopeBg
    /// 深红色
    case deepRed
    /// 渐变色1
    case gradient1
    /// 渐变色2
    case gradient2
    /// 渐变色3
    case gradient3
    /// 渐变色4
    case gradient4
    /// 浅黄色
    case lightYellow

    public var lightColor: String {
        switch self {
        case .white:
            return "#FFFFFF"
        case .black:
            return "#000000"
        case .main:
            return "#FFFFFF"
        case .title:
            return "#FFFFFF"
        case .subTitle:
            return "#666666"
        case .bg:
            return "#FFFFFF"
        case .deepOrange:
            return "#FF7300"
        case .orange:
            return "#FFAA00"
        case .deepBlue:
            return "#325FFF"
        case .blue:
            return "#32AAFF"
        case .green:
            return "#02873E"
        case .lightGreen:
            return "#21BC3A"
        case .pink:
            return "#DA6BEA"
        case .deepPink:
            return "#DA76E9"
        case .deepPink2:
            return "#FF6B78"
        case .lightPink:
            return "#FF86A3"
        case .purple:
            return "#7175E5"
        case .shadow:
            return "#D7D9DB"
        case .skillBorder:
            return "#E5E5E5"
        case .skillShadow:
            return "#E3E7E9"
        case .skillTitle:
            return "#2A405A"
        case .optionsShadow:
            return "#E4E6E7"
        case .headerSectionTitle:
            return "#95A0AC"
        case .borderColor:
            return "#F0F4F8"
        case .borderShadow:
            return "#5A5EB7"
        case .progressBg:
            return "#EAECEE"
        case .scopeBg:
            return "#F0F3F6"
        case .deepRed:
            return "#FF4343"
        case .gradient1:
            return "#FFC42E"
        case .gradient2:
            return "#FFA788"
        case .gradient3:
            return "#FF77A4"
        case .gradient4:
            return "#FF78A3"
        case .lightYellow:
            return "#FFF7E7"
        }
    }

    /// 先返回亮色，有暗黑模式需求才改成暗黑色
    public var darkColor: String {
        return lightColor
    }
}
