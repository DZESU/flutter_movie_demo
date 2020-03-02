class Crew {
  String credit_id;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profile_path;

  Crew(
      {this.credit_id,
      this.department,
      this.gender,
      this.id,
      this.job,
      this.name,
      this.profile_path});

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      credit_id: json['credit_id'],
      department: json['department'],
      gender: json['gender'],
      id: json['id'],
      job: json['job'],
      name: json['name'],
      profile_path: json['profile_path'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_id'] = this.credit_id;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    data['profile_path'] = this.profile_path;
    return data;
  }
}
