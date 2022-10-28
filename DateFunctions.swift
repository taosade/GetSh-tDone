import Foundation

/// Returns an integer representing date as YYYYMMDD
func intFromDate(_ date: Date = Date()) -> Int
{
	let dateFormatter = DateFormatter()

	dateFormatter.dateFormat = "yyyyMMdd"
	dateFormatter.timeZone = .current

	return Int(dateFormatter.string(from: date)) ?? 19700101
}

/// Returns an optional date object represented by integer as YYYYMMDD
func dateFromInt(_ int: Int?) -> Date?
{
	if let int = int
	{
		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "yyyyMMdd"
		dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

		return dateFormatter.date(from: String(int))
	}

	return nil
}
