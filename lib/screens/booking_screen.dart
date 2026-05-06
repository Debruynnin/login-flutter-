import 'package:flutter/material.dart';
import '../services/fake_booking_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final service = FakeBookingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reservas")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2025),
                lastDate: DateTime(2030),
              );

              if (picked != null) {
                setState(() {
                  service.book(picked);
                });
              }
            },
            child: Text("Selecionar data"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: service.reservedDates.length,
              itemBuilder: (context, index) {
                final date = service.reservedDates[index];
                return ListTile(
                  title: Text("${date.day}/${date.month}/${date.year}"),
                  subtitle: Text("Indisponível"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
