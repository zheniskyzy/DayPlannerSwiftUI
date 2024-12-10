//
//  AddTaskView.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 31.10.2024.
//

import SwiftUI

struct AddTaskView: View {
    @State var rightImage: UIImage? = nil
    @State var task: Task = .mock
    @State var title: String = ""
    @State private var note: String = ""
    private let colors: [Color] = [.plannerYellow, .plannerLightGreen, .plannerBlue]
    @State private var isAlarmOn: Bool = true
    @Environment(\.presentationMode) var dismiss
    var onSave: ((Task) -> Void)? = nil
    @State var currentDate: Date
    
    init(currentDate: Date, onSave: ((Task) -> Void)? = nil) {
        self._currentDate = State(initialValue: currentDate)
        self.onSave = onSave
    }
    
    var body: some View {
        ZStack {
            Color.plannerGreen.ignoresSafeArea()
            VStack {
                Header(leftImage: "xmark", rightImage: rightImage) {
                    dismiss.wrappedValue.dismiss()
                }
                .frame(maxHeight: 90)

                Spacer()
                Text ("Add Note")
                    .foregroundStyle(Color.white)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                ZStack {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 50, topTrailing: 50))
                        .fill(Color.white)
                        .ignoresSafeArea()
                    ScrollView {
                        VStack {
                            customDateTimePicker
                            textFieldEditor
                            pickersForColor
                            
                            Text("Save")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(Color.white)
                                .padding(.all, 30)
                                .padding(.horizontal, 20)
                                .background(Color.plannerYellow)
                                .cornerRadius(20)
                                .padding(.horizontal, 30)
                                .padding(.top, 15)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onTapGesture {
                                    if !task.inputNote.isEmpty || !task.inputTitle.isEmpty {
                                        onSave?(Task(selectedDay: task.selectedDay, selectedMonth: task.selectedMonth, selectedHour: task.selectedHour, selectedMinute: task.selectedMinute, inputTitle: task.inputTitle, inputNote: task.inputNote, isAM: task.isAM, selectedTask: task.selectedTask))
                                    }
                                    dismiss.wrappedValue.dismiss()
                                }
                        }
                    }
                }
            }
        }
    }
    private var customDateTimePicker: some View {
        VStack{
            
            Text("Date and Time")
                .foregroundStyle(Color.black)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 20)
            
            HStack {
                VStack {
                    Text("Day")
                        .font(.callout)
                        .foregroundStyle(Color.gray)
                    
                    Picker("", selection: $task.selectedDay) {
                        ForEach(1...31, id: \.self) { day in
                            Text("\(day)").tag("\(day)")
                                .foregroundStyle(.black)
                        }
                    }
                    .onAppear {
                       task.selectedDay = Calendar.current.component(.day, from: currentDate)
                   }
                    .frame(width: 50, height: 100)
                    .clipped()
                }
                
                VStack {
                    Text("Month")
                        .foregroundStyle(Color.gray)
                        .font(.callout)
                    Picker("", selection: $task.selectedMonth) {
                        ForEach(1...12, id: \.self) { month in
                            Text(String(format: "%02d", month)).tag("\(month)") // чтоб впереди был 0
                                .foregroundStyle(.black)
                        }
                    }
                    .onAppear {
                        task.selectedMonth = Calendar.current.component(.month, from: currentDate)
                   }
                    .frame(width: 50, height: 100)
                    .clipped()
                }
                .padding(.trailing, 20)
                VStack {
                    Text("Hour")
                        .foregroundStyle(Color.gray)
                        .font(.callout)
                    Picker("", selection: $task.selectedHour) {
                        ForEach(1...12, id: \.self) { hour in
                            Text(String(format: "%02d", hour)).tag("\(hour)")
                                .foregroundStyle(.black)
                        }
                    }
                    .onAppear {
                        let hour = Calendar.current.component(.hour, from: currentDate)
                        if hour == 0 {
                            task.selectedHour = 12
                        } else if hour > 12 {
                            task.selectedHour =  hour - 12
                        } else {
                            task.selectedHour = hour
                        }
                   }
                    .frame(width: 50, height: 100)
                    .clipped()
                }
                VStack {
                    Text("Minute")
                        .foregroundStyle(Color.gray)
                        .font(.callout)
                    Picker("", selection: $task.selectedMinute) {
                        ForEach(0...59, id: \.self) { minute in
                            Text(String(format: "%02d", minute)).tag("\(minute)")
                                .foregroundStyle(.black)
                        }
                    }
                    .onAppear {
                        task.selectedMinute = Calendar.current.component(.minute, from: currentDate)
                   }
                    .frame(width: 50, height: 100)
                    .clipped()
                }
                Picker("AM/PM", selection: $task.isAM) {
                    Text("AM").tag(true)
                        .foregroundStyle(.black)
                    Text("PM").tag(false)
                        .foregroundStyle(.black)
                }
                .onAppear {
                   let hour = Calendar.current.component(.hour, from: currentDate)
                    task.isAM = hour < 12
                }
                .frame(width: 60, height: 100)
                .padding(.top, 25)
                .clipped()
            }
            .pickerStyle(.wheel)
            .bold()
        }
    }
    private var textFieldEditor: some View {
        VStack {
            Text("Title")
                .foregroundStyle(Color.black)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
            
            TextField("White the title", text: $task.inputTitle)
                .padding()
                .foregroundStyle(.black)
                .background(.plannerTextFieldWhite)
                .cornerRadius(15)
                .padding(.horizontal, 30)
            
            Text("Note")
                .foregroundStyle(Color.black)
                .font(.title3)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 8)
            
            TextEditor(text: $task.inputNote)
                .padding()
                .foregroundStyle(.black)
                .background(.plannerTextFieldWhite)
                .cornerRadius(10)
                .padding(.horizontal, 30)
                .frame(height: 100)
                .scrollContentBackground(.hidden)
            
        }
    }
    private var pickersForColor: some View {
        HStack {
            VStack {
                Text("Color")
                    .foregroundStyle(Color.black)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.top, 15)
                    
                HStack {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                            .overlay {
                                if task.selectedTask.colorStatus == color {
//                                if color == .plannerYellow {
                                    Image(systemName: "checkmark")
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                        .bold()
                                }
                            }
                            .onTapGesture {
                                if color == .plannerYellow {
                                    task.selectedTask = .Done
                                } else if color == .plannerLightGreen {
                                    task.selectedTask = .InProgress
                                } else {
                                    task.selectedTask = .NotDone
                                }
                            }
                    } 
                }
            }
            VStack {
                Text("Alaram")
                    .foregroundStyle(Color.black)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal, 30)
                    .padding(.top, 15)
                
                Toggle(isOn: $isAlarmOn) {
                    EmptyView()
                }
                .tint(.plannerGreen)
                .labelsHidden()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    @State var currentDate = Date()
   return AddTaskView(currentDate: currentDate)
}
