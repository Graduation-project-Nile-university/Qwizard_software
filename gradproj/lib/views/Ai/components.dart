import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

bool isLoading = false;
bool isGenerating = false;
Map<String, int> fileTypeCountMap = {};
bool isPdfRead = false;
FilePickerResult? pickedFileBytes;
bool isPicked = false;
