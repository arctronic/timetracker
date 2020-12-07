import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:time_tracker/app/home/models/job.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDataBase implements Database {
  final String uid;

  FirestoreDataBase({@required this.uid}) : assert(uid != null);
  Future<void> createJob(Job job) async => await _setData(
    path: APIPath.job(uid, 'Job_abc'),
    data: job.toMap()
  );

  Future<void> _setData({String path, Map<String, dynamic>data}) async{
    final reference = FirebaseFirestore.instance.doc(path);
    reference.set(data);
  }

}
