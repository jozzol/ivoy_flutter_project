import 'package:coder_graph/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final HttpLink httpLink = HttpLink('https://fruits-api.netlify.app/graphql');

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client =
        ValueNotifier<GraphQLClient>(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ));

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
