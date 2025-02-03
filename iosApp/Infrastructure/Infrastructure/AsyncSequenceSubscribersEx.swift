//
//  AsyncSequenceSubscribersEx.swift
//  Infrastructure
//
//  Created by Дмитрий Пономарев on 02.02.2025.
//

import Foundation
import os

// MARK: - Метод для подписки на поля VM
public extension AsyncSequence {
    
    @discardableResult
    func subscribe(
        to subscribers: AsyncSequenceSubscribers,
        handler: @escaping (Element) async -> Void
    ) -> Task<Void, Never> {
        subscribers.subscribe(self, handler: handler)
    }
}

public final class AsyncSequenceSubscribers: Sendable {
    private let tasks = OSAllocatedUnfairLock<[UUID: SubscriberTask]>(initialState: [:])
    
    public init() {}
    
    @discardableResult
    public func subscribe<Sequence: AsyncSequence>(
        _ sequence: Sequence,
        handler: @escaping (Sequence.Element) async -> Void
    ) -> Task<Void, Never> {
        let id = UUID()
        let task = Task {
            do {
                for try await element in sequence {
                    await handler(element)
                }
            } catch { }
            
            tasks.withLock { tasks in
                switch tasks[id] {
                case nil: tasks[id] = .pendingToRemove
                case .active: tasks[id] = nil
                case .pendingToRemove: assertionFailure("Invalid state after finished task: 'pendingToRemove'")
                }
            }
        }
        tasks.withLock { tasks in
            switch tasks[id] {
            case nil: tasks[id] = .active(task)
            case .pendingToRemove: tasks[id] = nil
            case .active: assertionFailure("Invalid state after started task: 'active'")
            }
        }
        
        return task
    }
    
    public func unsubsribeAll() {
        tasks.withLock {
            $0.compactMap { $0.value.task }
        }.forEach {
            $0.cancel()
        }
    }
    
    // MARK: - Если класс 'AsyncSequenceSubscribers' создан в классе VM, то подписки (Task) сами будут отчищаться после ухода с экрана
    deinit {
        unsubsribeAll()
    }
    
    // MARK: - Состояния
    private enum SubscriberTask {
        case active(Task<Void, Never>)
        case pendingToRemove // When finished task before add to tasks
        
        var task: Task<Void, Never>? {
            switch self {
            case .active(let task): return task
            case .pendingToRemove: return nil
            }
        }
    }
}
