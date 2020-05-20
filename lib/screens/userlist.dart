// import 'package:budbringer/services/authentication.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../services/databaseservice.dart';
// import '../models/user_model.dart';
// import '../widgets/messenger_tile_view.dart';
// import '../utilities/color_const.dart';

// class UserList extends StatefulWidget {
//   final String currentUserId;

//   UserList({Key key, @required this.currentUserId}) : super(key: key);

//   @override
//   State createState() => UserListState(currentUserId: currentUserId);
// }

// class UserListState extends State<UserList> {
//   UserListState({Key key, @required this.currentUserId});
//   List<User> _people;
//   final String currentUserId;

//   bool isLoading = false;
//   List<Choice> choices = const <Choice>[
//     const Choice(title: 'Settings', icon: Icons.settings),
//     const Choice(title: 'Log out', icon: Icons.exit_to_app),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _setuplist();
//   }

//   _setuplist() async {
//     QuerySnapshot peoplesnap =
//         await Firestore.instance.collection('users').getDocuments();
//     List<User> people =
//         peoplesnap.documents.map((doc) => User.fromDoc(doc)).toList();
//     setState(() {
//       _people = people;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('BudBringer',
//             style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: <Widget>[
//           RaisedButton(
//             child: Text('Log Out'),
//             onPressed: () => Auth.logout(context),
//           ),
//         ],
//       ),
//       body: Container(
//         child: StreamBuilder(
//           stream: Firestore.instance.collection('users').snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(themeColor),
//                 ),
//               );
//             } else {
//               return _people == null
//                   ? Center(child: CircularProgressIndicator())
//                   : ListView.builder(
//                       itemCount: _people.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         User person = _people[index];
//                         return FutureBuilder(
//                           future: DatabaseService.getUserWithId(person.id),
//                           builder:
//                               (BuildContext context, AsyncSnapshot snapshot) {
//                             if (!snapshot.hasData) {
//                               return SizedBox.shrink();
//                             }
//                             User personlocal = snapshot.data;
//                             return MessengerTiles(
//                               currentUserId: widget.currentUserId,
//                               contact: personlocal,
//                             );
//                           },
//                         );
//                       },
//                     );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class Choice {
//   const Choice({this.title, this.icon});

//   final String title;
//   final IconData icon;
// }
