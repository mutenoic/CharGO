import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  Future profileEdit({
    required String id,
    String? newName,
    XFile? newPhoto,
  }) async {
    var doc = await FirebaseFirestore.instance.collection("users").doc(id).get();
    var data = doc.data()!;

    data["name"] = newName;

    if (newPhoto != null) {
      final storageRef = FirebaseStorage.instance.ref("users/").child(id);
      await storageRef.putFile(File(newPhoto.path));

      final downloadURL = await storageRef.getDownloadURL();

      data["photoUrl"] = downloadURL;
    }

    await FirebaseFirestore.instance.collection("users").doc(id).update(data);

    return data;
  }

  Future<Map<String, dynamic>?> getProfileInfo() async {
    var doc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid).get();

    return doc.data();
  }
}
