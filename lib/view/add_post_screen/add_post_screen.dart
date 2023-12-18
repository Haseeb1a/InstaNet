import 'package:flutter/material.dart';
import 'package:instanet/controller/add_controller.dart';
import 'package:instanet/controller/user_provider.dart';
import 'package:instanet/helpers/app_colors.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    final addController = Provider.of<Addcontroller>(context);
    final width = MediaQuery.of(context).size.width;
    return addController.file == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  
                  backgroundColor: Colors.grey,
                  radius: 30,
                  child: IconButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('create a post'),
                              children: [
                                SimpleDialogOption(
                                    padding: const EdgeInsets.all(20),
                                    child: const Text('Choose from photo'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      addController.pickfilecamera();
                                    }),
                                SimpleDialogOption(
                                    padding: const EdgeInsets.all(20),
                                    child: const Text('Choose from gallery'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      addController.pickfilegallery();
                                    }),
                                SimpleDialogOption(
                                    padding: const EdgeInsets.all(20),
                                    child: const Text('cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            );
                          }),
                      icon: const Icon(Icons.upload,color: Colors.white,)),
                ),
                SizedBox(height: 10,),
                Text('Make Some Posts...')
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                  onPressed: () {
                    addController.clearimage();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  )),
              title: const Text('Post to'),
              actions: [
                TextButton(
                    onPressed: () {
                      addController.postImage(
                          user.uid, user.username, user.photoUrl, context);
                    },
                    child: const Text(
                      'Post',
                      style: TextStyle(
                          color: blueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ))
              ],
            ),
            body: Column(
              children: [
                addController.isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photoUrl),
                    ),
                    SizedBox(
                      width: width * 0.45,
                      child: TextField(
                        maxLength: 8,
                        controller: addController.descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption...',
                          hintStyle: TextStyle(
                              color:
                                  primaryColor), // Set the hint text color here
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(addController.file!),
                                    fit: BoxFit.fill,
                                    alignment: FractionalOffset.topCenter))),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          );
  }
}
