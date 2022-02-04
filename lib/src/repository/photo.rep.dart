import 'package:image_picker/image_picker.dart';

class PhotoRepository {
  Future<XFile?> getPhoto() async {
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
