import SwiftUI

struct ReminderDetailView: View {

    @Environment(\.dismiss) var dismiss
    @Binding var reminder: Reminder
    @State var editConfig = ReminderEditConfig()
    private var isFormValid: Bool {
        !editConfig.title.isEmpty
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        TextField("Titulo", text: $editConfig.title)
                        TextField("Notas", text: $editConfig.notes ?? "")
                    }
                    Section {
                        Toggle(isOn: $editConfig.hasDate) {
                            Image(systemName: "calendar")
                                .foregroundColor(.red)
                        }

                        if editConfig.hasDate {
                            DatePicker("Selecione a data", selection: $editConfig.reminderDate ?? Date(), displayedComponents: .date)
                        }

                        Toggle(isOn: $editConfig.hasTime) {
                            Image(systemName: "clock")
                                .foregroundColor(.blue)
                        }

                        if editConfig.hasTime {
                            DatePicker("Selecione a hora", selection: $editConfig.reminderTime ?? Date(), displayedComponents: .hourAndMinute)
                        }

                        Section {
                            NavigationLink {
                                SelectListView(selectList: $reminder.list)
                            } label: {
                                HStack {
                                    Text("Lista")
                                    Spacer()
                                    Text(reminder.list!.name)
                                }
                            }
                        }
                    }.onChange(of: editConfig.hasDate) { oldValue, newValue in
                        if newValue {
                            editConfig.reminderDate = Date()
                        }
                    }.onChange(of: editConfig.hasTime) { oldValue, newValue in
                        if newValue {
                            editConfig.reminderTime = Date()
                        }
                    }
                }.listStyle(.insetGrouped)
            }.onAppear {
                editConfig = ReminderEditConfig(reminder: reminder)
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Detalhes")
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        do {
                            let updated = try ReminderService.updateReminder(reminder: reminder, editConfig: editConfig)
                            if updated {
                                if reminder.reminderDate != nil || reminder.reminderTime != nil {
                                    NotificationManager.scheduleNotification(with: .init(
                                        title: reminder.title,
                                        body: reminder.notes,
                                        date: reminder.reminderDate,
                                        time: reminder.reminderTime
                                    ))
                                }
                            }
                        } catch {
                            print(error)
                        }
                        dismiss()
                    }.disabled(!isFormValid)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ReminderDetailView(reminder: .constant(PreviewData.reminder))
}
