import '../../../heders.dart';
import '../../../helper/firestore_helper.dart';
import '../../../modal/user_modal.dart';

class AlluserPage extends StatelessWidget {
  const AlluserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
            stream: FirestoreHelper.instance.getallUser(),
            builder: (context, snapshot) {
              List<UserModal> allUser = [];
              if (snapshot.hasData) {
                allUser = snapshot.data?.docs
                        .map((e) => UserModal.froMap(e.data()))
                        .toList() ??
                    [];
                allUser.removeWhere((element) =>
                    element.uid == FirestoreHelper.instance.currentUser.uid);
              }
              return ListView.separated(
                separatorBuilder: (c, i) => const Divider(),
                itemBuilder: (c, i) {
                  UserModal user = allUser[i];
                  return null;
                },
                itemCount: allUser.length,
              );
            }),
      ),
    );
  }
}
