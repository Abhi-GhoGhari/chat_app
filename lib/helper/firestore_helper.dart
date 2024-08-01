import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/web.dart';

import '../modal/todo_modal.dart';
import '../modal/user_modal.dart';
import 'authhelper.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper instance = FirestoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  String collectionPath = "Todo";
  String userCollection = "allUser";

  UserModal? currentUser;

  Future<void> addUser({required User user}) async {
    Map<String, dynamic> data = {
      'uid': user.uid,
      'displayName': user.displayName ?? "NULL User",
      'email': user.email ?? "NULL_mail",
      'phoneNumber': user.phoneNumber ?? "NULL_phone",
      'photourl': user.photoURL ??
          "https://i0.wp.com/rssoeroto.ngawikab.go.id/wp-content/uploads/2022/07/user-dummy-removebg.png?ssl=1",
    };
    await fireStore.collection(userCollection).doc(user.uid).set(data);
  }

  Future<void> getUser() async {
    DocumentSnapshot snapshot = await fireStore
        .collection(userCollection)
        .doc(AuthHelper.instance.auth.currentUser!.uid)
        .get();

    currentUser = UserModal.froMap(snapshot.data() as Map);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getallUser() {
    return fireStore.collection(collectionPath).snapshots();
  }

  Future<void> addTodo({required TodoModal todoModal}) async {
    await fireStore
        .collection(userCollection)
        .doc(currentUser?.uid)
        .collection(collectionPath)
        .doc(todoModal.id)
        .set(todoModal.toMap);
  }

  Future<void> getData() async {
    List<TodoModal> allTodo = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore
        .collection(userCollection)
        .doc(currentUser?.uid)
        .collection(collectionPath)
        .get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    allTodo = docs
        .map(
          (e) => TodoModal.froMap(e.data() as Map),
        )
        .toList();

    Stream<QuerySnapshot<Map<String, dynamic>>> getStream() {
      return fireStore
          .collection(userCollection)
          .doc(currentUser?.uid)
          .collection(collectionPath)
          .snapshots();
    }

    // Future<void> updateStatus({required TodoModal todoModal}) async {
    //   await fireStore
    //       .collection(collectionPath)
    //       .doc(currentUser.uid)
    //       .collection(collectionPath)
    //       .doc(todoModal.id)
    //       .update(todoModal.toMap);
    // }

    Future<void> addFrind({required UserModal userModal}) async {
      await fireStore
          .collection(userCollection)
          .doc(currentUser?.uid)
          .collection('friends')
          .doc(userModal.uid)
          .set(userModal.toMap)
          .then((value) => Logger().i("Add Friends!!"))
          .onError((error, stackTrace) => Logger().e("Error"));
      await fireStore
          .collection(userCollection)
          .doc(userModal.uid)
          .collection('friends')
          .doc(currentUser?.uid)
          .set(currentUser!.toMap);
    }

    Future<List<UserModal>> getFriend() async {
      List<UserModal> friends = [];
      friends = (await fireStore
              .collection(userCollection)
              .doc(currentUser?.uid)
              .collection('friends')
              .get())
          .docs
          .map((e) => UserModal.froMap(e.data()))
          .toList();

      return friends;
    }

    Stream<QuerySnapshot<Map<String, dynamic>>> getfriendStream() {
      return fireStore
          .collection(userCollection)
          .doc(currentUser?.uid)
          .collection('friends')
          .snapshots();
    }
  }
}
