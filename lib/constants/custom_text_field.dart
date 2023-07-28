import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType textInputTypee;
  final bool isPassword;
  final String hinttextt;
  TextEditingController? controller;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  void Function(String)? onChanged;
   CustomTextField({Key? key, required this.hinttextt,required this.isPassword,required this.textInputTypee, this.controller,this.validator,this.suffixIcon,this.onChanged}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:onChanged ,
      validator:validator ,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller:controller ,
              keyboardType:textInputTypee,
              obscureText: isPassword,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                hintText: hinttextt,
                // to delete border
                enabledBorder:OutlineInputBorder(borderSide:Divider.createBorderSide(context), ) ,
                // عند الضغط عليه لون الحدود سيتغير
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  
                ),
                // لتغيير لون الحقل
               // fillColor: Colors.amber,
               // filled:true,
                // لعمل حدود بين التيكست والحدود الداخلية
                contentPadding: EdgeInsets.all(8),
              ),
    );
  }
}