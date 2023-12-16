// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:instanet/controller/bottombar_contoller.dart';
// import 'package:instanet/controller/feed_controller.dart';
// import 'package:instanet/helpers/app_colors.dart';
// import 'package:instanet/model/post_model.dart';
// import 'package:instanet/view/widgets/post_card.dart';
// import 'package:provider/provider.dart';

// class Demo extends StatefulWidget {
//   const Demo({super.key});

//   @override
//   State<Demo> createState() => _DemoState();
// }

// class _DemoState extends State<Demo> {
//   // String username = '';
//   // String photoUrl = '';

//   // @override
//   // void initState() {
//   //   // TODO: implement initState

//   //   getUesername();
//   // }

//   // getUesername() async {
//   //   var userSnap = await FirebaseFirestore.instance
//   //       .collection('user')
//   //       .doc(FirebaseAuth.instance.currentUser!.uid)
//   //       .get();
//   //   setState(() {
//   //     username = (userSnap.data() as Map<String, dynamic>)['username'];
//   //     photoUrl = (userSnap.data() as Map<String, dynamic>)['photoUrl'];
//   //   });
//   //   print(username);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     Provider.of<FeedController>(context).fecthDonorDatas();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         automaticallyImplyLeading: false,
//         // title:
//         // AppBarTitile(firstName: 'Stud', secondName: 'ents ')
//       ),
//       body: Consumer<FeedController>(builder: (context, value, index) {
//         if (value.studentDatas.isEmpty) {
//           return Center(
//               child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                   radius: 35,
//                   backgroundColor: Colors.black,
//                   child: Icon(
//                     Icons.people_sharp,
//                     color: Colors.white,
//                     size: 40,
//                   )),
//               const SizedBox(
//                 width: 8,
//               ),
//               const Text(
//                 'ADD student',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 23,
//                     fontStyle: FontStyle.italic),
//               ),
//             ],
//           ));
//         }
//         return Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: ListView.builder(
//                 itemCount: value.studentDatas.length,
//                 itemBuilder: (context, index) {
//                   final Post donorSnap = value.studentDatas[index];

//                   PostCard(
                    
//                   );
//                 }));
//       }),
//     );
//   }
// }
