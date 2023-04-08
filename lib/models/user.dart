
class UserData {
  UserData({
      this.displayName,
      this.email,
      this.uid,
      this.profilePhoto,
});

  final String? displayName;
  final String? email;
  final String? uid;
  final String? profilePhoto;

  UserData.fromJson(Map<String, dynamic> data) :
      this(
        displayName: data['displayName'],
        email: data['email'],
        uid: data['uid'],
        profilePhoto: data['photoURL']
      );

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName ?? 'Anon',
      'email': email,
      'uid': uid,
      'photoURL': profilePhoto ?? ''
    };
  }
}