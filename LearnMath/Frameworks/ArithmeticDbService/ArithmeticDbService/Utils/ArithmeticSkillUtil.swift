//
//  ArithmeticSkillUtil.swift
//  ArithmeticDbService
//
//  Created by Jackie on 10/16/24.
//

import UIKit

public struct ArithmeticSkillUtil {
    
    public enum SkillIdMapper: String {
        /// 加法 - 凑十法
        case addMakeTen = "F64BED24CE4749FEB81804FA60B10236"
        /// 加法 - 列竖式
        case addColumnVerticalForm = "AB7C1554C1E844448956442B5157CBB8"
        /// 加法 - 拆补法
        case addDecompositionAndCompensation  = "A90EDF1218214BFDA8A717BB4EDD4D67"
        /// 加法 - 带符号搬家
        case addMovingTheNumbers = "AF5ABCC3261B404DA71666C7531BCEFF"
        /// 加法 - 找基数
        case addFindingTheBaseNumber = "878501A9F1AE4D1D801300BDA1F023D4"
        
        /// 减法 - 破十法
        case subBreakTen = "4EE51F8669BB42859AE7722325065B2F"
        /// 减法 - 列竖式
        case subColumnVerticalForm = "7040552D47F448589F7B06F1599573AC"
        /// 减法 - 带符号搬家
        case subMovingTheNumbers = "381F8AB26E2B412FAB945331A33B8133"
        /// 减法 - 凑整法
        case subMakingUpInteral = "5ADFC61A133A4FA383B1A7E4A949AD31"
        /// 减法 - 拆项法
        case subDecomposingTerms = "54C6FAE0A13040218988D4E9F8CDD898"
        
        /// 乘法 - 99乘法表
        case mulMultiplicationTable = "89A8970061614AC197E1B6BEA9FD397B"
        /// 乘法 - 竖式
        case mulColumnVerticalForm = "D037D4172A2041A09630D594F8C2D9FC"
        /// 乘法 - 双位尾数为1相乘
        case mulEveralTensAndOne = "DD0C9AD669BA457F9172DAC819DA1D21"
        /// 乘法 - 拆项法
        case mulDecomposingTerms = "7E3911225A4D4DB18AA8FA8B723D66CB"
        /// 乘法 - 乘5或25技巧
        case mulPlus5Or25 = "9F1563EE32494756A163BA4B50956225"
        
        /// 除法 - 99乘法表
        case divMultiplicationTable = "B36BB5EB970C4D209ED08531AE9B22E7"
        /// 除法 - 竖式
        case divColumnVerticalForm = "37D16855268A4406B7A592CD3196C9B3"
        /// 除法 - 除5或25技巧
        case divDividedBy5Or25 = "50FE9A5FD881442590BD253BB23C793A"
        /// 除法 - 拆项法
        case divDecomposingTerms = "446B1946CCE7473096755B64F1AA7AA1"
    }
    
}
