class Student {
  String _fullName;
  String _gender;
  String _doB;
  String _registrationNumber;
  String _rollNumber;
  String _imgUrl;
  String _class_;

  Student(this._fullName, this._imgUrl, this._gender, this._doB,
      this._registrationNumber, this._rollNumber, this._class_);

  String get fullName => _fullName;

  set fullName(String fullName) {
    _fullName = fullName;
  }

  String get gender => _gender;

  set gender(String gender) {
    _gender = gender;
  }

  String get doB => _doB;

  set doB(String doB) {
    _doB = doB;
  }

  String get registrationNumber => _registrationNumber;

  set registrationNumber(String registrationNumber) {
    _registrationNumber = registrationNumber;
  }

  String get rollNumber => _rollNumber;

  set rollNumber(String rollNumber) {
    _rollNumber = rollNumber;
  }

  String get imgUrl => _imgUrl;

  set imgUrl(String imgUrl) {
    _imgUrl = imgUrl;
  }

  String get class_ => _class_;

  set class_(String class_) {
    _class_ = class_;
  }
}
