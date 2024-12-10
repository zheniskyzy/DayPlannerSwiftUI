//
//  PlanOfTheDayView.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 28.10.2024.
//

import SwiftUI

struct DailyTaskView: View {
    
    @Binding var isOpen: Bool
    @Binding var tasks: [Task]
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Capsule()
                    .frame(width: 40, height: 5)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                
                Text("Daily Task")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 30)
//                    .padding(.bottom, -15)
                    .padding(.bottom, 20)
                if tasks.isEmpty {
                    VStack {
//                        Image(systemName: "lasso.badge.sparkles")
//                            .resizable()
//                            .frame(width: 100, height: 100)
//                            .foregroundStyle(.plannerGreen)
                        
                        Text("No Tasks")
                            .padding(.vertical, 5)
                            .font(.headline)
                            .foregroundStyle(.gray)
                        
                        Text("Tap + to add your first task")
                            .font(.headline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(tasks, id: \.id, content: { task in
                            TaskProgressCell(task: task)
                        })
                        .padding(.vertical, 10)
                    }
                }
            }
        }
        .overlay {
            if !isOpen && !tasks.isEmpty {
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.001), Color.white.opacity(1.5)]), startPoint: .top, endPoint: .center)
            }
            
        }
    }
}

#Preview {
    @State var isOpen: Bool = false
//    @State var tasks: [Task] = Array(repeating: Task.mock, count: 5)
    @State var tasks: [Task] = []
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.55
    @State var currentDragOffsetY: CGFloat  = 0
    @State var endingOffsetY: CGFloat  = 0
    
   return ZStack {
        Color.plannerGreen.ignoresSafeArea()
        VStack {
          DailyTaskView(isOpen: $isOpen, tasks: $tasks)
               .cornerRadius(60)
               .offset(y: startingOffsetY)
               .offset(y: currentDragOffsetY)
               .offset(y: endingOffsetY)
               .overlay(alignment: .bottomTrailing) {
                   
                   Image(systemName: "plus")
                       .foregroundStyle(Color.white)
                       .font(.largeTitle)
                       .frame(width: 80, height: 80)
                       .background(Color.plannerOrange.cornerRadius(20))
                       .padding(.bottom, 10)
                       .padding(.trailing, 30)
               }
       }
    }
}
