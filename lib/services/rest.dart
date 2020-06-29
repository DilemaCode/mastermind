import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FS {
  static final _db = Firestore.instance;
  static final FS _data = new FS._internal();
  factory FS() => _data;
  FS._internal();

  static getGameById(String id) async {
    return _db.collection('games').document(id).get().then((data) async {
      data.data['id'] = data.documentID;
      return data.data;
    });
  }

  static List allGames = [];
  static getGames() async {
    List games = [];
    await _db.collection('games').getDocuments().then((res) {
      for (var event in res.documents) {
        event.data['id'] = event.documentID;
        games.add(event.data);
        allGames.add(event.data);
      }
    });
    // return events;
  }


  static Future createUser(data) async {
    Map _user;
    await _db.collection("users").add({
      // "name": name ?? "",
    }).then((r) async {
      await r.get().then((u) {
        if (u.exists) {
          _user = u.data;
          _user['id'] = u.documentID;
        } else {
          _user = {};
        }
      }).catchError((error) {
        print(error);
      });
    });
    return _user;
  }

  static Future createGame(String name, List colors) async {
    Map _game;
    await _db.collection("users").add({
      "colors": colors,
      "userId": name ?? "",
    }).then((r) async {
      await r.get().then((u) {
        if (u.exists) {
          _game = u.data;
          _game['id'] = u.documentID;
        } else {
          _game = {};
        }
      }).catchError((error) {
        print(error);
      });
    });
    return _game;
  }
}
