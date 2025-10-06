import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: Center(
        child: Text('Tickets Screen'),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {
        // Action when button is pressed
      }, 
      label: Text('scan Ticket'))
    );
  }
}
