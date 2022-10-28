import Foundation

class ListViewModel: ObservableObject
{
	@Published var tasks: [TaskModel] { didSet { self.save() } }

	init()
	{
		guard let tasks = UserDefaults.standard.data(forKey: "tasks") else
		{
			self.tasks = [
				TaskModel(title: "Install GetSh!tDone app", complete: true),
				TaskModel(title: "Plan the sh!t out of everything")]

			return
		}

		self.tasks = (try? JSONDecoder().decode([TaskModel].self, from: tasks)) ??
		[TaskModel(title: "Error loading tasks")]
	}

	/// Adds a new task
	func add(_ title: String)
	{
		tasks.append(TaskModel(title: title))
	}

	/// Deletes task with specified ID
	func delete(_ id: UUID)
	{
		guard let index = tasks.firstIndex(where: { task in task.id == id } ) else
		{ return }

		tasks.remove(at: index)
	}

	/// Moves task to specified list position
	func move(_ from: IndexSet, to: Int)
	{
		tasks.move(fromOffsets: from, toOffset: to)
	}

	/// Toggles task's 'complete' property
	func toggle(_ id: UUID)
	{
		guard let index = tasks.firstIndex(where: { task in task.id == id } ) else
		{ return }

		tasks[index] = tasks[index].toggle()
	}

	/// Updates task's properties
	func update(
		id: UUID,
		title: String,
		note: String,
		dueDate: Int?,
		complete: Bool)
	{
		guard let index = tasks.firstIndex(where: { task in task.id == id } ) else
		{ return }

		tasks[index] = tasks[index].update(
			title: title,
			note: note,
			dueDate: dueDate,
			complete: complete)
	}

	/// Saves JSON representation of task list to UserDefaults
	func save()
	{
		guard let tasks = try? JSONEncoder().encode(self.tasks) else
		{ return }

		UserDefaults.standard.set(tasks, forKey: "tasks")
	}
}
