part of 'pages.dart';

class TambahDatasetPage extends StatefulWidget {
  @override
  _TambahDatasetPageState createState() =>
      _TambahDatasetPageState();
}

class _TambahDatasetPageState
    extends State<TambahDatasetPage> {
  File _imageFile;

  final picker = ImagePicker();

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(image.path);
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName = basename(_imageFile.path);
    Reference ref = storage.ref().child('Tambah Dataset/$fileName');
    UploadTask uploadTask = ref.putFile(_imageFile);
    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) => print("Done"));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Pilih Gambar Untuk Tambah Dataset Baru",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile)
                              : FlatButton(
                                  child: Icon(
                                    Icons.image,
                                    size: 250,
                                    color: Colors.grey,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Color(0xFF56ab2f),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => uploadImageToFirebase(context),
              child: Text(
                "Tambah Dataset",
                style: TextStyle(fontSize: 18, color: Colors.white)
              ),
            ),
          ),
        ],
      ),
    );
  }
    }