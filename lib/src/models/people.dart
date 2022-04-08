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
          : "https://images.unsplash.com/photo-1503249023995-51b0f3778ccf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=311&q=80",
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
