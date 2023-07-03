import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// pickImage(ImageSource source) async {
//   final ImagePicker _imagePicker = ImagePicker();

//   XFile? _file = await _imagePicker.pickImage(source: source);
//   if (_file != null) {
//     return await _file.readAsBytes();
//   }
//   print('No imagen seleccionada');
// }

// final FirebaseStorage _storage = FirebaseStorage.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class StoreData {
//   Future<String> uploadImageToStorage(String childName, Uint8List file) async {
//     Reference ref = _storage.ref().child(childName);
//     UploadTask uploadTask = ref.putData(file);
//     TaskSnapshot snapshot = await uploadTask;
//     String downoloadUrl = await snapshot.ref.getDownloadURL();
//     return downoloadUrl;
//   }

//   Future<String> saveData({required Uint8List file}) async {
//     String resp = 'Ocurrio un error';
//     try {
//       String imageUrl = await uploadImageToStorage('profileImage', file);
//       await _firestore.collection('usuarios').add({
//         'image': imageUrl,
//       });
//       resp = 'Exitoso';
//     } catch (e) {
//       resp = e.toString();
//     }
//     return resp;
//   }
// }


