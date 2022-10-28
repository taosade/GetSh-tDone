import SwiftUI

struct EditView: View
{
	@Environment(\.presentationMode) var presentationMode

	@EnvironmentObject var listViewModel: ListViewModel

	let task: TaskModel

	@State var title: String; @FocusState var titleFocused: Bool
	@State var note: String
	@State var dueDate: Date; @State var dueDateSet: Bool
	@State var complete: Bool

	init(_ task: TaskModel)
	{
		self.task = task

		_title = State(initialValue: task.title)
		_note = State(initialValue: task.note ?? "")
		_dueDate = State(initialValue:  dateFromInt(task.dueDate) ?? Date().advanced(by: 86400 * 7))
		_dueDateSet = State(initialValue: task.dueDate != nil)
		_complete = State(initialValue: task.complete)
	}

	var body: some View
	{
		VStack(spacing: 0)
		{
			// Task title

			HStack
			{
				TextField("Add task title…", text: $title)
				.focused($titleFocused)
				.submitLabel(.done)
				.padding()
				.contentShape(Rectangle()) // Extends tappable area
				.onTapGesture { titleFocused = true }

				Button("Done")
				{
					listViewModel.update(
						id: task.id,
						title: title,
						note: note,
						dueDate: dueDateSet ? intFromDate(dueDate) : nil,
						complete: complete)

					presentationMode.wrappedValue.dismiss()
				}
				.padding(.trailing)
			}
			.background(.thickMaterial)

			// Task notes

			TextEditor(text: $note)
			.padding(.top, 6)
			.padding(.horizontal, 11)
			.overlay(alignment: .topLeading)
			{
				Text("Add task notes…")
				.foregroundColor(.secondary)
				.padding(.top, 14)
				.padding(.leading, 16)
				.opacity(note.isEmpty ? 1 : 0)
			}

			VStack
			{
				// Due date

				HStack
				{
					Text("Due date")

					Spacer()

					DatePicker("Due date picker", selection: $dueDate, displayedComponents: .date)
					.labelsHidden()
					.opacity(dueDateSet ? 1 : 0)

					Toggle("Due date toggle", isOn: $dueDateSet).labelsHidden()
				}

				Toggle("Completed", isOn: $complete)
			}
			.padding()
			.background(.thickMaterial)
		}
		.navigationBarHidden(true)
	}
}

struct EditView_Previews: PreviewProvider
{
	static var previews: some View
	{
		Group
		{
			EditView(TaskModel(title: "")).preferredColorScheme(.light)

			EditView(TaskModel(title: "")).preferredColorScheme(.dark)
		}
		.environmentObject(ListViewModel())
	}
}
