import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
//import 'package:image/image.dart' as img;


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0; // Track current camera index
  bool _isCameraInitialized = false;
  late IOWebSocketChannel channel;
  String feedback = "Waiting for feedback...";

  @override
  void initState() {
    super.initState();
    initializeCamera(selectedCameraIndex);

    channel = IOWebSocketChannel.connect('wss://trainez.onrender.com/socket.io/?EIO=4&transport=websocket');  // Replace with Flask IP

    channel.stream.listen((message) {
      setState(() {
        feedback = jsonDecode(message)['message'];
      });
    });
  }

  Future<void> initializeCamera(int cameraIndex) async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      _controller = CameraController(
        cameras![cameraIndex],
        ResolutionPreset.high,
      );
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
        _startVideoStream();
      }
    }
  }

  int frameCounter = 0; 
  void _startVideoStream() async {
  if (_controller != null && _controller!.value.isInitialized) { // Ensure _controller is not null
    _controller!.startImageStream((CameraImage image) async {
      if (!mounted) return;

      // Convert image to Base64
      frameCounter++;
      if (frameCounter % 10 == 0) { 
        Uint8List bytes = image.planes[0].bytes;
        String base64Image = base64Encode(bytes);

        // Send frame to Flask
        debugPrint("Frame #$frameCounter captured, size: ${bytes.length} bytes");
        if (channel.closeCode == null) {
          debugPrint("Sending frame #$frameCounter to WebSocket...");
          channel.sink.add(jsonEncode({'image': base64Image}));
        } else {
          debugPrint("WebSocket is closed. Reconnecting...");
          channel = IOWebSocketChannel.connect('wss://trainez.onrender.com/socket.io/?EIO=4&transport=websocketm');
        }
        
      }
    });
  } else {
    debugPrint("CameraController is not initialized yet.");
  }
}


  Future<void> switchCamera() async {
    if (cameras == null || cameras!.isEmpty) return;

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    await _controller?.dispose();
    setState(() {
      _isCameraInitialized = false;
    });
    initializeCamera(selectedCameraIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CameraPreview(_controller!),
                Text(feedback, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: FloatingActionButton(
                    onPressed: switchCamera,
                    child: Icon(Icons.switch_camera),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}