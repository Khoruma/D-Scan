part of 'shared.dart';

final picker = ImagePicker();

pickImageGallery() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  return image;
}


uploadImage(File image) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  String fileName = basename(image.path);

  Reference ref = storage.ref().child('Profile Picture/$fileName');
  UploadTask uploadTask = ref.putFile(image);
  uploadTask.then((res) {
    res.ref.getDownloadURL();
  });
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
