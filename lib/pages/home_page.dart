import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final String getFruit = """ 
    
    query allFruits {
      fruits {
        fruit_name
        description
      }
    }

  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fruits from Fruit api"),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(getFruit),
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            List fruits = result.data!['fruits'];
            print(fruits[0]);

            return ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                final name = fruits[index]['fruit_name'];
                final description = fruits[index]['description'];

                return ListTile(
                  title: Text(name),
                  subtitle: Text(description, overflow: TextOverflow.ellipsis),
                );
              },
            );
          },
        ));
  }
}
