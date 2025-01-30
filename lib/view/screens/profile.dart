import 'package:dummyprojecr/models/signupmodel.dart';
import 'package:dummyprojecr/view/screens/signin.dart';
import 'package:flutter/material.dart';



class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late User editableUser;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    editableUser = User(
      name: widget.user.name,
      phoneNumber: widget.user.phoneNumber,
      email: widget.user.email,
      username: widget.user.username,
      password: widget.user.password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage('assets/images/splash.png'), 
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.user.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (isEditing)
                      Column(
                        children: [
                          _buildEditableField(
                              label: 'Name', initialValue: editableUser.name, onChanged: (value) => editableUser.name = value),
                          _buildEditableField(
                              label: 'Phone Number',
                              initialValue: editableUser.phoneNumber,
                              onChanged: (value) => editableUser.phoneNumber = value),
                          _buildEditableField(
                              label: 'Email', initialValue: editableUser.email, onChanged: (value) => editableUser.email = value),
                          _buildEditableField(
                              label: 'Username',
                              initialValue: editableUser.username,
                              onChanged: (value) => editableUser.username = value),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                                widget.user.name = editableUser.name;
                                widget.user.phoneNumber = editableUser.phoneNumber;
                                widget.user.email = editableUser.email;
                                widget.user.username = editableUser.username;
                              });
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildProfileDetail(label: 'Name', value: widget.user.name),
                          Divider(),
                          _buildProfileDetail(label: 'Phone Number', value: widget.user.phoneNumber),
                          Divider(),
                          _buildProfileDetail(label: 'Email', value: widget.user.email),
                          Divider(),
                          _buildProfileDetail(label: 'Username', value: widget.user.username),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                            child: const Text('Edit Profile'),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildProfileDetail({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class ProfilePage extends StatefulWidget {
//   final User user;

//   const ProfilePage({super.key, required this.user});

//   @override
//   ProfilePageState createState() => ProfilePageState();
// }

// class ProfilePageState extends State<ProfilePage> {
//   late User editableUser;
//   bool isEditing = false;

//   @override
//   void initState() {
//     super.initState();
//     editableUser = User(
//       name: widget.user.name,
//       phoneNumber: widget.user.phoneNumber,
//       email: widget.user.email,
//       username: widget.user.username,
//       password: widget.user.password,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile Page'), actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignInPage()),
//                 (route) => false,
//               );
//             },
//           ),
//         ],),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (isEditing)
//               Column(
//                 children: [
//                   TextFormField(
//                     initialValue: editableUser.name,
//                     decoration: InputDecoration(labelText: 'Name'),
//                     onChanged: (value) => editableUser.name = value,
//                   ),
//                   TextFormField(
//                     initialValue: editableUser.phoneNumber,
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     onChanged: (value) => editableUser.phoneNumber = value,
//                   ),
//                   TextFormField(
//                     initialValue: editableUser.email,
//                     decoration: InputDecoration(labelText: 'Email'),
//                     onChanged: (value) => editableUser.email = value,
//                   ),
//                   TextFormField(
//                     initialValue: editableUser.username,
//                     decoration: InputDecoration(labelText: 'Username'),
//                     onChanged: (value) => editableUser.username = value,
//                   ),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isEditing = false;
//                         widget.user.name = editableUser.name;
//                         widget.user.phoneNumber = editableUser.phoneNumber;
//                         widget.user.email = editableUser.email;
//                         widget.user.username = editableUser.username;
//                       });
//                     },
//                     child: Text('Save'),
//                   ),
//                 ],
//               )
//             else
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${widget.user.name}'),
//                   Text('Phone Number: ${widget.user.phoneNumber}'),
//                   Text('Email: ${widget.user.email}'),
//                   Text('Username: ${widget.user.username}'),
//                   SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                     child: Text('Edit Profile'),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }