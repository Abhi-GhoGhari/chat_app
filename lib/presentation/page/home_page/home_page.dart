import '../../../heders.dart';
import '../../../helper/authhelper.dart';
import '../../../helper/firestore_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            label: "AllFriends",
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
          } else {
            Navigator.pushNamed(
              context,
              AppRoutes.instance.alluserpage,
            );
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                  FirestoreHelper.instance.currentUser?.photoUrl ??
                      "https://seds.ca/wp-content/uploads/2019/05/user-placeholder.png",
                ),
              ),
              accountName: Text(
                FirestoreHelper.instance.currentUser?.displayname ?? "guest",
              ),
              accountEmail: Text(
                FirestoreHelper.instance.currentUser?.email ??
                    "Guest@gmail.com",
              ),
            ),
            ListTile(
              // leading: const Icon(Icons.people_alt_rounded),
              title: const Text("AllUsers"),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.instance.alluserpage,
                  );
                },
                icon: const Icon(Icons.people_alt_rounded),
              ),
            ),
            ListTile(
              // leading: const Icon(Icons.people_alt_rounded),
              title: const Text("Logout"),
              trailing: IconButton(
                onPressed: () {
                  AuthHelper.instance.logOut().then(
                    (value) {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("LogOut"),
                      backgroundColor: Colors.black,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title:
            Text(AuthHelper.instance.auth.currentUser!.displayName ?? "Guest"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.instance.notificationpage);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text("LogOut"),
              //     backgroundColor: Colors.black,
              //     behavior: SnackBarBehavior.floating,
              //   ),
              // );
            },
            icon: const Icon(Icons.notifications_active),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          " \t\t\t\tWelcome! \n Login Successfull !",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
