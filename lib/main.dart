import 'package:flutter/material.dart';
import 'package:utopian/blocs/contribution_bloc.dart';
import 'package:utopian/model/Contribution.dart';
import 'package:utopian/model/rock_api.dart';
import 'package:utopian/provider/contribution_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContributionProvider(
      contributionBloc: ContributionBloc((RockApi())),
      child: RocApp(),
    );
  }
}

class RocApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final contributionBloc = ContributionProvider.of(context);

    return MaterialApp(
      title: 'Utopian Rocks Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Utopian Rocks Mobile"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.rate_review),
                  text: 'Waiting for Review',
                ),
                Tab(
                  icon: Icon(Icons.hourglass_empty),
                  text: 'Waiting on Upvote',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage('unreviewed', contributionBloc),
              ListPage('pending', contributionBloc),
            ],
          ),
        ),
        length: 2,
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;
  ListPage(this.pageName, this.bloc);
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);

    return StreamBuilder(
        stream: bloc.results,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          print(snapshot.data.length);
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text('${snapshot.data[index].title}'),
                ),
          );
        });
  }
}
