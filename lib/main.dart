import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fruit_classifier/DialogBox/loading.dart';
import 'package:fruit_classifier/get_data.dart';
import 'package:fruit_classifier/toast.dart';
import 'package:fruit_classifier/widgets/HomePage/bottomFieldHome.dart';
import 'package:fruit_classifier/widgets/HomePage/creditsBtn.dart';
import 'package:fruit_classifier/widgets/HomePage/exploreAllHome.dart';
import 'package:fruit_classifier/widgets/splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_classifier/model/fruit.dart';
import 'package:fruit_classifier/model/hexColor.dart';
import 'package:fruit_classifier/widgets/result_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

//https://fruit-finder-0.flycricket.io/privacy.html
//https://fruit-finder-0.flycricket.io/terms.html

void main() {
  runApp(
    MaterialApp(
      title: 'Fruit Finder',
      home: SpalshScreen(),
      theme: ThemeData(
        primaryColor: HexColor('#1c1f22'),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Fruit>> data;
  late LinkedHashMap<String, dynamic> output;
  String modelUrl = 'https://fruit-finder-server.herokuapp.com/predict';
  TextEditingController inputController = TextEditingController();
  late File _img;

  @override
  void initState() {
    super.initState();
    data = getData(context);
  }

  void predFruit(File imageFile) async {
    _img = imageFile;
    double file_size = await _img.length() / 1024000;
    print(file_size);
    if (file_size > 4.5) {
      invalidInputToast("Try with Smaller Image(<5MB)");
      return;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => onLoading());
    try {
      final typeData =
          lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])!.split("/");
      final imageUploadRequest =
          http.MultipartRequest("POST", Uri.parse(modelUrl));
      final file = await http.MultipartFile.fromPath("image", imageFile.path);
      imageUploadRequest.fields['ext'] = typeData[1];
      imageUploadRequest.files.add(file);
      final responseUpload = await imageUploadRequest.send();
      final response = await http.Response.fromStream(responseUpload);

      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      int data_len = await data.asStream().length;
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (!responseData['error'] && data_len == 1) {
        output = responseData['output'];
        List fruit_lt = output.keys.toList();
        Future<List<Fruit>> fruits = data.then((value) => value
            .where((element) => (fruit_lt.contains(element.pred_name)))
            .toList());
        List predFruits = await fruits.then((value) => value);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (contect) => ResultPage(data, predFruits, output, _img)));
      } else {
        // print('else');
        Navigator.of(context, rootNavigator: true).pop('dialog');
        invalidInputToast("Try Again");
      }
    } catch (e) {
      print(e);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      invalidInputToast("Try Again");
    }
  }

  Future getImage(String source) async {
    ImageSource imgSource = ImageSource.camera;

    if (source == "Storage") imgSource = ImageSource.gallery;
    final img = await ImagePicker.platform.pickImage(source: imgSource);
    Navigator.of(context, rootNavigator: true).pop('dialog');
    if (img != null) {
      File _image = File(img.path);
      predFruit(_image); //.then((value) => value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(children: [
              CreditsBtn(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSelectImage(context),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.url,
                        style: TextStyle(color: Colors.white.withOpacity(0.77)),
                        autofocus: false,
                        controller: inputController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.redAccent.shade200,
                            ),
                          ),
                          focusColor: Colors.white,
                          hintText: "PASTE IMAGE URL(e.g, https://xyz.jpg)",
                          hintStyle: TextStyle(
                              color: HexColor('#FFFFFF').withOpacity(0.46),
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                          fillColor: HexColor('#E53232'),
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              top: 11, left: 10, right: 8, bottom: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                        ),
                        cursorColor: Colors.grey,
                        onSubmitted: (url) {
                          _submit(url);
                        },
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _submit(inputController.text);
                            },
                            child: Text(
                              'SEARCH',
                              style: TextStyle(
                                  color: HexColor('#FFFFFF').withOpacity(0.77),
                                  fontWeight: FontWeight.w500),
                            ),
                            style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(158, 33)),
                                backgroundColor: MaterialStateProperty.all(
                                    HexColor('#333333')),
                                alignment: Alignment.center,
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero))),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  ExploreAll(data: data),
                ],
              ),
              BottomField(),
            ]),
          ),
        ),
      ),
    );
  }

  TextButton buildSelectImage(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => _selectImg());
        //Image.file(getCameraImage());
      },
      child: Text(
        "SELECT IMAGE",
        style: TextStyle(
            color: HexColor('#FFFFFF').withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(Size(157, 36)),
        backgroundColor: MaterialStateProperty.all(HexColor('#333333')),
        alignment: Alignment.center,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: HexColor('#606060').withOpacity(0.67), width: 2),
        ),
      ),
    );
  }

  _submit(String url) async {
    FocusScope.of(context).unfocus();
    if (url.isNotEmpty) {
      try {
        final response = await http.get(Uri.parse(url));
        // print(response);
        if (response.statusCode == 200) {
          var rng = new Random();
          //get temporary directory of device.
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          // create file in tempDir with random name
          File file =
              new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
          //write bodyBytes in file
          await file.writeAsBytes(response.bodyBytes);
          File _image = file;
          predFruit(_image);
        } else
          invalidInputToast("Invlaid URL");
      } catch (e) {
        invalidInputToast("Invalid URL");
      }
      setState(() {
        inputController = TextEditingController();
      });
    }
  }

  AlertDialog _selectImg() {
    return AlertDialog(
      backgroundColor: HexColor('#333333'),
      title: Text(
        "Select Image",
        style: TextStyle(color: Colors.white),
      ),
      content: Container(
        height: 113,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => getImage("Camera"),
              leading: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              title: Text(
                "Camera",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () => getImage("Storage"), //getGalleryImage,
              leading: Icon(Icons.image, color: Colors.white),
              title: Text(
                "Photos",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
