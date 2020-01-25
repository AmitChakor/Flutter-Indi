import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
// import 'package:photofilters/photofilters.dart';
// import 'package:image/image.dart' as imageLib;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', 
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {  

  File _image;
  File _cameraImage;
  File _video;
  File _cameraVideo;
  // Filter _filter;
  // String fileName;  
  // imageLib.Image _imageLib;
  // List<Filter> filters = presetFitersList;

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    //var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);    
    //var imageL = imageLib.decodeImage(imageFile.readAsBytesSync());
    //imageL = imageLib.copyResize(imageL);
    setState(() {
      _image = image;    
      //_imageLib = imageL;
    });
  }

  
  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _cameraImage = image;    
    });
  }

  
  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
     _video = video; 
    _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
      setState(() { });
      _videoPlayerController.play();
    });
  }

   // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.camera);
     _cameraVideo = video; 
    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo)..initialize().then((_) {
      setState(() { });
      _cameraVideoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Indi Camera App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),            
            child: Column(
              children: <Widget>[
                if(_image != null) 
                  Image.file(_image)
                else
                  Text("Click on Pick Image to select an Image", style: TextStyle(fontSize: 18.0),),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                // _image == null
                //   ? new Text('No image selected.')
                //   : new PhotoFilterSelector(
                //   image: _imageLib,
                //   filters: presetFitersList,
                //   filename: _image.toString(),
                //   loader: Center(child: CircularProgressIndicator()), 
                //   title: null,
                // ),
                SizedBox(
                  height: 16.0,
                ),

                if(_cameraImage != null) 
                  Image.file(_cameraImage)
                else
                  Text("Click on Pick Image to select an Image", style: TextStyle(fontSize: 18.0),),
                RaisedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("Pick Image From Camera"),
                ),
                if(_video != null) 
                      _videoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                  : Container()
                else
                  Text("Click on Pick Video to select video", style: TextStyle(fontSize: 18.0),),
                RaisedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if(_cameraVideo != null) 
                      _cameraVideoPlayerController.value.initialized
                  ? AspectRatio(
                      aspectRatio: _cameraVideoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_cameraVideoPlayerController),
                    )
                  : Container()
                else
                  Text("Click on Pick Video to select video", style: TextStyle(fontSize: 18.0),),
                RaisedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                )
              ],
            ),            
          ),
        ),
      ),
    );
  }
}