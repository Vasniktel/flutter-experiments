import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        textTheme: TextTheme(
          headline: TextStyle(
            fontSize: 24,
            fontFamily: 'Montserrat'
          ),
          subhead: TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat'
          ),
        ),
      ),
      home: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  NoteList({Key key}) : super(key: key);

  final NotesModel model = NotesModel();

  @override
  _NoteListStateState createState() => _NoteListStateState();
}

class _NoteListStateState extends State<NoteList> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var weekDay = DateFormat(DateFormat.WEEKDAY);
    var dateFormat = DateFormat('${DateFormat.MONTH} ${DateFormat.DAY}');

    return Scaffold(
      drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${weekDay.format(DateTime.now())}',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      '${dateFormat.format(DateTime.now())}',
                      style: Theme.of(context).textTheme.subhead
                    ),
                  ],
                ),
              ),
              SizedBox.fromSize(size: Size.fromHeight(100)),
              Expanded(
                child: FutureBuilder(
                  future: widget.model.data,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text('Loading...');

                    List<Note> notes = snapshot.data;
                    return PageView.builder(
                      controller: PageController(viewportFraction: 0.8),
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20, left: index == 0 ? 0 : 7.5, right: index == notes.length - 1 ? 0 : 7.5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Text(notes[index].data),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
