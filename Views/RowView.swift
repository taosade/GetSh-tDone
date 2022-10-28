import SwiftUI

struct RowView: View
{
	private let task: TaskModel

	private let overdue: Bool

	init(_ task: TaskModel)
	{
		self.task = task

		guard let dueDate = task.dueDate else
		{ self.overdue = false; return }

		self.overdue = !task.complete && dueDate <= intFromDate()
	}

	var body: some View
	{
		HStack
		{
			Image(systemName: overdue ? "exclamationmark.triangle" : "checkmark")
			.foregroundColor(overdue ? .red : .green)
			.opacity(task.complete || overdue ? 1 : 0)

			NavigationLink(destination: EditView(task))
			{
				Text(task.title)
				.foregroundColor(task.complete ? .secondary : .primary)
				.lineLimit(1)
			}
		}
	}
}

struct TaskRowViewPreviews: PreviewProvider
{
	static var previews: some View
	{
		Group
		{
			RowView(TaskModel(title: "Task complete", complete: true))
			.preferredColorScheme(.light)

			RowView(TaskModel(title: "Task incomplete"))
			.preferredColorScheme(.light)

			RowView(TaskModel(title: "Task overdue", dueDate: 19700101))
			.preferredColorScheme(.light)

			RowView(TaskModel(title: "Task complete", complete: true))
			.preferredColorScheme(.dark)

			RowView(TaskModel(title: "Task incomplete"))
			.preferredColorScheme(.dark)

			RowView(TaskModel(title: "Task overdue", dueDate: 19700101))
			.preferredColorScheme(.dark)
		}
		.previewLayout(.sizeThatFits)
	}
}
