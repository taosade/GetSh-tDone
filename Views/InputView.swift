import SwiftUI

struct InputView: View
{
	@EnvironmentObject var listViewModel: ListViewModel

	@State var input: String = ""

	@FocusState var inputFocused: Bool

	var body: some View
	{
		HStack(spacing: 0)
		{
			TextField("Add task…", text: $input)
			.onChange(of: $input.wrappedValue, perform:
			{
				// Limit input to 255 characters

				_ in $input.wrappedValue = String($input.wrappedValue.prefix(255))
			})
			.onSubmit
			{
				// Trim whitespace and submit if anything left

				let inputTrimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)

				if inputTrimmed.count > 0
				{
					withAnimation { listViewModel.add(inputTrimmed) }
				}

				input = ""
			}
			.submitLabel(.done)
			.focused($inputFocused)
			.padding()
			.contentShape(Rectangle()) // Extends tappable area
			.onTapGesture { inputFocused = true }

			// Clear button

			if input.count > 0
			{
				Button(
					action: { input = ""; inputFocused = false},
					label:
					{
						Image(systemName: "xmark")
						.foregroundColor(.red)
						.padding([.vertical, .trailing])
					})
			}
		}.background(.thickMaterial)
	}
}

struct InputView_Previews: PreviewProvider
{
	static var previews: some View
	{
		Group
		{
			InputView().preferredColorScheme(.light)

			InputView().preferredColorScheme(.dark)

			InputView(input: "Some task").preferredColorScheme(.light)

			InputView(input: "Some task").preferredColorScheme(.dark)
		}
		.environmentObject(ListViewModel())
		.previewLayout(.sizeThatFits)
	}
}
