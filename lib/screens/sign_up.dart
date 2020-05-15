// import 'dart:io';

// import 'package:budbringer/screens/userlist.dart';
// import 'package:budbringer/services/storage_service.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:budbringer/models/user_model.dart';
// import 'package:budbringer/services/databaseservice.dart';
// import 'package:budbringer/utilities/circular_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:image_picker/image_picker.dart';

// class NewUserSignUp extends StatefulWidget {
//   NewUserSignUp({this.user});
//   final FirebaseUser user;

//   @override
//   _NewUserSignUpState createState() => _NewUserSignUpState(fireUser: user);
// }

// class _NewUserSignUpState extends State<NewUserSignUp> {
//   _NewUserSignUpState({this.fireUser});
//   String phoneNumber;
//   FirebaseUser fireUser;
//   User user;
//   bool isLoading;
//   File _profileImage;
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//   TextEditingController nameController, aboutController;

//   @override
//   void initState() {
//     super.initState();
//     _getUser();
//     isLoading = false;
//   }

//   Gradient appGradient = LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [Color(0xFF6137D7), Color(0xFFBC3358)],
//       stops: [0, 0.7]);
//   final FocusNode _nameFocus = FocusNode();
//   final FocusNode _aboutFocus = FocusNode();

//   _getUser() async {
//     final _user = await DatabaseService.getUserWithId(fireUser.uid);
//     setState(() {
//       user = _user;
//     });
//   }

//   _submit() async {
//     String _profileImageUrl = '';
//     setState(() {
//       isLoading = true;
//     });
//     if (_profileImage == null) {
//       _profileImageUrl = user.profileImageUrl;
//     } else {
//       _profileImageUrl = await StorageService.uploadUserProfileImage(
//         user.profileImageUrl,
//         _profileImage,
//       );
//     }

//     User newUser = User(
//       id: user.id,
//       name: nameController.text,
//       profileImageUrl: _profileImageUrl,
//       about: aboutController.text,
//     );
//     // Database update
//     DatabaseService.updateUser(newUser);
//     setState(() {
//       isLoading = false;
//     });
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => UserList(
//                   currentUserId: fireUser.uid,
//                 )));
//   }

//   ImageProvider _displayProfileImage() {
//     // No new profile image
//     if (user != null && _profileImage == null) {
//       // No existing profile image
//       if (user.profileImageUrl.isEmpty) {
//         // Display placeholder
//         return AssetImage('assets/images/user_placeholder.jpg');
//       } else {
//         // User profile image exists
//         return CachedNetworkImageProvider(user.profileImageUrl);
//       }
//     } else {
//       // New profile image
//       return FileImage(_profileImage);
//     }
//   }

//   _fieldFocusChange(
//       BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
//     currentFocus.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }

//   _showSelectImageDialog() {
//     return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
//   }

//   _iosBottomSheet() {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoActionSheet(
//           title: Text('Add Photo'),
//           actions: <Widget>[
//             CupertinoActionSheetAction(
//               child: Text('Take Photo'),
//               onPressed: () => _handleImage(ImageSource.camera),
//             ),
//             CupertinoActionSheetAction(
//               child: Text('Choose From Gallery'),
//               onPressed: () => _handleImage(ImageSource.gallery),
//             ),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             child: Text('Cancel'),
//             onPressed: () => Navigator.pop(context),
//           ),
//         );
//       },
//     );
//   }

//   _androidDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text('Add Photo'),
//           children: <Widget>[
//             SimpleDialogOption(
//               child: Text('Take Photo'),
//               onPressed: () => _handleImage(ImageSource.camera),
//             ),
//             SimpleDialogOption(
//               child: Text('Choose From Gallery'),
//               onPressed: () => _handleImage(ImageSource.gallery),
//             ),
//             SimpleDialogOption(
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Colors.redAccent,
//                 ),
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   _handleImage(ImageSource source) async {
//     Navigator.pop(context);
//     File profileImageFile = await ImagePicker.pickImage(source: source);
//     if (profileImageFile != null) {
//       profileImageFile = await _cropImage(profileImageFile);
//       setState(() {
//         _profileImage = profileImageFile;
//       });
//     }
//   }

//   _cropImage(File imageFile) async {
//     File croppedImage = await ImageCropper.cropImage(
//       sourcePath: imageFile.path,
//       aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//     );
//     return croppedImage;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // String imgurl =
//     //     'http://hydrodictyon.eeb.uconn.edu/eebedia/images/thumb/5/5a/Profile.jpg/180px-Profile.jpg';

//     final name = Center(
//         child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: TextFormField(
//               textInputAction: TextInputAction.next,
//               focusNode: _nameFocus,
//               onFieldSubmitted: (term) {
//                 _fieldFocusChange(context, _nameFocus, _aboutFocus);
//               },
//               controller: nameController,
//               style: style,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   hintText: "Name",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0))),
//             )));
//     final about = Center(
//         child: Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: TextFormField(
//               controller: aboutController,
//               style: style,
//               textInputAction: TextInputAction.done,
//               focusNode: _aboutFocus,
//               onFieldSubmitted: (term) {
//                 _aboutFocus.unfocus();
//               },
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                   hintText: "About You ?",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(32.0))),
//             )));
//     final saveButton = Center(
//         child: Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Color(0xFFBC3358),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width * 0.5,
//         padding: EdgeInsets.fromLTRB(40.0, 15.0, 40.0, 15.0),
//         onPressed: () => _submit(),
//         child: Text("Continue",
//             textAlign: TextAlign.center,
//             style: style.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     ));
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                   child: Stack(children: <Widget>[
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.41,
//                       decoration: BoxDecoration(
//                         gradient: appGradient,
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(0),
//                             bottomLeft: Radius.circular(150)),
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.48,
//                       child: Align(
//                         alignment: Alignment.bottomCenter,
//                         child: CircularImage(
//                           _displayProfileImage(),
//                           // NetworkImage(imgurl),
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           height: MediaQuery.of(context).size.width * 0.4,
//                           showBorder: true,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * 0.7,
//                       height: MediaQuery.of(context).size.height * 0.48,
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: Material(
//                           color: Color(0xFFBC3358),
//                           borderRadius: BorderRadius.circular(40),
//                           child: IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () => _showSelectImageDialog(),
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   ]),
//                 ),
//                 SizedBox(height: 15),
//                 name,
//                 SizedBox(height: 15),
//                 about,
//                 SizedBox(height: 35),
//                 saveButton
//               ],
//             ),
//             Positioned(
//               child: isLoading
//                   ? Container(
//                       child: Center(
//                         child: Material(
//                           borderRadius: BorderRadius.circular(10),
//                           elevation: 2.0,
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.red)),
//                           ),
//                         ),
//                       ),
//                       color: Colors.white.withOpacity(0.8),
//                     )
//                   : Container(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:budbringer/utilities/color_const.dart';
import 'package:budbringer/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewUserSignUp extends StatefulWidget {
  NewUserSignUp({this.user});
  final FirebaseUser user;

  @override
  _NewUserSignUpState createState() => _NewUserSignUpState(fireUser: user);
}

class _NewUserSignUpState extends State<NewUserSignUp> {
  final scrollController = ScrollController();
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  List<FocusNode> focusNodes = [FocusNode(), FocusNode()];
  _NewUserSignUpState({this.fireUser});
  String phoneNumber;
  FirebaseUser fireUser;
  User user;
  bool onLastPage = false;
  bool displayingPlaceholder = false;
  File _profileImage;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController nameController, aboutController;
  int listIndex = 0;

  @override
  void initState() {
    super.initState();
    // _getUser();
  }

  Gradient appGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF6137D7), Color(0xFFBC3358)],
      stops: [0, 0.7]);

  _handleButton(BuildContext context, double width,
      {bool backward = false}) async {
    if (formKeys[listIndex].currentState.validate()) {
      formKeys[listIndex].currentState.save();
      if (listIndex < 2) {
        if (focusNodes[listIndex].hasFocus) {
          focusNodes[listIndex].unfocus();
        }
        setState(() {
          backward ? listIndex-- : listIndex++;
        });
        scrollController.animateTo(listIndex * width,
            duration: Duration(milliseconds: 600), curve: Curves.ease);
        if (listIndex < 2) {
          setState(() {
            onLastPage == false;
          });
          await Future.delayed(Duration(milliseconds: 600));
          FocusScope.of(context).requestFocus(focusNodes[listIndex]);
        }
        if (listIndex == 2) {
          setState(() {
            onLastPage == true;
          });
        }
      } else if (listIndex == 2) {}
    }
  }

  // _getUser() async {
  //   final _user = await DatabaseService.getUserWithId(fireUser.uid);
  //   setState(() {
  //     user = _user;
  //   });
  // }

  // _submit() async {
  //   String _profileImageUrl = '';
  //   setState(() {
  //     isLoading = true;
  //   });
  //   if (_profileImage == null) {
  //     _profileImageUrl = user.profileImageUrl;
  //   } else {
  //     _profileImageUrl = await StorageService.uploadUserProfileImage(
  //       user.profileImageUrl,
  //       _profileImage,
  //     );
  //   }

  //   User newUser = User(
  //     id: user.id,
  //     name: nameController.text,
  //     profileImageUrl: _profileImageUrl,
  //     about: aboutController.text,
  //   );
  //   // Database update
  //   DatabaseService.updateUser(newUser);
  //   setState(() {
  //     isLoading = false;
  //   });
  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => UserList(
  //                 currentUserId: fireUser.uid,
  //               )));
  // }

  // ImageProvider _displayProfileImage() {
  //   // No new profile image
  //   if (user != null && _profileImage == null) {
  //     // No existing profile image
  //     if (user.profileImageUrl.isEmpty) {
  //       // Display placeholder
  //       return AssetImage('assets/images/user_placeholder.jpg');
  //     } else {
  //       // User profile image exists
  //       return CachedNetworkImageProvider(user.profileImageUrl);
  //     }
  //   } else {
  //     // New profile image
  //     return FileImage(_profileImage);
  //   }
  // }

  // _showSelectImageDialog() {
  //   return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  // }

  // _iosBottomSheet() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoActionSheet(
  //         title: Text('Add Photo'),
  //         actions: <Widget>[
  //           CupertinoActionSheetAction(
  //             child: Text('Take Photo'),
  //             onPressed: () => _handleImage(ImageSource.camera),
  //           ),
  //           CupertinoActionSheetAction(
  //             child: Text('Choose From Gallery'),
  //             onPressed: () => _handleImage(ImageSource.gallery),
  //           ),
  //         ],
  //         cancelButton: CupertinoActionSheetAction(
  //           child: Text('Cancel'),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //       );
  //     },
  //   );
  // }

  // _androidDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: Text('Add Photo'),
  //         children: <Widget>[
  //           SimpleDialogOption(
  //             child: Text('Take Photo'),
  //             onPressed: () => _handleImage(ImageSource.camera),
  //           ),
  //           SimpleDialogOption(
  //             child: Text('Choose From Gallery'),
  //             onPressed: () => _handleImage(ImageSource.gallery),
  //           ),
  //           SimpleDialogOption(
  //             child: Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 color: Colors.redAccent,
  //               ),
  //             ),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // _handleImage(ImageSource source) async {
  //   Navigator.pop(context);
  //   File profileImageFile = await ImagePicker.pickImage(source: source);
  //   if (profileImageFile != null) {
  //     profileImageFile = await _cropImage(profileImageFile);
  //     setState(() {
  //       _profileImage = profileImageFile;
  //     });
  //   }
  // }

  // _cropImage(File imageFile) async {
  //   File croppedImage = await ImageCropper.cropImage(
  //     sourcePath: imageFile.path,
  //     aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
  //   );
  //   return croppedImage;
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    Widget name = Form(
      key: formKeys[0],
      child: Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hey! It seems you are new here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren().copyWith(
                  color: Colors.lightBlueAccent, fontSize: width * 0.08),
            ),
            Text('We will be really happy to know your beautiful name.',
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren()
                    .copyWith(color: primaryColor, fontSize: width * 0.06)),
            Padding(
              padding: const EdgeInsets.only(right: 32, left: 32, top: 52),
              child: TextFormField(
                textAlign: TextAlign.center,
                focusNode: focusNodes[0],
                textInputAction: TextInputAction.done,
                validator: (term) => term.trim().length == 0
                    ? "      Bro!! tell your name."
                    : null,
                onFieldSubmitted: (term) {
                  _handleButton(context, width);
                },
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.mcLaren(),
                    errorStyle: GoogleFonts.mcLaren().copyWith(
                        color: Colors.pinkAccent, fontSize: width * 0.06),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "What's your name?"),
                controller: nameController,
              ),
            ),
          ],
        ),
      ),
    );

    Widget about = Form(
      key: formKeys[1],
      child: Container(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nice Name!!',
              textAlign: TextAlign.center,
              style: GoogleFonts.mcLaren().copyWith(
                  color: Colors.lightBlueAccent, fontSize: width * 0.08),
            ),
            Text('Can you tell us something about you?',
                textAlign: TextAlign.center,
                style: GoogleFonts.mcLaren()
                    .copyWith(color: primaryColor, fontSize: width * 0.06)),
            Padding(
              padding: const EdgeInsets.only(right: 32, left: 32, top: 52),
              child: TextFormField(
                textAlign: TextAlign.center,
                focusNode: focusNodes[1],
                textInputAction: TextInputAction.done,
                validator: (term) => term.trim().length == 0
                    ? "Even a word will be enough."
                    : null,
                onFieldSubmitted: (term) {
                  _handleButton(context, width);
                },
                decoration: InputDecoration(
                    errorMaxLines: 2,
                    hintStyle: GoogleFonts.mcLaren(),
                    errorStyle: GoogleFonts.mcLaren().copyWith(
                        color: Colors.pinkAccent, fontSize: width * 0.06),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[200])),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        borderSide: BorderSide(color: Colors.grey[300])),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "How you doin?"),
                controller: aboutController,
              ),
            ),
          ],
        ),
      ),
    );

    Widget displayPicture = AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(child: child, scale: animation);
      },
      child: !displayingPlaceholder
          ? Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Great!!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mcLaren().copyWith(
                        color: Colors.lightBlueAccent, fontSize: width * 0.08),
                  ),
                  Text(
                    "Can't wait to see your face. Can you send me you picture?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.mcLaren()
                        .copyWith(color: primaryColor, fontSize: width * 0.06),
                  ),
                ],
              ),
            )
          : Container(),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: height * 0.6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    controller: scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      name,
                      about,
                    ],
                  ),
                ),
                SizedBox(height: height * 0.2),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: !onLastPage
                        ? GestureDetector(
                            onTap: () {
                              _handleButton(context, width);
                            },
                            child: Padding(
                              key: new UniqueKey(),
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: width * 0.4,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: shadowColor,
                                        offset: Offset(0, 6),
                                        blurRadius: 20,
                                        spreadRadius: 0)
                                  ],
                                  color: primaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: GoogleFonts.mcLaren().copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : !displayingPlaceholder
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        displayingPlaceholder = true;
                                      });
                                    },
                                    child: Padding(
                                      key: new UniqueKey(),
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: width * 0.25,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: shadowColor,
                                                offset: Offset(0, 6),
                                                blurRadius: 20,
                                                spreadRadius: 0)
                                          ],
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Yup!",
                                            style:
                                                GoogleFonts.mcLaren().copyWith(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // _handleButton(context, width);
                                    },
                                    child: Padding(
                                      key: new UniqueKey(),
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: width * 0.25,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: shadowColor,
                                                offset: Offset(0, 6),
                                                blurRadius: 20,
                                                spreadRadius: 0)
                                          ],
                                          color: primaryColor,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Nah!",
                                            style:
                                                GoogleFonts.mcLaren().copyWith(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : GestureDetector(
                                onTap: () {
                                  // _handleButton(context, width);
                                },
                                child: Padding(
                                  key: new UniqueKey(),
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: width * 0.25,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: shadowColor,
                                            offset: Offset(0, 6),
                                            blurRadius: 20,
                                            spreadRadius: 0)
                                      ],
                                      color: primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Continue",
                                        style: GoogleFonts.mcLaren().copyWith(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                  ),
                ),
                listIndex != 0
                    ? Center(
                        child: FlatButton(
                          child: Center(
                            child: Text(
                              'Back',
                              style: GoogleFonts.mcLaren().copyWith(
                                color: Colors.pinkAccent,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onPressed: () {
                            _handleButton(context, width, backward: true);
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
