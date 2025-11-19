//
//  ArithmeticCacheUtil.swift
//  ArithmeticDbService
//
//  Created by Jackie on 8/18/24.
//

import Foundation
import DbService
import RealmSwift

public struct ArithmeticCacheUtil {
    
    public init() {}
    
}

// MARK: - Public

public extension ArithmeticCacheUtil {
  
    /// 清理训练的缓存
    @MainActor
    static func clearTrainCache() async throws {
        let dbService = ArithmeticDbService()
        
        // 获取所有训练的作业本
        let workbooks = try await dbService.fetchWorkBooks()?.where { $0.style.equals(.train) }
        
        guard let workbooks = workbooks, !workbooks.isEmpty else { return }
        
        let questionIds: [String] = workbooks.reduce([String]()) { partialResult, workbook in
            var partialResult = partialResult
            partialResult.append(contentsOf: workbook.questionIds)
            return partialResult
        }
        
        var objs: [any ObjectCapable] = []
        
        // 移除所有的错题和对题
        let errorRecords = try await dbService.fetchErrorRecords()?.filter({ record in
            return questionIds.contains { $0 == record.questionId }
        })
        if let errorRecords = errorRecords, !errorRecords.isEmpty {
            objs.append(contentsOf: Array(errorRecords))
        }
        
        let successRecords = try await dbService.fetchSuccessRecords()?.filter({ record in
            return questionIds.contains { $0 == record.questionId }
        })
        if let successRecords = successRecords, !successRecords.isEmpty {
            objs.append(contentsOf: Array(successRecords))
        }
        
        // 移除所有的题目
        let questions = try await dbService.fetchQuestions()?.filter({ question in
            return questionIds.contains { $0 == question._id }
        })
        if let questions = questions, !questions.isEmpty {
            objs.append(contentsOf: Array(questions))
        }
        
        // 移除所有的作业
        objs.append(contentsOf: Array(workbooks))
        
        if !objs.isEmpty {
            try await dbService.deleteObjs(objs)
        }
    }
    
}
