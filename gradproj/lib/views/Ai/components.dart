import 'package:dio/dio.dart';
import 'package:flutter_web_file_selector/flutter_web_file_selector.dart';

Response? response;
bool isLoading = false;
bool isGenerating = false;
Map<String, int> fileTypeCountMap = {};
bool isPdfRead = false;
XFile? pickedFileBytes;
bool isPicked = false;
bool isGenerated = false;
