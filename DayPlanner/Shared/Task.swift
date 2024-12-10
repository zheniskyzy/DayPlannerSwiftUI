//
//  Task.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 18.11.2024.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    let id = UUID().uuidString
    var selectedDay: Int
    var selectedMonth: Int
    var selectedHour: Int
    var selectedMinute: Int
    var inputTitle: String
    var inputNote: String
    var isAM: Bool
    var selectedTask: TaskStatus
    
    static var mock: Task {
        Task(selectedDay: 6, selectedMonth: 6, selectedHour: 6, selectedMinute: 20, inputTitle: "UI/UX Design", inputNote: "", isAM: true, selectedTask: .NotDone)
    }
}
extension Task {
    func toDateComponents() -> DateComponents {
        var components = DateComponents()
        components.day = selectedDay
        components.month = selectedMonth
        components.hour = isAM ? selectedHour : (selectedHour + 12) % 24
        components.minute = selectedMinute
        return components
    }
}

enum TaskStatus: String, CaseIterable {
    case Done = "Done"
    case InProgress = "In Progress"
    case NotDone = "Not Done"
    
    var colorStatus: Color {
        switch self {
        case .Done:
            return .plannerYellow
        case .InProgress:
            return .plannerLightGreen
        case .NotDone:
            return .plannerBlue
        }
    } 
    
    var markStatus: String {
        switch self {
        case .Done:
            return "checkmark"
        case .InProgress:
            return  "circle.fill"
        case .NotDone:
            return "xmark"
        }
    }
}
