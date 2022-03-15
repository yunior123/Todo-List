//
//  ContentView.swift
//  Shared
//
//  Created by Yunior's Mac on 2021 - 08 - 10.
//

import SwiftUI
import CoreData

enum Priority: String,Identifiable,CaseIterable{
    var id: UUID{
        return UUID()
    }
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

extension Priority {
    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
      
        }
    }
}

struct ContentView: View {
    @State private var title: String = ""
    @State private var selectedPriority: Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity:
                    TodoModel.entity(),
                  sortDescriptors:
                    [NSSortDescriptor(key:"dateCreated",ascending: false)
                    ]
    ) private var allTodos: FetchedResults<TodoModel>
    
    private func styleForPriority(_ value: String) -> Color{
        let priority = Priority(rawValue: value)
        
        switch priority {
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.black
        default:
            return Color.black
      
        }
    }
    private func saveTodo(){
        do{
            let todo = TodoModel(context: viewContext)
            todo.title = title
            todo.priority = selectedPriority.rawValue
            todo.dateCreated=Date()
            todo.isFavorite=false
            try viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
//    private func updateTodo(_ todo: TodoModel){
//        todo.isFavorite = !todo.isFavorite
//        viewContext.save()
//    }
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Todo List").font(Font.custom("poppins", size: 20.0))
                TextField("Enter title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())                .frame(maxWidth: .infinity, maxHeight: 45)

                Picker("Priority", selection: $selectedPriority){
                    ForEach (Priority.allCases){
                        priority in Text(priority.title).tag(priority)
                    }

                }.pickerStyle(SegmentedPickerStyle())                .frame(maxWidth: .infinity, maxHeight: 45)

                Button("Save"){
                    saveTodo()
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 45)
                .background(Color.blue)
                .foregroundColor(Color.white)
                List{
                    ForEach(allTodos){
                        todo in
                        HStack{
                            Circle()
                                .fill(styleForPriority(todo.priority!))
                                .frame(width: 15, height: 15, alignment: .center)
                            Spacer().frame(width: 20)
                            Text(todo.title ?? "")
                        }


                    }
                }.frame(maxWidth: .infinity, maxHeight: 200)
                Spacer()
            }
            .padding()
          
       
        }
        
    }
}
struct Content_Previews: PreviewProvider {
    static var previews: some View{
        let persistentContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .environment(\.managedObjectContext,persistentContainer.viewContext)
    }
}


