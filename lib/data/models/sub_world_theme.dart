class SubWorldTheme {
  int id;
  String file_name;
  String display_name;
  String? level_ipfs_uri;
  String? level_centralized_uri;
  int created_at;
  int updated_at;

  SubWorldTheme(
    this.id,
    this.file_name,
    this.display_name,
    this.level_ipfs_uri,
    this.level_centralized_uri,
    this.created_at,
    this.updated_at,
  );

  SubWorldTheme.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        file_name = json['file_name'],
        display_name = json['display_name'],
        level_ipfs_uri = json['level_ipfs_uri'],
        level_centralized_uri = json['level_centralized_uri'],
        created_at = json['created_at'],
        updated_at = json['updated_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'file_name': file_name,
        'display_name': display_name,
        'level_ipfs_uri': level_ipfs_uri,
        'level_centralized_uri': level_centralized_uri,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
