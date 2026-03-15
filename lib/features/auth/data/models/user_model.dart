
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String username;
  final String language;
  final String country;
  final String? avatarPath;
  final String? gravatarHash;

  const UserModel({
    required this.id,
    required this.username,
    required this.language,
    required this.country,
    this.avatarPath,
    this.gravatarHash,
  });

  /// Factory constructor to create a User from TMDB JSON response
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String,
      language: json['iso_639_1'] as String,
      country: json['iso_3166_1'] as String,
      // Nested mapping for avatar
      avatarPath: json['avatar']?['tmdb']?['avatar_path'] as String?,
      gravatarHash: json['avatar']?['gravatar']?['hash'] as String?,
    );
  }

  /// 2. TO MAP (Object -> JSON)
  /// Used for local storage (like Caching) or sending data back to a server

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'iso_639_1': language,
      'iso_3166_1': country,
      'avatar': {
        'gravatar': {'hash': gravatarHash},
        'tmdb': {'avatar_path': avatarPath},
      },
    };
  }

  /// Helper method to get the full avatar URL
  String get avatarUrl {
    if (avatarPath != null && avatarPath!.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w200$avatarPath';
    } else if (gravatarHash != null && gravatarHash!.isNotEmpty) {
      return 'https://www.gravatar.com/avatar/$gravatarHash?s=200';
    }
    // Default fallback if no avatar is set
    return 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
  }

  @override
  List<Object?> get props => [
        id,
        username,
        language,
        country,
        avatarPath,
        gravatarHash,
      ];
}
