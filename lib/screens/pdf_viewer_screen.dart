import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'package:path_provider/path_provider.dart'; // For getTemporaryDirectory
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart'; // Syncfusion PDF viewer package

class PDFViewerScreen extends StatefulWidget {
  final String path;

  PDFViewerScreen({required this.path});

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? _filePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Load the PDF file from assets
      final ByteData data = await rootBundle.load(widget.path);
      final Uint8List bytes = data.buffer.asUint8List();

      // Get the temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/temp.pdf');

      // Write the bytes to a temporary file
      await file.writeAsBytes(bytes);

      // Update the state to indicate the PDF is loaded
      setState(() {
        _filePath = file.path;
        _isLoading = false;
      });

      // Debug statement
      print('PDF loaded successfully');
    } catch (e) {
      print('Error loading PDF: $e');
      // Optionally, handle errors, for example, by showing an error message
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : _filePath == null
              ? Center(child: Text('Failed to load PDF')) // Handle failure to load PDF
              : SfPdfViewer.file(
                  File(_filePath!), // Display the PDF from file
                ),
    );
  }
}
