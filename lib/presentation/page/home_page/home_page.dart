import '../../../heders.dart';
import '../../../helper/authhelper.dart';
import '../../../helper/firestore_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              leading: const Icon(Icons.people_alt_rounded),
              title: const Text("Friends"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.people_alt_rounded),
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
