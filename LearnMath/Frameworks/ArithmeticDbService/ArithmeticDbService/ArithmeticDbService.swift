//
//  ArithmeticDbService.swift
//  ArithmeticDbService_Example
//
//  Created by Jackie on 2024/7/22.
//  Copyright © 2024 3commas. All rights reserved.
//

import Foundation
import DbService
import RealmSwift
import AppToolKit

public actor ArithmeticDbService {
    
    /// 最大训练次数
    public static let maxTrainCout: Int64 = 20
    
    static let kLogTag: String = "ArithmeticDbService"
    
    public init() {
        
    }
    
}

// MARK: - Math Category

public extension ArithmeticDbService {
    
    /// 获取分类
    @MainActor
    @discardableResult
    func fetchCategories() async throws -> Results<MathCategory>? {
        let categories: Results<MathCategory>? = try await DbService.shared.fetchList(MathCategory.self)
        return categories?.sorted(by: \.priority, ascending: true)
    }
    
    /// 获取分类
    @MainActor
    @discardableResult
    func fetchCategory(_ categoryId: String) async throws -> MathCategory? {
        let categories: Results<MathCategory>? = try await fetchCategories()
        let category = categories?.where { $0._id.equals(categoryId) }.first
        return category
    }
    
}

// MARK: - Math Skill

public extension ArithmeticDbService {
    
    /// 获取技能
    @MainActor
    @discardableResult
    func fetchSkills() async throws -> Results<MathSkill>? {
        let skills: Results<MathSkill>? = try await DbService.shared.fetchList(MathSkill.self)
        return skills?.where { $0.isHidden == false }
    }
    
    /// 获取技能
    @MainActor
    @discardableResult
    func fetchSkills(_ categoryId: String) async throws -> Results<MathSkill>? {
        var skills: Results<MathSkill>? = try await fetchSkills()
        skills = skills?.where { $0.categoryId.equals(categoryId) && $0.isHidden == false }.sorted(by: \.priority, ascending: true)
        return skills
    }
    
    /// 获取技能
    @MainActor
    @discardableResult
    func fetchSkill(_ skillId: String) async throws -> MathSkill? {
        let skills: Results<MathSkill>? = try await fetchSkills()
        let skill = skills?.where { $0._id.equals(skillId) }.first
        return skill
    }
    
    /// 更新技能
    @MainActor
    func updateSkillTrainCount(_ skill: MathSkill, trainCount: Int64) async throws {
        try await DbService.shared.transactions { (db: Realm) in
            skill.trainCount = trainCount
        }
    }
    
}

// MARK: - Math Bank

public extension ArithmeticDbService {
    
    /// 获取题库
    @MainActor
    @discardableResult
    func fetchBanks() async throws -> Results<MathBank>? {
        let banks: Results<MathBank>? = try await DbService.shared.fetchList(MathBank.self)
        return banks
    }
    
}

// MARK: - Math Question

public extension ArithmeticDbService {
    
    /// 创建题目
    @MainActor
    @discardableResult
    func generateQuestion(_ categoryId: String, skillId: String, digits: Int64) async throws -> MathQuestion? {
        // 获取题库
        let banks = try await fetchBanks()
        let bank = banks?.where { $0.categoryId.equals(categoryId) && $0.skillId.equals(skillId) }.first
        let question = MathQuestion()
        question._id = String.egg.getUUID()
        question.categoryId = categoryId
        question.skillId = skillId
        question.bankId = bank?._id ?? ""
        question.digits = digits
        question.time = Int64(Date().timeIntervalSince1970)
        // 生成数字和答案
        if let category = ArithmeticAlgorithmCategory.generate(bank?._id ?? "") {
            let results = ArithmeticAlgorithmUtil.generate(category, digtal: Int(digits))
            let answer = MathQuestionAnswer()
            answer.numbers.append(objectsIn: results.numbers)
            answer.answers.append(objectsIn: results.answers)
            question.answer = answer
            return question
        } else {
            throw ArithmeticDbServiceError.generateAlgorithmError
        }
    }
    
    /// 保存题目
    @MainActor
    func saveQuestion(_ question: MathQuestion) async throws {
        do {
            try await DbService.shared.create([question])
        } catch {
            throw ArithmeticDbServiceError.generateAlgorithmError
        }
    }
    
    /// 获取题目
    @MainActor
    @discardableResult
    func fetchQuestions() async throws -> Results<MathQuestion>? {
        let questions: Results<MathQuestion>? = try await DbService.shared.fetchList(MathQuestion.self)
        return questions
    }
    
    /// 获取题目
    @MainActor
    @discardableResult
    func fetchQuestion(_ questionId: String) async throws -> MathQuestion? {
        let questions: Results<MathQuestion>? = try await fetchQuestions()
        return questions?.where { $0._id.equals(questionId) }.first
    }
    
}

// MARK: - Math WorkBooks

public extension ArithmeticDbService {
    
    /// 创建作业
    @MainActor
    @discardableResult
    func generateWorkBooks(_ question: MathQuestion?, total: Int64, style: MathWorkBooksStyle, selectedTrainOptions: MathWorkSelectedTrainOptions?, selectedTestOptions: MathWorkSelectedTestOptions?) async throws -> MathWorkBooks? {
        // 作业
        let workbook = MathWorkBooks()
        workbook._id = String.egg.getUUID()
        if let question = question {
            workbook.questionIds.append(question._id)
        }
        workbook.total = total
        workbook.style = style
        if let options = selectedTrainOptions {
            workbook.selectedTrainOptions = options
        }
        if let options = selectedTestOptions {
            workbook.selectedTestOptions = options
        }
        workbook.time = Int64(Date().timeIntervalSince1970)
        try await DbService.shared.create([workbook])
        return workbook
    }
    
    /// 获取作业
    @MainActor
    @discardableResult
    func fetchWorkBooks() async throws -> Results<MathWorkBooks>? {
        let workbooks: Results<MathWorkBooks>? = try await DbService.shared.fetchList(MathWorkBooks.self)
        return workbooks
    }
    
    /// 获取作业
    @MainActor
    @discardableResult
    func fetchWorkBook(_ workbookId: String) async throws -> MathWorkBooks? {
        let workbooks: Results<MathWorkBooks>? = try await fetchWorkBooks()
        return workbooks?.where { $0._id.equals(workbookId) }.first
    }
    
    /// 更新题目id到作业本
    @MainActor
    func updateQuestionIdToWorkBook(_ workBook: MathWorkBooks, questionId: String) async throws {
        try await DbService.shared.transactions { (db: Realm) in
            workBook.questionIds.append(questionId)
        }
    }
    
}

// MARK: - Math Train

public extension ArithmeticDbService {
    
    /// 获取训练的选项
    @MainActor
    @discardableResult
    func fetchTrainOptions() async throws -> Results<MathTrainList>? {
        let trains: Results<MathTrainList>? = try await DbService.shared.fetchList(MathTrainList.self)
        return trains
    }
    
}

// MARK: - Math Tests

public extension ArithmeticDbService {
    
    /// 获取测试的选项
    @MainActor
    @discardableResult
    func fetchTestsOptions() async throws -> Results<MathTestList>? {
        let tests: Results<MathTestList>? = try await DbService.shared.fetchList(MathTestList.self)
        return tests
    }
    
}

// MARK: - Math Success Record

public extension ArithmeticDbService {
    
    /// 记录做对的题目
    @MainActor
    func generateSuccessRecord(_ questionId: String, workbookId: String, categoryId: String, skillId: String, style: MathWorkBooksStyle) async throws {
        let recode = MathSuccessRecords()
        recode._id = String.egg.getUUID()
        recode.questionId = questionId
        recode.workbookId = workbookId
        recode.categoryId = categoryId
        recode.skillId = skillId
        recode.style = style
        recode.time = Int64(Date().timeIntervalSince1970)
        try await DbService.shared.create([recode])
    }
    
    /// 获取做对的题目
    @MainActor
    @discardableResult
    func fetchSuccessRecords() async throws -> Results<MathSuccessRecords>? {
        let successRecords: Results<MathSuccessRecords>? = try await DbService.shared.fetchList(MathSuccessRecords.self)
        return successRecords
    }
    
    /// 获取做对的题目
    @MainActor
    @discardableResult
    func fetchSuccessRecords(by skillId: String) async throws -> Results<MathSuccessRecords>? {
        let successRecords: Results<MathSuccessRecords>? = try await fetchSuccessRecords()
        return successRecords?.where { $0.skillId.equals(skillId) }
    }
    
    /// 获取做对的题目
    @MainActor
    @discardableResult
    func fetchSuccessRecords(with workbookId: String) async throws -> Results<MathSuccessRecords>? {
        let successRecords: Results<MathSuccessRecords>? = try await fetchSuccessRecords()
        return successRecords?.where { $0.workbookId.equals(workbookId) }
    }
    
}

// MARK: - Math Error Record

public extension ArithmeticDbService {
    
    /// 记录做错的题目
    @MainActor
    func generateErrorRecord(_ questionId: String, workbookId: String, categoryId: String, skillId: String, style: MathWorkBooksStyle) async throws {
        let recode = MathErrorRecords()
        recode._id = String.egg.getUUID()
        recode.questionId = questionId
        recode.workbookId = workbookId
        recode.categoryId = categoryId
        recode.skillId = skillId
        recode.style = style
        recode.time = Int64(Date().timeIntervalSince1970)
        try await DbService.shared.create([recode])
    }
    
    /// 获取做错的题目
    @MainActor
    @discardableResult
    func fetchErrorRecords() async throws -> Results<MathErrorRecords>? {
        let errorRecords: Results<MathErrorRecords>? = try await DbService.shared.fetchList(MathErrorRecords.self)
        return errorRecords
    }
    
    /// 获取做错的题目
    @MainActor
    @discardableResult
    func fetchErrorRecords(by skillId: String) async throws -> Results<MathErrorRecords>? {
        let errorRecords: Results<MathErrorRecords>? = try await fetchErrorRecords()
        return errorRecords?.where { $0.skillId.equals(skillId) }.sorted(by: \.time, ascending: false)
    }
    
    /// 获取做错的题目
    @MainActor
    @discardableResult
    func fetchErrorRecords(with workbookId: String) async throws -> Results<MathErrorRecords>? {
        let errorRecords: Results<MathErrorRecords>? = try await fetchErrorRecords()
        return errorRecords?.where { $0.workbookId.equals(workbookId) }.sorted(by: \.time, ascending: false)
    }
    
}

// MARK: - Math Success Record

public extension ArithmeticDbService {
    
    /// 删除
    @MainActor
    func deleteObjs(_ objs: [any ObjectCapable]) async throws {
        try await DbService.shared.delete(objs)
    }
    
}
