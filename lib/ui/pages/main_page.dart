part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

// List<Data> dataList =[];
// @override
// void initState() {
//   super.initState();
//   DatabaseReference referenceData = FirebaseDatabase.instance;
// }

int index = 0;

 final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildPages(),
        bottomNavigationBar: buildBottomNavigation(),
    );
  }

Widget buildPages() {
  switch (index) {
    case 1:
      return TambahDatasetPage();
    case 2:
      return ArticlePage();
    case 3:
      return ProfilePage();
    case 0:
    default:
      return IdentificationPage();
  }
}

  Widget buildBottomNavigation() {
    return BottomNavyBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: index  ,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.camera),
          title: Text('Identifikasi'),
          activeColor: Colors.brown,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.add_photo_alternate),
          title: Text('Dataset'),
          activeColor: Colors.brown,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.bookmark),
          title: Text('Artikel'),
          activeColor: Colors.brown,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          activeColor: Colors.brown,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}