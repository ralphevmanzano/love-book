import 'package:love_book/core/viewmodels/base_model.dart';

class ProfileModel extends BaseModel {
  bool _isEditing = false;
  bool get isEditing => _isEditing;
  
  void toggleEditing() {
    _isEditing = !_isEditing;
    print('Toggle: $_isEditing');
    notifyListeners();
  }
  
}