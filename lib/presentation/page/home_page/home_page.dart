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
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(FirestoreHelper.instance.currentUser.photoUrl),
              ),
              accountName: Text(
                FirestoreHelper.instance.currentUser.displayname
              ),
              accountEmail: Text(FirestoreHelper.instance.currentUser.email),
            ),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded),
              title: const Text("Friends"),
              trailing: IconButton(onPressed: (){}, icon: const Icon(Icons.people_alt_rounded),),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title:
            Text(AuthHelper.instance.auth.currentUser!.displayName ?? "NULL"),
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
