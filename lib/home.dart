import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final appBar = AppBar(
    title: Text('Shrine'),
    leading: IconButton(icon:Icon(Icons.menu) , onPressed: () {
      print('menu button');
    },),
    actions: <Widget>[
      IconButton(icon:Icon(Icons.search,semanticLabel: 'search',)
       , onPressed: () {
        print('search');
      },
    ),
      IconButton(icon:Icon(Icons.tune, semanticLabel: 'tune',) , onPressed: (){
        print('tune');
      },),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: GridView.count(
        crossAxisCount: 2,
        children:_buildGridCards(10),
      ),
    );
  }

  List<Card> _buildGridCards(int count) {
  List<Card> cards = List.generate(
    count,
    (int index) => Card(
      elevation: 0.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/diamond.png'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Title'),
                SizedBox(height:8.0),
                Text('Secondary Text'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return cards;
}

}