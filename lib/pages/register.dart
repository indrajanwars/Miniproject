// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:miniproject/provider/authprovider.dart';
import 'package:miniproject/style.dart';
import 'package:miniproject/widget/custombutton.dart';
import 'package:miniproject/widget/customtextfield.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _namaLengkap = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _tanggalLahir = TextEditingController();
  String? _jenisKelamin;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  bool isPassword8c = true;
  bool isPasswordCapital = true;
  bool isPasswordConfirmed = true;

  bool get isRegistrationEnabled =>
      _confirmPassword.text.isNotEmpty &&
      _password.text.isNotEmpty &&
      _namaLengkap.text.isNotEmpty &&
      _username.text.isNotEmpty &&
      _email.text.isNotEmpty &&
      _jenisKelamin != null &&
      _tanggalLahir.text.isNotEmpty &&
      isPassword8c &&
      isPasswordCapital &&
      isPasswordConfirmed;

  late AuthProvider authProvider;

  @override
  void initState() {
    authProvider = AuthProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ListView(shrinkWrap: true, children: [
          Text("Daftar Akun Baru", style: Styles.text32),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
              label: "Nama Lengkap",
              controller: _namaLengkap,
              hint: "Nama Lengkap"),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
              label: "Username", controller: _username, hint: "Username"),
          SizedBox(
            height: 10,
          ),
          CustomTextField(label: "Email", controller: _email, hint: "Email"),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextField(
                  label: "Tanggal Lahir",
                  hint: "YYYY-MM-DD",
                  controller: _tanggalLahir,
                  readOnly: true,
                  suffixIcon: IconButton(
                    onPressed: () {
                      SelectDate(context);
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jenis Kelamin",
                    style: Styles.labelTextField,
                  ),
                  DropdownButtonFormField<String>(
                    value: _jenisKelamin,
                    onChanged: (value) {
                      setState(() {
                        _jenisKelamin = value!;
                      });
                    },
                    items: ['Laki-Laki', 'Perempuan'].map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: "Pilih",
                        filled: true,
                        fillColor: Styles.bgtextField),
                  ),
                ],
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextField(
            label: "Password",
            hint: "Masukkan Password",
            controller: _password,
            onChanged: (value) {
              setState(() {
                checkPassword(value);
              });
            },
            obscureText: obscurePassword,
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Styles.lightgrey,
                ),
                onPressed: () {
                  setState(() {
                    obscurePassword = !obscurePassword;
                  });
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              if (isPassword8c == false)
                Expanded(
                    child: RichText(
                  text: TextSpan(style: Styles.text10, children: [
                    TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: "Minimal 8 Karakter",
                        style: TextStyle(color: Colors.red)),
                  ]),
                )),
              if (isPasswordCapital == false)
                Expanded(
                  child: RichText(
                      text: TextSpan(style: Styles.text10, children: [
                    TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                    TextSpan(
                        text: "Minimal 1 Huruf Kapital",
                        style: TextStyle(color: Colors.red)),
                  ])),
                )
            ],
          ),
          CustomTextField(
            label: "Confirm Password",
            hint: "Masukkan Password Kembali",
            controller: _confirmPassword,
            onChanged: (value) {
              setState(() {
                if (_password.text != value) {
                  setState(() {
                    isPasswordConfirmed = false;
                  });
                } else {
                  setState(() {
                    isPasswordConfirmed = true;
                    print("$isPasswordConfirmed");
                  });
                }
              });
            },
            obscureText: obscureConfirmPassword,
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Styles.lightgrey,
                ),
                onPressed: () {
                  setState(() {
                    obscureConfirmPassword = !obscureConfirmPassword;
                  });
                }),
          ),
          if (isPasswordConfirmed == false)
            RichText(
              text: TextSpan(style: Styles.text10, children: [
                TextSpan(text: "*", style: TextStyle(color: Colors.red)),
                TextSpan(text: "Password Tidak Sama"),
              ]),
            ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
              label: "Daftar",
              onPressed: () {
                print(
                    "$isPassword8c, $isPasswordCapital, $isPasswordConfirmed");
                print(_password.text);
                onRegister(context);
              })
        ]),
      ),
    );
  }

  Future<void> SelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _tanggalLahir) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(picked);
      setState(() {
        print("a");
        setState(() {
          _tanggalLahir.text = formattedDate;
        });
      });
    }
  }

  checkPassword(String password) {
    isPassword8c = password.length >= 8;
    isPasswordCapital = password.contains(RegExp(r'[A-z]'));
  }

  onRegister(BuildContext context) async {
    if (isRegistrationEnabled) {
      dynamic result = await authProvider.register(
          _email.text,
          _username.text,
          _jenisKelamin!,
          _tanggalLahir.text,
          _password.text,
          _namaLengkap.text);
      if (result != null && result["message"] == "Success") {
        Navigator.pop(context);
      } else if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed"),
          duration: Duration(seconds: 3),
        ));
      } else if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(result["message"]),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("All Columns Must be Filled In."),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
