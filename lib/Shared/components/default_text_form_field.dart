import 'package:cinemax/Shared/constants.dart';
import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType input,
  Function(String)? onFieldSubmitted,
  Function(String)? onChanged,
  Function()? onTap,
  bool isObscure = false,
  FormFieldValidator<String>? onValidator,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function()? onSuffix,
  bool isClickable = true,
}) =>
    TextFormField(
      cursorColor: primaryColor,
      controller: controller,
      keyboardType: input,
      obscureText: isObscure,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: onValidator,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: primaryColor),
        ),
        prefixIcon: Icon(prefix, color: Colors.grey),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: onSuffix,
                icon: Icon(suffix, color: Colors.grey),
              )
            : null,
      ),
    );
