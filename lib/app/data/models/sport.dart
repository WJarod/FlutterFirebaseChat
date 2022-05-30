import 'package:chat_firebase/app/data/models/categorie.dart';

class Sport {
  String? id;
  String? name;
  String? logo;
  String? categorieId;
  Categorie? categorie;

  Sport({this.id, this.name, this.logo, this.categorieId, this.categorie});

  Sport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    categorieId = json['categorieId'];
    categorie = json['categorie'] != null
        ? Categorie.fromJson(json['categorie'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    data['categorieId'] = categorieId;
    if (categorie != null) {
      data['categorie'] = categorie!.toJson();
    }
    return data;
  }
}
