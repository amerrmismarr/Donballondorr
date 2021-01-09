class FavoritesPrefs {

  String id;

  FavoritesPrefs({this.id});

  FavoritesPrefs.fromMap(Map map):
    this.id = map['id'];

  Map toMap(){
    return {
      'id' : this.id
    };
  }
  
}

