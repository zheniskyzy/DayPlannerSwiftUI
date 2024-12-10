//
//  HomeView.swift
//  DayPlanner
//
//  Created by Madina Olzhabek on 28.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    private var days: [String] = ["M", "T", "W", "T", "F", "S", "S"]
    private var gridItemForDays = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var notaskSheetIsOpen: Bool = false
    @State private var selectedDate = Date()
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.55
    @State var currentDragOffsetY: CGFloat  = 0
    @State var endingOffsetY: CGFloat  = 0
    @State var DailyTaskViewIsOpen: Bool = false
    @State var isAddTaskOpen: Bool = false
    @State private var tasks: [Task] = []
    
    var body: some View {
        ZStack {
            Color.plannerGreen.ignoresSafeArea()
            
            VStack {
                Header(leftImage: "line.3.horizontal", rightImage: UIImage(resource: .myAvatar)) {
                    notaskSheetIsOpen = true
                }

                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .tint(Color.plannerDatePickerGreen)
                    .preferredColorScheme(.dark)
                    .onChange(of: selectedDate) {
                        print("Selected date changed")
                    }
                Spacer()
            }
            
//            DailyTaskView(isOpen: $DailyTaskViewIsOpen, tasks: $tasks)
            DailyTaskView(isOpen: $DailyTaskViewIsOpen, tasks: .constant(tasksForSelectedDate()))
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
                        .padding(.bottom, 40)
                        .padding(.trailing, 30)
                        .onTapGesture {
                            isAddTaskOpen = true
                        }
                        .fullScreenCover(isPresented: $isAddTaskOpen, content: {
                            AddTaskView(currentDate: selectedDate) { newTask in
                                tasks.append(newTask)
                                print("New task added: \(newTask)")
                            }
                        })
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                if currentDragOffsetY < -110 {
                                    endingOffsetY = -startingOffsetY
                                    DailyTaskViewIsOpen = true
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                    DailyTaskViewIsOpen = false
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
    private func tasksForSelectedDate() -> [Task] {
        tasks.filter { task in
            let taskDateComponents = task.toDateComponents()
            let selectedDateComponents = Calendar.current.dateComponents([.day, .month], from: selectedDate)
            
            // Сравниваем только день и месяц
            return taskDateComponents.day == selectedDateComponents.day &&
                   taskDateComponents.month == selectedDateComponents.month
        }
    }
}

#Preview {
    HomeView()
}
