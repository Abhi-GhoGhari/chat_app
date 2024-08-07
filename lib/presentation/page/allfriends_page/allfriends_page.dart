import 'package:chat_app/heders.dart';

class AllFriendsPage extends StatelessWidget {
  const AllFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
        ],
        currentIndex: 0,
        onTap: (i) {
          if (i == 1) {
            Navigator.pushNamed(
              context,
              AppRoutes.instance.allfriendspage,
            );
          } else if (i == 2) {
            Navigator.pushNamed(
              context,
              AppRoutes.instance.alluserpage,
            );
          } else {
            Navigator.pushNamed(
              context,
              AppRoutes.instance.homepage,
            );
          }
        },
      ),
      appBar: AppBar(
        title: const Text("Friends Page"),
      ),
    );
  }
}
