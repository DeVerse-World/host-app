class SubWorldInstance {
  int id;
  String state_local_uri;
  String host_name;
  String region;
  int max_players;
  int current_players;
  int port;
  int beacon_port;
  int theme_id;
  int created_at;
  int updated_at;

  SubWorldInstance(this.id, this.state_local_uri, this.host_name,
  this.region, this.max_players, this.current_players, this.port, this.beacon_port, this.theme_id, this.created_at, this.updated_at);
}