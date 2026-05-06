class FakeBookingService {
  final List<DateTime> reservedDates = [
    DateTime(2026, 5, 10),
    DateTime(2026, 5, 15),
  ];

  bool isAvailable(DateTime date) {
    return !reservedDates.any((d) =>
        d.year == date.year &&
        d.month == date.month &&
        d.day == date.day);
  }

  void book(DateTime date) {
    if (isAvailable(date)) {
      reservedDates.add(date);
    }
  }
}
