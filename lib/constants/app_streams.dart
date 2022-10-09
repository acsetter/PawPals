import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppStreams {
  static final _userRef = FirebaseFirestore.instance.collection("users")
      .doc(FirebaseAuth.instance.currentUser?.uid);

  static final Stream<DocumentSnapshot> userStream = _userRef.snapshots();

  // static final Stream<QuerySnapshot> userPostsStream = null;

  // static final Stream<QuerySnapshot> likedPostsStream = null;

  // static final Stream<DocumentSnapshot> preferenceStream = null;

  // static final Stream<DocumentSnapshot> postStream = null;

  // static final Stream<QuerySnapshot> feedStream = null;
}