import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageUrl;
  File? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchProfileImage();
  }

  Future<void> fetchProfileImage() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final firebaseStorage = FirebaseStorage.instance;
    final fileName = '$userId.jpg';
    final reference = firebaseStorage.ref("profiles/$fileName");
    final imageUrl = await reference.getDownloadURL();
    setState(() {
      this.imageUrl = imageUrl;
    });
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      print(pickedImage.path);
      setState(() {
        _image = File(pickedImage.path);
      });
      final firebaseStorage = FirebaseStorage.instance;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final fileName = '$userId.jpg';
      final reference = firebaseStorage.ref("profiles/$fileName");
      await reference.putFile(_image!);
      fetchProfileImage(); // Atualizar a imagem após o upload
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final email = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage:
                  imageUrl != null ? NetworkImage(imageUrl!) : null,
              child: imageUrl == null
                  ? const Icon(
                      Icons.person,
                      size: 80,
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text("Selecionar Imagem"),
            )
          ],
        ),
      ),
    );
  }
}
