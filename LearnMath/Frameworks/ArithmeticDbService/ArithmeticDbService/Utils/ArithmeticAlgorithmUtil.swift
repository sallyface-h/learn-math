//
//  ArithmeticAlgorithmUtil.swift
//  Alamofire
//
//  Created by Jackie on 8/6/24.
//

import Foundation

public enum ArithmeticAlgorithDivSkill {
    /// 99乘法表
    case multiplicationTable
    /// 竖式
    case verticalForm
    /// 除5或25技巧
    case dividedBy5Or25
    /// 拆项法
    case decomposingTerms
}

public enum ArithmeticAlgorithMulSkill {
    /// 99乘法表
    case multiplicationTable
    /// 列竖式
    case columnVerticalForm
    /// 双位尾数为1相乘
    case everalTensAndOne
    /// 拆项法
    case decomposingTerms
    /// 乘5或25技巧
    case plus5or25
}

public enum ArithmeticAlgorithSubSkill {
    /// 破十法
    case breakTen
    /// 列竖式
    case columnVerticalForm
    /// 带符号搬家
    case movingTheNumbers
    /// 凑整法
    case makingUpInteral
    /// 拆项法
    case decomposingTerms
}

public enum ArithmeticAlgorithAddSkill {
    /// 凑十法
    case makeTen
    /// 列竖式
    case columnVerticalForm
    /// 拆补法
    case decompositionAndCompensation
    /// 带符号搬家
    case movingTheNumbers
    /// 找基数
    case findingTheBaseNumber
}

public enum ArithmeticAlgorithmCategory {
    /// 加法
    case addition(_ skill: ArithmeticAlgorithAddSkill)
    /// 减法
    case subtraction(_ skill: ArithmeticAlgorithSubSkill)
    /// 乘法
    case multiplication(_ skill: ArithmeticAlgorithMulSkill)
    /// 除法
    case division(_ skill: ArithmeticAlgorithDivSkill)
    
    public static func generate(_ bankId: String) -> ArithmeticAlgorithmCategory? {
        switch bankId {
        case "80EA194AA2B84B8286AFF8935A7E0ABE":
            return .addition(.makeTen)
        case "4A7A6D8789044EF8BD1707EDCE1B2571":
            return .addition(.columnVerticalForm)
        case "44388EA51B294A59B4A2F181F206F706":
            return .addition(.decompositionAndCompensation)
        case "CED08492260A4B699B61A5A38BE043AC":
            return .addition(.movingTheNumbers)
        case "98C5655F4DDC4A11B6CDD25BD188FD31":
            return .addition(.findingTheBaseNumber)
        case "62AAB9DA257F47778444464C743C6794":
            return .subtraction(.breakTen)
        case "7E98EBE17A754605892514102148E8FA":
            return .subtraction(.columnVerticalForm)
        case "D9B08E5242BD42BC96D115E6A3B3C6F6":
            return .subtraction(.movingTheNumbers)
        case "3C0820FCF72945E5A169C49B1D4588ED":
            return .subtraction(.makingUpInteral)
        case "A39087DCDF844863AB3D15B2F8FFEA5F":
            return .subtraction(.decomposingTerms)
        case "4D2D18F122BF4E49BB083733E18ED071":
            return .multiplication(.multiplicationTable)
        case "15EA1C39C2454DC0BAAD40AFD2BA1A37":
            return .multiplication(.columnVerticalForm)
        case "5D0500BCAA68455B997D686657E42ADA":
            return .multiplication(.everalTensAndOne)
        case "EF6BCE3A6F6042C38E317F55E5EA8E71":
            return .multiplication(.decomposingTerms)
        case "936F44DFE74A4EC49F97FAE0B8C46813":
            return .multiplication(.plus5or25)
        case "4EE977DDA4EC4E9D895E565305E41E9F":
            return .division(.multiplicationTable)
        case "9F30F3A5BAA744E798DC0357DB8141CD":
            return .division(.verticalForm)
        case "F444FBC5C2E3493A9A1F5336EDE58E88":
            return .division(.dividedBy5Or25)
        case "DF7C1E30E209402892E1DC7C4D1404A7":
            return .division(.decomposingTerms)
        default:
            return nil
        }
    }
}

public struct ArithmeticAlgorithmUtil {
    
    /// 生成算法
    /// - Parameters:
    ///   - category: 类型
    ///   - digtal: 位数
    /// - Returns: 结果
    public static func generate(_ category: ArithmeticAlgorithmCategory, digtal: Int) -> (numbers: [Int], answers: [Int]) {
        switch category {
        case .addition(let skill):
            switch skill {
            case .makeTen:
                // a: 如果位数小于等于10，则为大于5，小于等于9的随机数；如果位数大于10，则为大于10，小于等于digtal的随机数，a不能为10的整数倍
                var a = 0
                repeat {
                    a = digtal <= 10 ? Int.random(in: 6...9) : Int.random(in: 11...digtal)
                } while a % 10 == 0
                // c: 当位数小于等于10时，c固定为10，当大于10时，为a的整数10倍
                var c = 10
                if digtal > c {
                    c = min(Int(ceil(Double(a) / 10.0)) * 10, digtal)
                }
                // r1: 结果1为c-a
                let r1 = c - a
                // b: b为大于r1，但小于等于10或者a的随机数
                let b = Int.random(in: (r1 + 1)...min(10, a))
                // r2: 为b-r1
                let r2 = b - r1
                // r3: a + b
                let r3 = a + b
                return ([a, b, c], [r1, r2, r3])
            case .columnVerticalForm:
                // a: 如果位数小于等于10，则为大于0，小于等于10的随机数；如果位数大于10，则为大于10，小于等于digtal的随机数
                let a = digtal <= 10 ? Int.random(in: 1...9) : Int.random(in: 10...(digtal - 1))
                // b: 如果位数小于等于10，则为大于0，小于等于9的随机数；如果位数大于10，则为大于10，小于等于digtal的随机数
                let b = digtal <= 10 ? Int.random(in: 1...9) : Int.random(in: 10...(digtal - 1))
                
                // 算出个位，十位，百分位
                let aOnes = a % 10
                let aTens = (a / 10) % 10
                let aHundreds = a / 100
                
                let bOnes = b % 10
                let bTens = (b / 10) % 10
                let bHundreds = b / 100
                
                // 先进行个位数相加，判断是否有进位
                let cOnes = aOnes + bOnes
                // 进位
                let eCOnes = cOnes / 10
                // 结果
                let rCOnes = cOnes % 10
                
                // 进行十位数相加，判断是否有进位
                let cTens = aTens + bTens + eCOnes
                // 进位
                let eCTens = cTens / 10
                // 结果
                let rCTens = cTens % 10
                
                // 进行百位数相加，判断是否有进位
                let cHundreds = aHundreds + bHundreds + eCTens
                // 进位
                let eCHundreds = cHundreds / 10
                // 结果
                let rCHundreds = cHundreds % 10
                
                var answers: [Int] = []
                answers.append(rCOnes)
                answers.append(eCOnes)
                
                answers.append(rCTens)
                answers.append(eCTens)
                
                answers.append(rCHundreds)
                answers.append(eCHundreds)
                
                return ([aOnes, aTens, aHundreds, bOnes, bTens, bHundreds], answers)
            case .decompositionAndCompensation:
                // a: 如果位数小于等于10m 1-19（过滤10）；如果位数大于10，1-49（过滤10，20，30，40）
                let random1 = digtal <= 10 ? Int.random(in: 1...18) : Int.random(in: 1...4)
                let a = digtal <= 10 ? (random1 >= 10 ? random1 + 1 : random1) : (random1 * 10 + Int.random(in: 1...9))
                // c: 如果位数小于等于10m 1-19（过滤10）；如果位数大于10，1-49（过滤10，20，30，40）
                let random2 = digtal <= 10 ? Int.random(in: 1...18) : Int.random(in: 1...4)
                let c = digtal <= 10 ? (random2 >= 10 ? random2 + 1 : random2) : (random2 * 10 + Int.random(in: 1...9))
                
                // a % 10，c % 10
                let aOnes = a % 10
                let cOnes = c % 10
                
                // b = 20 - aOnes - cOnes
                let b = (20 - aOnes - cOnes)
                
                let r1 = a + b + c
                
                let aTens = a / 10
                let cTens = c / 10
                
                let r2 = (aTens + 1) * 10
                
                let r3 = (cTens + 1) * 10
                
                let r4 = r2 - a
                
                let r5 = r3 - c
                
                return ([a, b, c], [r1, r4, r5, r2, r3])
            case .movingTheNumbers:
                func randomNumberExcluding(_ exclude: Int, inRange range: ClosedRange<Int> = 1...9) -> Int {
                    let availableNumbers = Array(range).filter { $0 != exclude }
                    let availableNumber = availableNumbers.randomElement() ?? 0
                    // 如果a+b能凑整，则重新计算
                    if ((exclude + availableNumber) % 10 == 0) || exclude == availableNumber {
                        return randomNumberExcluding(exclude, inRange: range)
                    }
                    return availableNumber
                }
                
                // a: 如果位数小于等于10，[1-9]随机；如果位数大于10，[1-89]随机，
                let a = digtal <= 10 ? Int.random(in: 1...9) : Int.random(in: 1...89)
                // c: 如果位数小于等于10，10 - a; 如果位数大于10，A向上取整后的数-A
                let c = digtal <= 10 ? (10 - a) : (((a / 10) + 1) * 10 - a)
                // b: 如果位数小于等于10，[1-9]，剔除a；如果位数大于10，[1-99]，剔除a
                let b = digtal <= 10 ? randomNumberExcluding(a) : randomNumberExcluding(a, inRange: 1...99)
                let r1 = a + b + c
                let r2 = a + c
                
                return ([a, b, c], [r1, c, b, r2])
            case .findingTheBaseNumber:
                // base: 先随机出基数，如果<10，则10为基数，如果<100，则10的倍数为基数
                let base = digtal <= 10 ? 10 : Int.random(in: 1...9) * 10
                // 计算出A，B，C的值，为基数加上小于5的数字所得
                let a = base + Int.random(in: 1...5)
                let b = base + Int.random(in: 1...5)
                let c = base + Int.random(in: 1...5)
                
                let r1 = a + b + c
                let r2 = a - base
                let r3 = b - base
                let r4 = c - base
                let r5 = r2 + r3 + r4
                
                let d = base * 3
                
                return ([a, b, c, d, base], [r1, r2, r3, r4, r5])
            }
        case .subtraction(let skill):
            switch skill {
            case .breakTen:
                // a: 如果位数<10，[21-29]的非整十数; 如果>10，[31-99]的非整十数
                let random = digtal <= 10 ? 20 : Int.random(in: 3...9) * 10
                let a = random + Int.random(in: 1...9)
                // c: 为a求整
                let c = random
                // r1 = a - c
                let r1 = a - c
                // r2: [11减r1 - 19减r1]随机
                func calR2(r1: Int) -> Int {
                    let r2 = digtal <= 10 ? Int.random(in: 1...9) : Int.random(in: (11 - r1)...(19 - r1))
                    if (r2 + r1) % 10 == 0 {
                        return calR2(r1: r1)
                    }
                    return r2
                }
                let r2 = calR2(r1: r1)
                // b: r1 + r2
                let b = r1 + r2
                // r3: a - b
                let r3 = a - b
                return ([a, b, c], [r1, r2, r3])
            case .columnVerticalForm:
                // a: 如果位数小于等于10，则为大于0，小于等于10的随机数；如果位数大于10，则为大于10，小于等于digtal的随机数
                let a = digtal <= 10 ? Int.random(in: 1...10) : Int.random(in: 11...digtal)
                // b: 如果位数小于等于10，则为大于1，小于等于a的随机数；如果位数大于10，则为大于11，小于等于a的随机数
                let b = digtal <= 10 ? Int.random(in: 1...a) : Int.random(in: 11...a)
                
                // 算出个位，十位，百分位
                let aOnes = a % 10
                let aTens = (a / 10) % 10
                let aHundreds = a / 100
                
                let bOnes = b % 10
                let bTens = (b / 10) % 10
                let bHundreds = b / 100
                
                // 先进行个位数相减少，判断是否有借位
                let cOnes = aOnes - bOnes
                // 借位
                let eCOnes = cOnes < 0 ? -1 : 0
                // 结果
                let rCOnes = eCOnes < 0 ? (10 - abs(cOnes)) : cOnes
                
                // 进行十位数相减，判断是否有借位
                let cTens = (aTens - (eCOnes < 0 ? 1 : 0)) - bTens
                // 借位
                let eCTens = cTens < 0 ? -1 : 0
                // 结果
                let rCTens = eCTens < 0 ? (10 - abs(cTens)) : cTens
                
                // 进行百位数相加，判断是否有进位
                let cHundreds = (aHundreds - (eCTens < 0 ? 1 : 0)) - bHundreds
                // 借位
                let eCHundreds = cHundreds < 0 ? -1 : 0
                // 结果
                let rCHundreds = eCHundreds < 0 ? (10 - abs(eCHundreds)) : cHundreds
                
                var answers: [Int] = []
                answers.append(rCOnes)
                answers.append(eCOnes)
                
                answers.append(rCTens)
                answers.append(eCTens)
                
                answers.append(rCHundreds)
                answers.append(eCHundreds)
                
                return ([aOnes, aTens, aHundreds, bOnes, bTens, bHundreds], answers)
            case .movingTheNumbers:
                func randomNumberExcluding(_ exclude: Int, aNumber: Int, inRange range: ClosedRange<Int> = 1...9) -> Int {
                    let availableNumbers = Array(range).filter { $0 != exclude }
                    let availableNumber = availableNumbers.randomElement() ?? 0
                    // 如果a-b为凑整，则重新计算
                    if ((aNumber - availableNumber) % 10 == 0) || exclude == availableNumber {
                        return randomNumberExcluding(exclude, aNumber: aNumber, inRange: range)
                    }
                    return availableNumber
                }
                
                // a: 如果位数小于等于10，[11-19]随机；如果位数大于10，[21-99]随机，
                let a = digtal <= 10 ? Int.random(in: 11...19) : Int.random(in: 21...99)
                // c: 如果位数小于等于10，a - 10; 如果位数大于10，A - A向下取整后的数
                let c = digtal <= 10 ? (a - 10) : (a - ((a / 10) - 1) * 10)
                // b: 如果位数小于等于10，[1-9]，剔除a；如果位数大于10，[1-99]，剔除a
                let b = digtal <= 10 ? randomNumberExcluding(c, aNumber: a) : randomNumberExcluding(c, aNumber: a, inRange: 1...(((a / 10) - 1) * 10))
                let r1 = a - b - c
                let r2 = c
                let r3 = b
                let r4 = a - c
                
                return ([a, b, c], [r1, r2, r3, r4])
            case .makingUpInteral:
                // c: 如果位数小于等于10，则为[11 - 19]随机数；如果位数大于10，则为[21 - (digtal - 1)]的随机数
                let c = digtal <= 10 ? Int.random(in: 11...19) : Int.random(in: 21...(digtal - 1))
                // r2: b+c为c的倍数
                let r2 = (c / 10) * 10 + 10
                // b: r2 - c
                let b = r2 - c
                // a: a为比r2大的数
                let a = digtal <= 10 ? Int.random(in: (r2 + 1)...30) : Int.random(in: (r2 + 1)...(digtal + 10))
                // r1 = a - b - c
                let r1 = a - b - c
                
                return ([a, b, c], [r1, r2])
            case .decomposingTerms:
                // random: 如果位数小于等于10，则为10；如果位数大于10，则为 10以上的整10数
                let random = digtal <= 10 ? 10 : Int.random(in: 2...10) * 10
                // b: 为random + [1-5]的随机数
                let b = random + Int.random(in: 1...5)
                // c: 为random + [1-5]的随机数
                let c = random + Int.random(in: 1...5)
                // a: 为大于a + c的随机数
                let a = Int.random(in: (b + c + 1)...(digtal <= 10 ? 31 : digtal * 2 + 11))
                // r1: a - b - c
                let r1 = a - b - c
                // r2: random
                let r2 = random
                // r3: b - random
                let r3 = b - random
                // r4: random
                let r4 = random
                // r5: c - random
                let r5 = c - random
                
                return ([a, b, c], [r1, r2, r3, r4, r5])
            }
        case .multiplication(let skill):
            switch skill {
            case .multiplicationTable:
                // a: 只有easy模式，则为[1 - 9]随机数；
                let a = Int.random(in: 1...9)
                // b: 只有easy模式，则为[1 - 9]随机数；
                let b = Int.random(in: 1...9)
                // r1: a * b
                let r1 = a * b
                
                return ([a, b], [r1])
            case .columnVerticalForm:
                // a: 如果位数小于等于10，则为[10 - 19]随机数，如果位数大于10，则为20-(digtal - 1)的随机数；
                let a = digtal <= 10 ? Int.random(in: 10...19) : Int.random(in: 20...(digtal - 1))
                // b: 如果位数小于等于10，则为[10 - 19]随机数，如果位数大于10，则为20-(digtal - 1)的随机数；
                let b = digtal <= 10 ? Int.random(in: 10...19) : Int.random(in: 20...(digtal - 1))
                
                // 算出个位，十位
                let aOnes = a % 10
                let aTens = (a / 10) % 10
                
                let bOnes = b % 10
                let bTens = (b / 10) % 10
                
                let onesMul = bOnes * aOnes
                // 进位
                let eOnesMul = onesMul / 10
                // 结果
                let rOnesMul = onesMul % 10
                
                let tensMul = bOnes * aTens + eOnesMul
                // 进位
                let eTensMul = tensMul / 10
                // 结果
                let rTensMul = tensMul % 10
                
                let r1 = rOnesMul
                let r2 = rTensMul
                let r3 = eTensMul
                
                let ones1Mul = bTens * aOnes
                // 进位
                let eOnes1Mul = ones1Mul / 10
                // 结果
                let rOnes1Mul = ones1Mul % 10
                
                let tens1Mul = bTens * aTens + eOnes1Mul
                // 进位
                let eTens1Mul = tens1Mul / 10
                // 结果
                let rTens1Mul = tens1Mul % 10
                
                let r4 = rOnes1Mul
                let r5 = rTens1Mul
                let r6 = eTens1Mul
                
                let result = a * b
                // 算出个位，十位，百位，千位
                let resultOnes = result % 10
                let resultTens = (result / 10) % 10
                let resultHundreds = (result / 100) % 10
                let resultThousand = (result / 1000) % 10
                
                let r7 = resultOnes
                let r8 = resultTens
                let r9 = resultHundreds
                let r10 = resultThousand
                
                return ([aOnes, aTens, bOnes, bTens], [r1, r2, r3, r4, r5, r6, r7, r8, r9, r10])
            case .everalTensAndOne:
                // a: 只有Easy，则为[1 - 9]随机数；
                let a = Int.random(in: 1...9)
                // b: 只有Easy，则为[1 - 9]随机数；
                let b = Int.random(in: 1...9)
                
                // 先进行相加，判断是否有进位
                let c = a + b
                // 进位
                let eC = c / 10
                // 结果
                let rC = c % 10
                
                let r1 = rC
                
                let pre = a * b + eC
                let r2 = pre % 10
                let r3 = (pre / 10) % 10
                
                let r4 = eC
                
                return ([a, b], [r1, r2, r3, r4])
            case .decomposingTerms:
                // random: 都为easy模式，10-90之间
                let random = Int.random(in: 1...9) * 10
                // a: 为random + [1-9]的随机数
                let a = random + Int.random(in: 1...9)
                // b: 为[2-9]；
                let b = Int.random(in: 2...9)
                // r1: a * b
                let r1 = a * b
                // r2: r2 = random
                let r2 = random
                // r3: r2 = a - r2
                let r3 = a - r2
                // r4: r2 * b
                let r4 = r2 * b
                // r5: r3 * b
                let r5 = r3 * b
                
                return ([a, b], [r1, r2, r3, r4, r5])
            case .plus5or25:
                // a: 如果位数小于等于10，A为12到98之间的偶数随机，A不为整十数，如果位数大于10，A为8到36间且A为4的倍数随机；
                func calA() -> Int {
                    if digtal <= 10 {
                        let a = Int.random(in: 12...98)
                        if (a % 10 == 0) || (a & 1 != 0) {
                            return calA()
                        } else {
                            return a
                        }
                    } else {
                        let a = Int.random(in: 8...360)
                        return a - (a % 4)
                    }
                }
                let a = calA()
                // b: digtal <= 10 ? 5 : 25
                let b = digtal <= 10 ? 5 : 25
                // r1: a * b
                let r1 = a * b
                // r2: 2
                let r2 = digtal <= 10 ? 2 : 4
                // r3: 10
                let r3 = digtal <= 10 ? 10 : 100
                
                return ([a, b], [r1, r2, r3])
            }
        case .division(let skill):
            switch skill {
            case .multiplicationTable:
                // a: 只有easy模式，则为[1 - 9]随机数；
                let a = Int.random(in: 1...9)
                // b: 只有easy模式，则为[1 - 9]随机数；
                let b = Int.random(in: 1...9)
                // r1: a * b
                let r1 = a * b
                
                return ([r1, a], [b])
            case .verticalForm:
                // 随机生成商：<10时，为[11-49]
                let random = Int.random(in: 1...4)
                let result = random * 10 + Int.random(in: 1...9)
                
                // 生成b：2...(100 / result)
                var b = 100 / result
                if b != 2 {
                    b = Int.random(in: 2...b)
                }
                
                // 生成a: r7 * b
                let a = result * b
        
                // 算出个位，十位
                let aOnes = a % 10
                let aTens = (a / 10) % 10
                
                let r1 = aTens / b
                let r2 = b * r1
                let r3 = aTens % b
                let r4 = aOnes
                let r5 = r3
                let r6 = r4
                let r7 = (r5 * 10 + r6) / b
                
                return ([aOnes, aTens, b], [r1, r2, r3, r4, r5, r6, r7])
            case .dividedBy5Or25:
                // a: 如果位数小于等于10，A为60到490之间的10倍数随机，如果位数大于10，A为100到2400间100的倍数随机；
                func calA() -> Int {
                    if digtal <= 10 {
                        let a = Int.random(in: 60...490)
                        return a - (a % 10)
                    } else {
                        let a = Int.random(in: 100...2400)
                        return a - (a % 100)
                    }
                }
                let a = calA()
                let b = digtal <= 10 ? 5 : 25
                let r1 = a / b
                let r2 = digtal <= 10 ? 10 : 100
                let r3 = digtal <= 10 ? 2 : 4
                return ([a, b], [r1, r2, r3])
            case .decomposingTerms:
                // b: 都为easy，为[2 - 9]随机数；
                let b = Int.random(in: 2...9)
                // r1: 10 * b
                let r1 = 10 * b
                // r2: 1-9随机数 * b
                let r2 = Int.random(in: 1...9) * b
                // a: 10 * n +x * n，x个位数（1-9）
                let a = r1 + r2
                
                let r3 = r1 / b
                let r4 = r2 / b
                
                let r = a / b
                
                return ([a, b], [r, r1, r2, r3, r4])
            }
        }
    }
    
}

// MARK: - Private

private extension ArithmeticAlgorithmUtil {
    
    static func findAllDivisors(of number: Int) -> [Int] {
        var divisors = Set<Int>()
        let sqrtNum = Int(Double(number).squareRoot())
        
        for i in 1...sqrtNum {
            if number % i == 0 {
                divisors.insert(i)
                let val = number / i
                if i != val && val < 10 {
                    divisors.insert(val)
                }
            }
        }
        
        return Array(divisors).sorted()
    }
    
}
