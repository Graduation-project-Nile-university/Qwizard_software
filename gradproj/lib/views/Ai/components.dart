import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

Response? response;
bool isLoading = false;
bool isGenerating = false;
Map<String, int> fileTypeCountMap = {};
bool isPdfRead = false;
FilePickerResult? pickedFileBytes;
bool isPicked = false;
bool isGenerated = false;
