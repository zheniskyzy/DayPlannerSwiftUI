//
//  TaskProgressCell.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 28.10.2024.
//

import SwiftUI

struct TaskProgressCell: View {

    @State var task: Task
    let pickerOptions: [String] = ["Done", "In Progress", "Not Started"]
    @State var selection: String?
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(task.selectedTask.colorStatus)
                    .frame(width: 42, height: 42)

                Image(systemName: task.selectedTask.markStatus)
                .foregroundStyle(Color.white)
                .bold()
            }
            .padding(.leading, 30)
            .padding(.trailing, 20)
            .onTapGesture {

            }
            
            VStack(alignment: .leading) {
                Text(task.inputTitle.capitalized)
                    .font(.headline)
                    .bold()
                    .foregroundStyle(Color.black)
                    .padding(.bottom, 2)
            
                Text("\(String(format: "%02d",task.selectedHour)): \(String(format: "%02d", task.selectedMinute)) \(task.isAM ? "AM" : "PM")")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(Color.plannerLightGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
           
            Text(task.selectedTask.rawValue)
                .foregroundStyle(Color.white)
                .font(.headline)
                .bold()
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                .background(task.selectedTask.colorStatus)
                .cornerRadius(25)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
                .onTapGesture {
                    // смена цвета и надписи
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .onAppear {
            print("Cell appeared for task: \(task.inputTitle)")
        }
    }
}



#Preview {
    @State var task: Task = Task(selectedDay: 5, selectedMonth: 5, selectedHour: 5, selectedMinute: 5, inputTitle: "input", inputNote: "inputNote", isAM: true, selectedTask: .NotDone)
    
    return TaskProgressCell(task: task)
}
