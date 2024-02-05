import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/screens/authform_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isDarkMode = false;
  File? _image;
  final picker = ImagePicker();




  Future getImager() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        debugPrint("No image selected");
      }
    });
  }

  final TextEditingController textName = TextEditingController();
  final TextEditingController textEmail = TextEditingController();
  final TextEditingController textYear = TextEditingController();

  Future<void> addTextToFirebase(String name, String email, String year) async {
    CollectionReference user = FirebaseFirestore.instance.collection('User');

    await user.add({
      'User': name,
      'Email': email,
      'Year': year,
      'timestamp': FieldValue.serverTimestamp(),
    });

    debugPrint('Text added to Firebase: $name');
    debugPrint('Text added to Firebase: $email');
    debugPrint('Text added to Firebase: $year');
  }

  // ==================== updated the name of the user =======================================
  Future<void> updateTextInFirebase(String documentId, String newname,
      String newemail, String newyear) async {
    CollectionReference user = FirebaseFirestore.instance.collection('User');

    // Reference to the specific document
    DocumentReference documentReference = user.doc(documentId);

    // Update the 'text' field with the new text
    await documentReference.update({
      'User': newname,
      'Email': newemail,
      'Year': newyear,
    });

    debugPrint('Text added to Firebase: $newname');
    debugPrint('Text added to Firebase: $newemail');
    debugPrint('Text added to Firebase: $newyear');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:const Text('TODO - LIST'),
        backgroundColor: Colors.blue,
       
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          // color: Theme.of(context).primaryColor,
                          color :  Colors.blue,
                          width: 5.0,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: _image == null
                                ? const Center(
                                    child: Text(
                                      'No image selected',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  )
                                : Image.file(_image!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            backgroundColor:  Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              getImager();
                            });
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('User')
                      .doc('hRYUPfKKb219x4LlWqYN')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.data() == null) {
                      return Text('No data available');
                    }

                    var text = snapshot.data!
                        .data()!['User']; // Adjust the field name accordingly
                    return Text(
                      text,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 4.0),
              // ===========================================================================================
              Center(
                child: Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('User')
                          .doc('hRYUPfKKb219x4LlWqYN')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.data() == null) {
                          return Text('No data available');
                        }

                        var text = snapshot.data!.data()![
                            'Email']; // Adjust the field name accordingly
                        return Text(
                          text,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('User')
                          .doc('hRYUPfKKb219x4LlWqYN')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData ||
                            snapshot.data == null ||
                            snapshot.data!.data() == null) {
                          return Text('1 Year of Experience');
                        }

                        var text = snapshot.data!.data()![
                            'Year']; // Adjust the field name accordingly
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Text(
                              ' Year of Experience',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              const Divider(),
              ListTile(
                onTap: () {
                  // Implement Edit Profile screen navigation
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Column(children: [
                            // =============================Name =====================
                            TextField(
                              controller: textName,
                              decoration: InputDecoration(
                                labelText: 'Name of User',
                                labelStyle: TextStyle(
                                    color:  Colors.blue,),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Colors.blue,),
                                ),
                              ),
                              cursorColor:  Colors.blue,
                            ),
                            // =============================Email = ====================
                            TextField(
                              controller: textEmail,
                              decoration: InputDecoration(
                                labelText: 'Email of User',
                                labelStyle: TextStyle(
                                    color:  Colors.blue,),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Colors.blue,),
                                ),
                              ),
                              cursorColor:  Colors.blue,
                            ),
                            // =============================Year = ====================
                            TextField(
                              controller: textYear,
                              decoration: InputDecoration(
                                labelText: 'Year of Experience',
                                labelStyle: TextStyle(
                                    color:  Colors.blue,),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:  Colors.blue,),
                                ),
                              ),
                              cursorColor:  Colors.blue,
                            ),
                          ]),
                          actions: [
                            Center(
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      addTextToFirebase(textName.text,
                                          textEmail.text, textYear.text);
                                      textName.clear();
                                      textEmail.clear();
                                      textYear.clear();
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                         Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      updateTextInFirebase(
                                        // Replace 'your_document_id' with the actual document ID you want to update
                                        'hRYUPfKKb219x4LlWqYN',
                                        textName.text,
                                        textEmail.text,
                                        textYear.text,
                                      );
                                      textName.clear();
                                      textEmail.clear();
                                      textYear.clear();
                                    },
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
                leading: const Icon(
                  Icons.person,
                  color: Colors.blue, // Add color to the icon
                ),
                title: const Text('Edit Profile'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blue, // Add color to the icon
                ),
              ),
              ListTile(
                onTap: () {
                  // Implement Edit Preferences screen navigation
                },
                leading: const Icon(
                  Icons.settings,
                  color: Colors.green, // Add color to the icon
                ),
                title: const Text('Edit Preferences'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.green, // Add color to the icon
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  // Implement Notifications screen navigation
                },
                leading: const Icon(
                  Icons.bookmarks,
                  color:
                      Color.fromARGB(255, 0, 13, 255), // Add color to the icon
                ),
                title: const Text('Manage Bookmarks'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color:
                      Color.fromARGB(255, 0, 13, 255), // Add color to the icon
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () {
                  // Implement Notifications screen navigation
                },
                leading: const Icon(
                  Icons.notifications,
                  color: Colors.orange, // Add color to the icon
                ),
                title: const Text('Notifications'),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.orange, // Add color to the icon
                ),
              ),
              // ======================================================
              ListTile(
                leading: const Icon(
                  Icons.dark_mode,
                  color: Colors.blue, // Add color to the icon
                ),
                title: const Text('Dark Mode'),
                // trailing: Switch(
                  // value: Provider.of<ThemeProvider>(context).isDarkMode,
                  // onChanged: (value) {
                  //   Provider.of<ThemeProvider>(context, listen: false)
                  //       .toggleTheme();
                  // },
                // ),
              ),
              const Divider(),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => authForm()));
            
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Define the action to be performed when the FAB is pressed
          debugPrint('FAB pressed');
        },
        backgroundColor:  Colors.blue,
        tooltip: 'Help',
        child: const Icon(
          Icons.message_rounded,
          color: Colors.white, // Add color to the icon
        ),
      ),
    );
  }
}
