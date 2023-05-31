bool validEmail(email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool validPassword(password) {
  return password.length > 4;
}

bool validName(names) {
  return RegExp(r"/^[a-z ,.'-]+$/i").hasMatch(names);
}

bool validPhoneNumber(number) {
  return number.length == 9; 
}
