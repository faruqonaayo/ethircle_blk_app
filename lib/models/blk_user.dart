import 'package:uuid/uuid.dart';

final uuid = Uuid();

class BlkUser {
  const BlkUser({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String? uid;
  final String firstName;
  final String lastName;
  final String email;
}
