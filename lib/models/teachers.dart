class Teacher {
  String _fullName;
  String _gender;
  String _doB;
  String _education;
  String _lastDegree;
  String _cnic;
  String _imgUrl;

  Teacher(this._fullName, this._imgUrl, this._gender, this._doB,
      this._education, this._lastDegree, this._cnic);



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

  String get education => _education;

  set education(String education) {
    _education = education;
  }

  String get lastDegree => _lastDegree;

  set lastDegree(String lastDegree) {
    _lastDegree = lastDegree;
  }

  String get cnic => _cnic;

  set cnic(String cnic) {
    _cnic = cnic;
  }

  String get imgUrl => _imgUrl;

  set imgUrl(String imgUrl) {
    _imgUrl = imgUrl;
  }

  
}
