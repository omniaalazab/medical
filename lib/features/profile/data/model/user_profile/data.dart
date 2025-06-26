import 'user.dart';

class Data {
	int? id;
	int? userId;
	String? firstName;
	String? lastName;
	String? fullName;
	String? dateOfBirth;
	int? age;
	String? gender;
	String? bio;
	String? profileImage;
	String? profileImageUrl;
	bool? isActive;
	dynamic lastLoginHuman;
	User? user;

	Data({
		this.id, 
		this.userId, 
		this.firstName, 
		this.lastName, 
		this.fullName, 
		this.dateOfBirth, 
		this.age, 
		this.gender, 
		this.bio, 
		this.profileImage, 
		this.profileImageUrl, 
		this.isActive, 
		this.lastLoginHuman, 
		this.user, 
	});

	factory Data.fromJson(Map<String, dynamic> json) => Data(
				id: json['id'] as int?,
				userId: json['user_id'] as int?,
				firstName: json['first_name'] as String?,
				lastName: json['last_name'] as String?,
				fullName: json['full_name'] as String?,
				dateOfBirth: json['date_of_birth'] as String?,
				age: json['age'] as int?,
				gender: json['gender'] as String?,
				bio: json['bio'] as String?,
				profileImage: json['profile_image'] as String?,
				profileImageUrl: json['profile_image_url'] as String?,
				isActive: json['is_active'] as bool?,
				lastLoginHuman: json['last_login_human'] as dynamic,
				user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'user_id': userId,
				'first_name': firstName,
				'last_name': lastName,
				'full_name': fullName,
				'date_of_birth': dateOfBirth,
				'age': age,
				'gender': gender,
				'bio': bio,
				'profile_image': profileImage,
				'profile_image_url': profileImageUrl,
				'is_active': isActive,
				'last_login_human': lastLoginHuman,
				'user': user?.toJson(),
			};
}
