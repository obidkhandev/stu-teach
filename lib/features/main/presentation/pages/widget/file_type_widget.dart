import 'package:flutter/material.dart';
import 'package:stu_teach/features/common/widget/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class FileTypeWidget extends StatelessWidget {
  final String url;
  final String type;

  const FileTypeWidget({Key? key, required this.url, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Viewer"),
      ),
      body: Center(
        child: CustomButton(
          onTap: () => _openFile(url, type),
          text: 'Open $type',
          // child: Text(""),
        ),
      ),
    );
  }

  void _openFile(String url, String type) async {
    // Check if the URL can be launched
    if (await canLaunchUrl(Uri.parse(url))) {
      // Launch the URL based on the file type
      switch (type) {
        case 'pdf':
        case 'mp4':
        case 'mp3':
        case 'png':
        case 'doc':
          await launchUrl(Uri.parse(url));
          break;
        default:
          print("Unsupported file type: $type");
          // Optionally show a dialog or a message to the user
          break;
      }
    } else {
      throw 'Could not launch $url';
    }
  }
}
