import 'package:chat_app/heders.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notofication Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Simple Notification"),
                Icon(Icons.notifications_active),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
