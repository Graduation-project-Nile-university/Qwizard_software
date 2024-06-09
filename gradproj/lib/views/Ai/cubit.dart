import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradproj/views/Ai/states.dart';

class LLMModelCubit extends Cubit<LLMStates> {
  LLMModelCubit() : super(InitState());
  static LLMModelCubit GET(context) => BlocProvider.of(context);

  Future<void> pickFile() async {
    Uint8List? pickedFileBytes;
    String? _fileName;
    int? _fileSize;
    bool isLoading = false;

    print("HERE");
    var result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    print(result);

    if (result != null) {
      pickedFileBytes = result.files.first.bytes;
      _fileName = result.files.first.name;
      _fileSize = result.files.first.size;
    }
  }
}
