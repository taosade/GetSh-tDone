import Foundation

struct TaskModel: Codable, Identifiable
{
	let id: UUID
	let title: String
	let note: String?
	let dueDate: Int?
	let complete: Bool

	init(
		id: UUID = UUID(),
		title: String,
		note: String? = nil,
		dueDate: Int? = nil,
		complete: Bool = false)
	{
		self.id = id
		self.title = title
		self.note = note
		self.dueDate = dueDate
		self.complete = complete
	}

	/// Toggles task's 'complete' property
	func toggle() -> TaskModel
	{
		return TaskModel(
			id: self.id,
			title: self.title,
			note: self.note,
			dueDate: self.dueDate,
			complete: !self.complete)
	}

	/// Updates task's properties
	func update(
		title: String,
		note: String,
		dueDate: Int?,
		complete: Bool) -> TaskModel
	{
		let titleTrimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
		let noteTrimmed = note.trimmingCharacters(in: .whitespacesAndNewlines)

		return TaskModel(
			id: id,
			title: titleTrimmed.count > 0 ? titleTrimmed : self.title,
			note: noteTrimmed.count > 0 ? note : nil,
			dueDate: dueDate,
			complete: complete)
	}
}
