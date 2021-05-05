// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

@lazySingleton
class MediaService {
  Future getGalleryImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 40);
    if (pickedFile == null) {
      return "";
    }
    return File(pickedFile.path);
  }

  Future getImageCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    if (pickedFile == null) {
      return "";
    }
    return File(pickedFile.path);
  }

  Future<String> uploadFile(File _file, {String path}) async {
    String downloadUrl;
    firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$path${Path.basename(_file.path)}');

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_file);
    await uploadTask.whenComplete(() =>  print('File Uploaded'));
    await storageReference.getDownloadURL().then((fileURL) {
      downloadUrl = fileURL;
    });

    return downloadUrl;
  }
}
