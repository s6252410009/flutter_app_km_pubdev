import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CamgalUI extends StatefulWidget {
  const CamgalUI({Key? key}) : super(key: key);

  @override
  _CamgalUIState createState() => _CamgalUIState();
}

class _CamgalUIState extends State<CamgalUI> {
  //สร้างตัวเเปรเก็บรูปที่ได้จากการเลือก
  File? imageSelectedUse;

  //เมธอดเปิดกล้อง
  Future selectImgFromCamera() async {
    final imageSelect =
        //คำสั่งเปิด Camera เเล้วเลือกรูปเก็บใน imageSelect
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageSelect == null) {
      return;
    }
    final ImageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelectedUse = ImageSelectPath;
    });
  }

  //เมธอดเปิดเเกลลอรี่
  SelectImgFromGallery() async {
    final imageSelect =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageSelect == null) {
      return;
    }
    final ImageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelectedUse = ImageSelectPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CamGal KM',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 60.0,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    90.0,
                  ),
                  child: imageSelectedUse == null
                      ? Image.asset(
                          'assets/images/logo.png',
                          width: 180.0,
                          height: 180.0,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imageSelectedUse!.path),
                          width: 180.0,
                          height: 180.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      selectImgFromCamera();
                    },
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                    label: Text(
                      'Camera',
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      SelectImgFromGallery();
                    },
                    icon: Icon(Icons.camera),
                    label: Text(
                      'Gallery',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
