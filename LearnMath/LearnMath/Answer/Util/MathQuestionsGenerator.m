//
//  MathQuestionsGenerator.m
//  LearnMath
//
//  Created by 基 on 2025/10/20.
//

#import "MathQuestionsGenerator.h"
#import "MathAnswerSheetEntry.h"
#import "MathAnswerSheetMode.h"
#import "ArithmeticDbService.h"
#import "MathQuestions.h"
#import "MathQuestionAnswer.h"
#import "MathWorkBooks.h"
#import "MathSkills.h"
#import "MathWorkSelectedTestOptions.h"
#import "MathWorkSelectedTrainOptions.h"
@interface MathQuestionsGenerator ()
@property (nonatomic, strong) MathAnswerSheetEntry *entry;
@property (nonatomic, copy) void(^nextTaskAction)(MathQuestionsTask *task);
@property (nonatomic, copy) void(^completedAction)(MathQuestionsTask * _Nullable task);

@property (nonatomic, strong) NSMutableArray<MathQuestionsTask *> *tasks;
@property (nonatomic, strong) NSMutableArray<NSString *> *hadTestSkillIds;
@property (nonatomic, assign) NSInteger lastTrainCount;
@property (nonatomic, assign) NSInteger maxTaskCount;
@property (nonatomic, assign) NSTimeInterval limitTime;
@property (nonatomic, assign) NSInteger retryCount;
@property (nonatomic, assign) NSTimeInterval lostTime;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isTimerPause;
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, copy) NSString *workbookID;

@end

@implementation MathQuestionsGenerator
- (instancetype)initWithEntry:(MathAnswerSheetEntry *)entry
               nextTaskAction:(void(^)(MathQuestionsTask *task))nextTaskAction
              completedAction:(void(^)(MathQuestionsTask * _Nullable task))completedAction {
    if (self = [super init]) {
        _entry = entry;
        _nextTaskAction = [nextTaskAction copy];
        _completedAction = [completedAction copy];
        _dbService = [[ArithmeticDbService alloc] init];
        _tasks = [NSMutableArray array];
        _hadTestSkillIds = [NSMutableArray array];
        self.isTimerPause = NO;
        self.isCompleted = NO;
    }
    return self;
}



- (void)start {
    switch (self.entry.mode.type) {
        case MathAnswerSheetModeTypeQuestionsLimit:
            self.maxTaskCount = self.entry.mode.total;
            [self next];
            break;
        case MathAnswerSheetModeTypeTimeLimit:
            self.maxTaskCount = self.entry.mode.total;
            self.limitTime = self.entry.mode.limitTime;
            [self next];
            break;
        case MathAnswerSheetModeTypeSurvive:
            self.retryCount = 3;
            [self next];
            break;
            
    }
}

- (void)reduceCount {
    if (self.entry.mode.type == MathAnswerSheetModeTypeSurvive) {
        self.retryCount -= 1;
    }
}

- (void)next {
    if (self.isCompleted) {
            return;
        }
        
    switch (self.entry.mode.type) {
        case MathAnswerSheetModeTypeQuestionsLimit:
            if (self.tasks.count >= self.maxTaskCount &&
                self.entry.type == MathAnswerSheetEntryTypeTest) {
                [self finished];
                return;
            }
            break;
        case MathAnswerSheetModeTypeTimeLimit:
            if (self.entry.mode.total > 0 && self.tasks.count >= self.maxTaskCount &&
                self.entry.type == MathAnswerSheetEntryTypeTest) {
                [self finished];
                return;
            }
            break;
        case MathAnswerSheetModeTypeSurvive:
            if (self.retryCount <= 0) {
                [self finished];
                return;
            }
            break;
    }
        
    NSDictionary *tuple = [self generateQuestion];
    MathQuestions *question = tuple[@"question"];
    MathWorkBooks *workBook = tuple[@"workBook"];
    
    NSInteger extraCount = 0;
    if ([workBook.style isEqualToString:@"train"] && self.lastTrainCount == 0 && self.tasks.count == 0) {
        MathSkills *skill = [self.dbService fetchSkillWithSkillID:question.skillID];
        extraCount = MIN(self.maxTaskCount - 1, skill.trainCount);
        self.lastTrainCount = extraCount;
    }
    
    NSInteger count = self.tasks.count + 1 + self.lastTrainCount;
    if ([workBook.style isEqualToString:@"train"]) {
        count = MIN(self.maxTaskCount, count);
    }
    MathQuestionsTask *task = [[MathQuestionsTask alloc] initWithQuestion:question workBook:workBook taskIndex:count generator:self];
    
    [self.tasks addObject:task];
    
    if (self.nextTaskAction) {
        self.nextTaskAction(task);
    }
    
    if (self.limitTime > 0) {
        if (!self.timer) {
            if (task.progressCompletion) task.progressCompletion(0.0);
            [self startTimer];
        } else if (self.entry.type == MathAnswerSheetEntryTypeTrain) {
            if (task.progressCompletion) task.progressCompletion(0.0);
            [self startTimer];
        }
    } else {
        [self stopTimer];
    }
}


- (BOOL)checkAnsersQuestion:(NSArray<NSNumber *> *)answer
{
    if (answer.count == 0 || self.tasks.count == 0) {
        return NO;
    }
    
    NSInteger count = self.tasks.count;
    NSRange range = NSMakeRange(MAX(count - 3, 0), MIN(3, count));
    NSArray *preThreeTasks = [self.tasks subarrayWithRange:range];
    
    if (preThreeTasks.count == 0) {
        return NO;
    }
    
    for (id task in preThreeTasks) {
        id question = [task valueForKey:@"question"];
        id answerObj = [question valueForKey:@"answer"];
        NSArray *numbers = [answerObj valueForKey:@"numbers"];
        
        if ([numbers isKindOfClass:[NSArray class]] &&
            [numbers isEqualToArray:answer]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSDictionary *)generateQuestion
{
    switch (self.entry.type) {
        case MathAnswerSheetEntryTypeTrain:{
            MathWorkSelectedTrainOptions *options = self.entry.trainOptions;
            NSString *categoryID = [self.dbService fetchCategoryIDSkillID:self.entry.trainOptions.skillID];
            
            int64_t digits = [options.trainDigitKey isEqualToString:@"1"] ? 10 : 100;
            
            MathQuestions *question = [self.dbService generateQuestionWithCategoryId:categoryID skillId:options.skillID digits:digits];

            if (question.answer && [self checkAnsersQuestion:question.answer.numbers]) {
                return [self generateQuestion];
            }
            
           [self.dbService saveQuestion:question];
            
            MathWorkBooks *workBook = nil;
            if (self.workbookID) {
                workBook = [self.dbService fetchWorkBookWithId:self.workbookID];
                
                if (workBook) {
                    [self.dbService updateWorkBook:workBook withQuestion:question];
                    return @{@"question": question, @"workBook": workBook};
                }
            } else {
                workBook = [self.dbService generateWorkBookWithQuestion:question total:self.maxTaskCount style:@"train" selectedTrainOptions:options selectedTestOptions:nil];
                if (workBook) {
                    self.workbookID = workBook.bookID;
                    [self.dbService updateWorkBook:workBook withQuestion:question];
                    return @{@"question": question, @"workBook": workBook};
                }
            }
            break;
        }
        case MathAnswerSheetEntryTypeTest:{
            MathWorkSelectedTestOptions *options = self.entry.testOptions;
            NSMutableArray<MathSkills *> *finalSkills = [NSMutableArray array];
            if ([options.testRangeKey isEqualToString:@"1"] ||
                [options.testRangeKey isEqualToString:@"2"] ||
                [options.testRangeKey isEqualToString:@"3"]) {
                NSMutableArray<MathSkills *> *selectedSkills = [NSMutableArray array];
                for (NSString *testSkillID in options.testSkills) {
                    MathSkills *skill = [self.dbService fetchSkillWithSkillID:testSkillID];
                    if (skill) {
                        [selectedSkills addObject:skill];
                    }
                }
                finalSkills = selectedSkills;
            }
            
            MathSkills *skill = nil;
            if (finalSkills.count == self.hadTestSkillIds.count) {
                NSUInteger index = arc4random_uniform((uint32_t)finalSkills.count);
                skill = finalSkills[index];
            } else {
                NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(MathSkills *evaluatedSkill, NSDictionary<NSString *,id> * _Nullable bindings) {
                    return ![self.hadTestSkillIds containsObject:evaluatedSkill.skillID];
                }];
                NSArray<MathSkills *> *skills = [finalSkills filteredArrayUsingPredicate:predicate];
                NSUInteger index = arc4random_uniform((uint32_t)skills.count);
                skill = skills[index];
                if (skill) {
                    [self.hadTestSkillIds addObject:skill.skillID];
                }
            }
            int64_t digits = [options.testDigitKey isEqualToString:@"1"] ? 10 : 100;
            
            MathQuestions *question = [self.dbService generateQuestionWithCategoryId:skill.categoryID skillId:skill.skillID digits:digits];
        
            if (question.answer && [self checkAnsersQuestion:question.answer.numbers]) {
                return [self generateQuestion];
            }
           [self.dbService saveQuestion:question];
            
            MathWorkBooks *workBook = nil;
            if (self.workbookID) {
                workBook = [self.dbService fetchWorkBookWithId:self.workbookID];
                
                if (workBook) {
                    [self.dbService updateWorkBook:workBook withQuestion:question];
                    return @{@"question": question, @"workBook": workBook};
                }
            } else {
                workBook = [self.dbService generateWorkBookWithQuestion:question total:self.maxTaskCount style:@"test" selectedTrainOptions:nil selectedTestOptions:options];
                if (workBook) {
                    self.workbookID = workBook.bookID;
                    [self.dbService updateWorkBook:workBook withQuestion:question];
                    return @{@"question": question, @"workBook": workBook};
                }
            }
            break;
        }
        default:
            break;
    }
    return nil;
}



- (void)finished {
    [self stopTimer];
    if (self.completedAction) self.completedAction(self.tasks.lastObject);
    self.isCompleted = YES;
    
}

- (void)finishByUser {
    [self stopTimer];
}

- (void)startTimer {
    [self stopTimer];
    self.lostTime = self.limitTime;
    
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.isTimerPause) return;
        
        strongSelf.lostTime -= 1;
        
        CGFloat proress = 1.0 - (strongSelf.lostTime / MAX(strongSelf.limitTime, 1));
        MathQuestionsTask *currentTask = strongSelf.tasks.lastObject;
        if (currentTask.progressCompletion) {
            currentTask.progressCompletion(proress);
        }
        
        if (strongSelf.lostTime <= 0) {
            [strongSelf stopTimer];
            if (strongSelf.entry.type == MathAnswerSheetEntryTypeTest) {
                strongSelf.isCompleted = YES;
            }
            [currentTask failure];
            

            if (strongSelf.entry.type == MathAnswerSheetEntryTypeTest) {
                [strongSelf finished];
            }
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    self.lostTime = 0.0;
    [self.timer invalidate];
    self.timer = nil;
}

- (void)recordSuccessQuestion:(MathQuestionsTask *)task {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            // 如果是训练模式
            if (self.entry.type == MathAnswerSheetEntryTypeTrain) {
                MathSkills *skill = [self.dbService fetchSkillWithSkillID:task.question.skillID];
                if (skill) {
                    NSInteger count = skill.trainCount + 1;
                    [self.dbService updateSkillTrainCount:skill.skillID trainCount:count];
                }
            }
            // 记录对题
            [self.dbService generateSuccessRecordWithQuestionId:task.question.questionID workbookId:task.workBook.bookID categoryId:task.question.categoryID skillId:task.question.skillID style:task.workBook.bookID];
        } @catch (NSException *exception) {
            NSLog(@"recordSuccessQuestion error: %@", exception);
        }
    });
}

- (void)recordFailureQuestion:(MathQuestionsTask *)task {
    // 如果是训练模式，停止计时器
    if ([task.workBook.style isEqualToString:@"train"]) {
        [self stopTimer];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            // 如果是训练模式
            if (self.entry.type == MathAnswerSheetEntryTypeTrain) {
                MathSkills *skill = [self.dbService fetchSkillWithSkillID:task.question.skillID];
                if (skill) {
                    NSInteger count = skill.trainCount + 1;
                    [self.dbService updateSkillTrainCount:skill.skillID trainCount:count];
                }
            }
            // 记录错题
            [self.dbService generateErrorRecordWithQuestionId:task.question.questionID workbookId:task.workBook.bookID categoryId:task.question.categoryID skillId:task.question.skillID style:task.workBook.style];
        } @catch (NSException *exception) {
            NSLog(@"recordFailureQuestion error: %@", exception);
        }
    });
}
@end

