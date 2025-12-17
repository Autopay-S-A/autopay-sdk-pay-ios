//
//  ErrorState.swift
//  AutopaySdk
//
//  Copyright © 2025 Autopay S.A. All rights reserved.
//


import Foundation
import AutopaySdk

struct ErrorState: Identifiable, Equatable {
    let id = UUID()
    let message: String
    let retry: () -> Void
    
    init(error: Error, retry: @escaping () -> Void) {
        self.message = (error as? APError)?.message ?? "demo_general_error"
        self.retry = retry
    }
    
    static func == (lhs: ErrorState, rhs: ErrorState) -> Bool { lhs.id == rhs.id }
}
