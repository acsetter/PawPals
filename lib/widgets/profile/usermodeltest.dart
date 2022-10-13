/* The usermodeltest.dart file serves to create dummy data until the database
is complete.
 */

class User {
  final String uid;
  final String email;
  final String username;
  final String first;
  final String last;
  final String photoUrl;
  final int date;

  const User({
    required this.uid,
    required this.email,
    required this.username,
    required this.first,
    required this.last,
    required this.photoUrl,
    required this.date,
  });
}