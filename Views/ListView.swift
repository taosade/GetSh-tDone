import SwiftUI

struct ListView: View
{
	@EnvironmentObject var listViewModel: ListViewModel

	@State var editMode: EditMode = .inactive

	var body: some View
	{
		VStack(spacing: 0)
		{
			HStack
			{
				Text("Get💩Done!").fontWeight(.semibold)

				Spacer()

				if !listViewModel.tasks.isEmpty
				{
					// Custom EditButton()

					Button(
					action: { withAnimation { editMode = editMode == .active ? .inactive : .active } },
					label: { Image(systemName: "line.3.horizontal") })
				}
			}
			.font(.title2)
			.padding()
			.background(.thickMaterial)

			List
			{
				ForEach(listViewModel.tasks)
				{
					task in RowView(task)
					.swipeActions(edge: .leading, allowsFullSwipe: true)
					{
						Button(
						action: { withAnimation { listViewModel.toggle(task.id) } },
						label: { Image(systemName: task.complete ? "xmark" : "checkmark") })
						.tint(task.complete ? nil : .green)
					}
					.swipeActions(edge: .trailing, allowsFullSwipe: true)
					{
						Button(
						action: { withAnimation { listViewModel.delete(task.id) } },
						label: { Image(systemName: "trash.fill") })
						.tint(.red)
					}
				}
				.onDelete { indexSet in /* handled by a custom swipe action */ }
				.onMove { indexSet, to in listViewModel.move(indexSet, to: to) }
				.listRowSeparator(.hidden)
			}
			.listStyle(.plain)
			.background
			{
				// Empty list message

				Text("No more 💩 to do")
				.foregroundColor(.secondary)
				.opacity(listViewModel.tasks.isEmpty ? 1 : 0)
			}

			.environment(\.editMode, $editMode)
			.onChange(of: $listViewModel.tasks.count, perform:
			{
				// Turn off edit mode on empty list

				_ in if listViewModel.tasks.count == 0 { editMode = .inactive }
			})

			InputView() // "Add task…" bar
		}
		.navigationBarHidden(true)
	}
}

struct ListView_Previews: PreviewProvider
{
	static var previews: some View
	{
		NavigationView { ListView() }.environmentObject(ListViewModel())
	}
}
