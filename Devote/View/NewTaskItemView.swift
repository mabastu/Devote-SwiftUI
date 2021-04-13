//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Mabast on 4/9/21.
//

import SwiftUI

struct NewTaskItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var task: String = ""
    @Binding var isShowing: Bool

    private var isButtonDisabled: Bool {
        task.isEmpty || task.hasSuffix(" ")
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }

    var body: some View {
        VStack {
            Spacer()
            VStack {
                VStack(spacing: 16, content: {
                    TextField("New task", text: $task)
                        .foregroundColor(.pink)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
                        .background(Color(isDarkMode ? UIColor.tertiarySystemBackground : UIColor.secondarySystemBackground))
                        .cornerRadius(10)

                    Button(action: {
                        addItem()
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }, label: {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    })
                        .disabled(isButtonDisabled)
                    .onTapGesture {
                        if isButtonDisabled {
                        playSound(sound: "sound-tap", type: "mp3")
                        }
                    }
                        .padding()
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.blue : Color.pink)
                        .cornerRadius(10)
                })
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
            .cornerRadius(25)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        }
        .padding()
    }

    struct NewTaskItemView_Previews: PreviewProvider {
        static var previews: some View {
            NewTaskItemView(isShowing: .constant(true))
                .background(Color.gray.edgesIgnoringSafeArea(.all))
        }
    }
}
