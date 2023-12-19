// // import 'package:flutter/material.dart';

// // class LikeAnimation extends StatefulWidget {
// //   final Widget child;
// //   final bool isAnimating;
// //   final Duration duration;
// //   final VoidCallback? onEnd;
// //   final bool smallLike;
// //   const LikeAnimation({
// //     Key? key,
// //     required this.child,
// //     required this.isAnimating,
// //     this.duration = const Duration(milliseconds: 150),
// //     this.onEnd,
// //     this.smallLike = false,
// //   }) : super(key: key);

// //   @override
// //   State<LikeAnimation> createState() => _LikeAnimationState();
// // }

// // class _LikeAnimationState extends State<LikeAnimation>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController controller;
// //   late Animation<double> scale;

// //   @override
// //   void initState() {
// //     super.initState();
// //     controller = AnimationController(
// //       vsync: this,
// //       duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
// //     );
// //     scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
// //   }

// //   @override
// //   void didUpdateWidget(covariant LikeAnimation oldWidget) {
// //     super.didUpdateWidget(oldWidget);

// //     if (widget.isAnimating != oldWidget.isAnimating) {
// //       startAnimation();
// //     }
// //   }

// //   startAnimation() async {
// //     if (widget.isAnimating || widget.smallLike) {
// //       await controller.forward();
// //       await controller.reverse();
// //       await Future.delayed(
// //         const Duration(milliseconds: 200),
// //       );

// //       if (widget.onEnd != null) {
// //         widget.onEnd!();
// //       }
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     super.dispose();
// //     controller.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return ScaleTransition(
// //       scale: scale,
// //       child: widget.child,
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:instanet/controller/like_animation_controller.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LikeAnimation extends StatefulWidget {
//   final Widget child;
//   final bool isAnimating;
//   final Duration duration;
//   final VoidCallback? onEnd;
//   final bool smallLike;

//   const LikeAnimation({
//     Key? key,
//     required this.child,
//     required this.isAnimating,
//     this.duration = const Duration(milliseconds: 150),
//     this.onEnd,
//     this.smallLike = false,
//   }) : super(key: key);

//   @override
//   State<LikeAnimation> createState() => _LikeAnimationState();
// }

// class _LikeAnimationState extends State<LikeAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<double> scale;

//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
//     );
//     scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
//   }

//   @override
//   void didUpdateWidget(covariant LikeAnimation oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.isAnimating != oldWidget.isAnimating) {
//       startAnimation();
//     }
//   }

//   startAnimation() async {
//     if (widget.isAnimating || widget.smallLike) {
//       await controller.forward();
//       await controller.reverse();
//       await Future.delayed(
//         const Duration(milliseconds: 200),
//       );

//       if (widget.onEnd != null) {
//         widget.onEnd!();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaleTransition(
//       scale: scale,
//       child: widget.child,
//     );
//   }
// }

// class YourViewPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<LikeAnimationProvider>(
//       create: (context) => LikeAnimationProvider(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Your View Page'),
//         ),
//         body: YourContentWidget(),
//       ),
//     );
//   }
// }

// class YourContentWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LikeAnimationProvider>(
//       builder: (context, likeProvider, child) {
//         return GestureDetector(
//           onTap: () {
//             likeProvider.startAnimation();
//             // Add your logic here for handling the like action
//           },
//           child: LikeAnimation(
//             child: YourItemWidget(), // Replace with your actual item widget
//             isAnimating: likeProvider.isLikeAnimating,
//             onEnd: () {
//               likeProvider.endAnimation();
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// class YourItemWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // Your item widget content
//       width: 100,
//       height: 100,
//       color: Colors.blue,
//     );
//   }
// }

// void main() {
//   runApp(
//     MaterialApp(
//       home: YourViewPage(),
//     ),
//   );
// }
