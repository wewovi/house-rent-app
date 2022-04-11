import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/homeModel.dart';
import '../providers/homeProvider.dart';
import 'homeuploadpage.dart';

class HomesAll extends StatelessWidget {
  const HomesAll({Key? key, required this.id}) : super(key: key);
  static const routeName = '/all-homes';
  final String id;

  @override
  Widget build(BuildContext context) {
    final key = Provider.of<Home>(context);
    final home = Provider.of<HomeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Homes'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(HomeUploadPage.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
          itemCount: home.homes.length,
          itemBuilder: (context, i) => Dismissible(
            background: Container(color: Colors.red, child: Icon(Icons.delete)),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              Provider.of<HomeProvider>(context, listen: false)
                  .deleteHome(home.homes[i].id);
            },
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Delete Confirmation"),
                    content: const Text(
                        "Are you sure you want to delete this item?"),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            //Provider.of<HomeProvider>(context, listen: false).removeHome(id);

                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Delete")),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(home.homes[i].frontViewImagesUrl),
              ),
              title: Text(
                home.homes[i].cate,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('GHc${home.homes[i].pricePerMonth.toString()}/Month'),
              trailing: Flexible(
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(HomeUploadPage.routeName, arguments: id);
                    },
                    icon: Icon(Icons.edit)),
              ),
            ),
          ),
        ));
  }
}
