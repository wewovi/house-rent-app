import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/booked.dart';
import '../providers/homeProvider.dart';
import '../widgets/bookies.dart';

class MyBookies extends StatefulWidget {
  const MyBookies({Key? key}) : super(key: key);

  @override
  State<MyBookies> createState() => _MyBookiesState();
}

class _MyBookiesState extends State<MyBookies> {
  var isLoading = false;

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Booked>(context).fetchBookies().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final home = Provider.of<Booked>(context);
    final homeData = home.books;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookies'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<Booked>(
              builder: (_, notifier, __) => ListView.separated(
                    itemBuilder: (context, i) => Bookies(
                      imageUrl: notifier.books[i].homes[i].frontViewImagesUrl,
                      landlord: notifier.books[i].homes[i].landLoardName,
                      price: notifier.books[i].homes[i].pricePerMonth,
                      category: notifier.books[i].homes[i].cate,
                    ),
                    itemCount: 2,
                    separatorBuilder: (context, i) => SizedBox(
                      height: 10,
                    ),
                  )),
    );
  }
}
