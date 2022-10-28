import SwiftUI

@main
struct ToDoAppApp: App
{
	@StateObject var listViewModel: ListViewModel = ListViewModel()

	var body: some Scene
	{
		WindowGroup
		{
			NavigationView { ListView() }
			.navigationViewStyle(.stack)
			.environmentObject(listViewModel)
		}
	}
}
