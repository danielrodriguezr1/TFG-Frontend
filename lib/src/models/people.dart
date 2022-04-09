class People {
  final String profile;
  final String name;
  final String id;
  People({
    this.profile,
    this.name,
    this.id,
  });
  factory People.fromJson(json) {
    return People(
      name: json['name'] ?? "",
      profile: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['profile_path']
          : "https://images.pexels.com/photos/11760521/pexels-photo-11760521.png?cs=srgb&dl=pexels-daniel-rodr%C3%ADguez-11760521.jpg&fm=jpg",
      id: json['id'].toString(),
    );
  }
}

class PeopleModelList {
  final List<People> peoples;
  PeopleModelList({
    this.peoples,
  });
  factory PeopleModelList.fromJson(json) {
    return PeopleModelList(
      peoples: (json as List).map((people) => People.fromJson(people)).toList(),
    );
  }
}
