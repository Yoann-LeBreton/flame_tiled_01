class FriendsDialogs {
  static String getDialogByName(String name) {
    return switch (name) {
      'friend_01' => "Good morning Player !",
      'friend_02' => "What a lovely day !",
      _ => "",
    };
  }
}
