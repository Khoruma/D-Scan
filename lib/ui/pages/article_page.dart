part of 'pages.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListArticle(),
    );
  }
}

class ListArticle extends StatefulWidget {
  @override
  _ListArticleState createState() => _ListArticleState();
}

class _ListArticleState extends State<ListArticle> {
  final Stream<QuerySnapshot> article =
      FirebaseFirestore.instance.collection('Article').snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: article,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text('something wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('loading . . .');
          }
          final data = snapshot.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return new Card(
                  elevation: 2.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                  ),
                  child: new InkWell(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new ClipRRect(
                          child: new Image.network(
                              snapshot.data.docs.elementAt(index)['image']),
                          borderRadius: BorderRadius.only(
                            topLeft: new Radius.circular(16.0),
                            topRight: new Radius.circular(16.0),
                          ),
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(data.docs[index]['title']),
                              new SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new DetailArticle(
                                  post: snapshot.data.docs[index])));
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}

class DetailArticle extends StatefulWidget {
  final DocumentSnapshot post;

  DetailArticle({this.post});

  @override
  _DetailArticleState createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticle> {
  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  widget.post.get('image'),
                  fit: BoxFit.cover,
                )),
          ),
        ];
      },
      body: new Padding(
        padding: new EdgeInsets.all(1),
        child: new Container(
            child: SingleChildScrollView(
          child: ListTile(
            title: Text(widget.post.get('title')),
            subtitle: Text(widget.post.get('konten')),
          ),
        )),
      ),
    );
  }
}
