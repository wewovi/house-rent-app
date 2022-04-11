import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/profileModel.dart';
import '../providers/profilesProvider.dart';
import '../widgets/header_widget.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);
  static final routeName = '/edit-profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _saveProfile() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      Provider.of<ProfileProvider>(context, listen: false)
          .addProfile(newProfile)
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
      }).then((value) => {
                setState(() {
                  isLoading = false;
                }),
                Navigator.of(context).pop()
              });
    }
  }

  var newProfile = Profile(email: '', locatioin: '', name: '', phone: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                _saveProfile();
              },
              icon: Icon(
                Icons.save,
                size: 25,
              ))
        ],
        elevation: 0,
        title: Text('EditProfile'),
      ),
      body: ListView(
        children: [
          Stack(children: [
            Container(
              height: 100,
              child: const HeaderWidget(100, false, Icons.house_rounded),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Name',
                    ),
                    onSaved: (value) {
                      newProfile = Profile(
                          email: newProfile.email,
                          locatioin: newProfile.locatioin,
                          name: value!,
                          phone: newProfile.phone);
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
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Location',
                    ),
                    onSaved: (value) {
                      newProfile = Profile(
                          email: newProfile.email,
                          locatioin: value!,
                          name: newProfile.name,
                          phone: newProfile.phone);
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
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                    ),
                    onSaved: (value) {
                      newProfile = Profile(
                          email: value!,
                          locatioin: newProfile.locatioin,
                          name: newProfile.name,
                          phone: newProfile.phone);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cannot be left empty';
                      }
                      if (!value.contains('@')) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Tell Number',
                    ),
                    onSaved: (value) {
                      newProfile = Profile(
                          email: newProfile.email,
                          locatioin: newProfile.locatioin,
                          name: newProfile.name,
                          phone: value!);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field cannot be left empty';
                      }
                      if (value.length < 10 || !value.startsWith('0')) {
                        return 'please type a valid telephone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
