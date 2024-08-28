import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageUrl(String gsUrl) async {
  // Extract the path from the gs:// URL
  final ref = FirebaseStorage.instance.ref().child(gsUrl);
  print('Ref: $ref');
  // Get the download URL
  try {
    String downloadUrl = await ref.getDownloadURL();
    print('Download URL: $downloadUrl');
    return downloadUrl;
  } catch (e) {
    print(e);
  }
  return 'Eror loading image';
}
