import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/homeModel.dart';
import '../providers/homeProvider.dart';

class HomeUploadPage extends StatefulWidget {
  HomeUploadPage({Key? key}) : super(key: key);
  static const routeName = '/home-upload-page';

  @override
  State<HomeUploadPage> createState() => _HomeUploadPageState();
}

class _HomeUploadPageState extends State<HomeUploadPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _frontViewImageController =
      TextEditingController();
  final TextEditingController _kitchenImageController = TextEditingController();
  final TextEditingController _toiletImageController = TextEditingController();
  final TextEditingController _bedroomImageController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _numberOfRoomsController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _landLordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String dropdownvalue = 'Single Room';
  var _isLoading = false;
  // var isInit = true;

  //   var initValues = {
  //      'isAvailable':true,
  // 'rating': 0,
  // 'frontViewImagesUrl': '',
  // 'cate': category.singleRoom,
  // 'id': '',
  // 'description': '',
  // 'location': '',
  // 'pricePerMonth': 0.0,
  // 'kitchenImageUrl': '',
  // 'numberOfRooms': 0,
  // 'toiletImageUrl': ''
  //   };
// @override
//   void didChangeDependencies() {
//     if(isInit){
//       final homeId = ModalRoute.of(context)!.settings.arguments as String;
//       if(homeId != null){
// final editHomeData =  Provider.of<HomeProvider>(context, listen: false).findById(homeId);
  //    initValues={
  //          'isAvailable':editHomeData.isAvailable,
  // 'rating': editHomeData.rating,
  // 'frontViewImagesUrl': editHomeData.frontViewImagesUrl,
  // 'cate': editHomeData.Category,
  // 'id': editHomeData.id,
  // 'description': editHomeData.description,
  // 'location': editHomeData.location,
  // 'pricePerMonth': editHomeData.pricePerMonth,
  // 'kitchenImageUrl': editHomeData.kitchenImageUrl,
  // 'numberOfRooms': editHomeData.numberOfRooms,
  // 'toiletImageUrl': editHomeData.toiletImageUrl
  //    };
  //     }

  //   }
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  var newHome = Home(
      landLoardName: '',
      bedRoomUrl: '',
      isAvailable: true,
      frontViewImagesUrl: '',
      cate: '',
      id: '',
      description: '',
      location: '',
      pricePerMonth: 0.0,
      kitchenImageUrl: '',
      numberOfRooms: 0,
      toiletImageUrl: '');

  var items = ['Self-Contained', 'Appartment', 'Single Room', 'House'];

  void _savedForm() {
    print(_descriptionController.text);
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      Provider.of<HomeProvider>(context, listen: false)
          .addHome(newHome)
          .catchError((error) {
        return showDialog<Null>(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('An Error Occured'),
                  content: Text('Something went wrong'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
      }).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  void drop(value) {
    setState(() {
      dropdownvalue = value;
    });
    newHome = Home(
        landLoardName: newHome.landLoardName,
        bedRoomUrl: newHome.bedRoomUrl,
        isAvailable: newHome.isAvailable,
        frontViewImagesUrl: newHome.frontViewImagesUrl,
        cate: dropdownvalue,
        id: newHome.id,
        description: newHome.description,
        location: newHome.location,
        pricePerMonth: newHome.pricePerMonth,
        kitchenImageUrl: newHome.kitchenImageUrl,
        numberOfRooms: newHome.numberOfRooms,
        toiletImageUrl: newHome.toiletImageUrl);
  }

  bool TcheckedValue = false;
  bool TcheckboxValue = false;
  bool checkedValue = false;
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Accomodation'),
        actions: [
          IconButton(
              onPressed: () {
                _savedForm();
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _landLordController,
                      // initialValue: initValues['location'].toString(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Land Lord\'s name',
                      ),
                      onSaved: (value) {
                        newHome = Home(
                            isAvailable: newHome.isAvailable,
                            landLoardName: _landLordController.text,
                            bedRoomUrl: newHome.bedRoomUrl,
                            frontViewImagesUrl: newHome.frontViewImagesUrl,
                            cate: newHome.cate,
                            id: newHome.id,
                            description: newHome.description,
                            location: newHome.location,
                            pricePerMonth: newHome.pricePerMonth,
                            kitchenImageUrl: newHome.kitchenImageUrl,
                            numberOfRooms: newHome.numberOfRooms,
                            toiletImageUrl: newHome.toiletImageUrl);
                      },

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _locationController,
                      // initialValue: initValues['location'].toString(),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Location',
                      ),
                      onSaved: (value) {
                        newHome = Home(
                            isAvailable: newHome.isAvailable,
                            landLoardName: newHome.landLoardName,
                            bedRoomUrl: newHome.bedRoomUrl,
                            frontViewImagesUrl: newHome.frontViewImagesUrl,
                            cate: newHome.cate,
                            id: newHome.id,
                            description: newHome.description,
                            location: _locationController.text,
                            pricePerMonth: newHome.pricePerMonth,
                            kitchenImageUrl: newHome.kitchenImageUrl,
                            numberOfRooms: newHome.numberOfRooms,
                            toiletImageUrl: newHome.toiletImageUrl);
                      },

                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field cannot be left empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(10),
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(items),
                              ));
                        }).toList(),
                        onChanged: drop,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _frontViewImageController.text,
                                  fit: BoxFit.cover,
                                )),
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            //initialValue: initValues['frontImageUrl'].toString(),
                            controller: _frontViewImageController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'FrontView image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (!value!.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a correct url';
                              }
                            },
                            onSaved: (value) {
                              newHome = Home(
                                  landLoardName: newHome.landLoardName,
                                  bedRoomUrl: newHome.bedRoomUrl,
                                  isAvailable: newHome.isAvailable,
                                  frontViewImagesUrl:
                                      _frontViewImageController.text,
                                  cate: newHome.cate,
                                  id: newHome.id,
                                  description: newHome.description,
                                  location: newHome.location,
                                  pricePerMonth: newHome.pricePerMonth,
                                  kitchenImageUrl: newHome.kitchenImageUrl,
                                  numberOfRooms: newHome.numberOfRooms,
                                  toiletImageUrl: newHome.toiletImageUrl);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _bedroomImageController.text,
                                  fit: BoxFit.cover,
                                )),
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            //initialValue: initValues['frontImageUrl'].toString(),
                            controller: _bedroomImageController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Bedroom image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (!value!.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a correct url';
                              }
                            },
                            onSaved: (value) {
                              newHome = Home(
                                  landLoardName: newHome.landLoardName,
                                  bedRoomUrl: _bedroomImageController.text,
                                  isAvailable: newHome.isAvailable,
                                  frontViewImagesUrl:
                                      newHome.frontViewImagesUrl,
                                  cate: newHome.cate,
                                  id: newHome.id,
                                  description: newHome.description,
                                  location: newHome.location,
                                  pricePerMonth: newHome.pricePerMonth,
                                  kitchenImageUrl: newHome.kitchenImageUrl,
                                  numberOfRooms: newHome.numberOfRooms,
                                  toiletImageUrl: newHome.toiletImageUrl);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _kitchenImageController.text,
                                  fit: BoxFit.cover,
                                )),
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            // initialValue: initValues['kitchenImageUrl'].toString(),
                            controller: _kitchenImageController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'kitchen image url',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onSaved: (value) {
                              newHome = Home(
                                  landLoardName: newHome.landLoardName,
                                  bedRoomUrl: newHome.bedRoomUrl,
                                  isAvailable: newHome.isAvailable,
                                  frontViewImagesUrl:
                                      newHome.frontViewImagesUrl,
                                  cate: newHome.cate,
                                  id: newHome.id,
                                  description: newHome.description,
                                  location: newHome.location,
                                  pricePerMonth: newHome.pricePerMonth,
                                  kitchenImageUrl: _kitchenImageController.text,
                                  numberOfRooms: newHome.numberOfRooms,
                                  toiletImageUrl: newHome.toiletImageUrl);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  _toiletImageController.text,
                                  fit: BoxFit.cover,
                                )),
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: TextFormField(
                            // initialValue: initValues['toiletImageUrl'].toString(),
                            controller: _toiletImageController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Toilet and Bath images',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onSaved: (value) {
                              newHome = Home(
                                  isAvailable: newHome.isAvailable,
                                  landLoardName: newHome.landLoardName,
                                  bedRoomUrl: newHome.bedRoomUrl,
                                  frontViewImagesUrl:
                                      newHome.frontViewImagesUrl,
                                  cate: newHome.cate,
                                  id: newHome.id,
                                  description: newHome.description,
                                  location: newHome.location,
                                  pricePerMonth: newHome.pricePerMonth,
                                  kitchenImageUrl: newHome.kitchenImageUrl,
                                  numberOfRooms: newHome.numberOfRooms,
                                  toiletImageUrl: _toiletImageController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      // initialValue: initValues['pricePerMonth'].toString(),
                      controller: _priceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'price per month in cedis',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required please';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newHome = Home(
                            isAvailable: newHome.isAvailable,
                            landLoardName: newHome.landLoardName,
                            bedRoomUrl: newHome.bedRoomUrl,
                            frontViewImagesUrl: newHome.frontViewImagesUrl,
                            cate: newHome.cate,
                            id: newHome.id,
                            description: newHome.description,
                            location: newHome.location,
                            pricePerMonth: double.parse(_priceController.text),
                            kitchenImageUrl: newHome.kitchenImageUrl,
                            numberOfRooms: newHome.numberOfRooms,
                            toiletImageUrl: newHome.toiletImageUrl);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      // initialValue: initValues['numberOfRooms'].toString(),
                      controller: _numberOfRoomsController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Number of rooms',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required please';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newHome = Home(
                            isAvailable: newHome.isAvailable,
                            landLoardName: newHome.landLoardName,
                            bedRoomUrl: newHome.bedRoomUrl,
                            frontViewImagesUrl: newHome.frontViewImagesUrl,
                            cate: newHome.cate,
                            id: newHome.id,
                            description: newHome.description,
                            location: newHome.location,
                            pricePerMonth: newHome.pricePerMonth,
                            kitchenImageUrl: newHome.kitchenImageUrl,
                            numberOfRooms:
                                int.parse(_numberOfRoomsController.text),
                            toiletImageUrl: newHome.toiletImageUrl);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      // initialValue: initValues['numberOfRooms'].toString(),
                      controller: _descriptionController,
                      textInputAction: TextInputAction.done,
                      maxLines: 4,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Additional Info',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required please';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newHome = Home(
                            isAvailable: newHome.isAvailable,
                            landLoardName: newHome.landLoardName,
                            bedRoomUrl: newHome.bedRoomUrl,
                            frontViewImagesUrl: newHome.frontViewImagesUrl,
                            cate: newHome.cate,
                            id: newHome.id,
                            description: value!,
                            location: newHome.location,
                            pricePerMonth: newHome.pricePerMonth,
                            kitchenImageUrl: newHome.kitchenImageUrl,
                            numberOfRooms: newHome.numberOfRooms,
                            toiletImageUrl: newHome.toiletImageUrl);
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
