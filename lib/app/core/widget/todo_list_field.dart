import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final IconButton? suffixIconButton;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;

  const TodoListField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.focusNode,
  }) : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com suffixIconButton');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      inputFormatters: [
        UpperCaseTextFormatter(), // Utiliza o UpperCaseTextFormatter
        //CapitalizeWordsTextFormatter(), // Utiliza o CapitalizeWordsTextFormatter
        //CapitalizeFirstLetterTextFormatter(), // Utiliza o CapitalizeFirstLetterTextFormatter
      ],
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        isDense: true,
        suffixIcon: suffixIconButton ??
            (obscureText == true
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      TodoListIcons.eye,
                      size: 15,
                    ),
                  )
                : null),
      ),
      obscureText: obscureText,
    );
  }
}

// Responável em deixar todas as letras maísculas.
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

// Classe auxiliar para converter a primeira letra de cada palavra em maiúscula
class CapitalizeWordsTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: capitalizeWords(newValue.text));
  }

  String capitalizeWords(String input) {
    if (input.isEmpty) {
      return input;
    }

    // Divide o texto em palavras
    List<String> words = input.split(' ');

    // Capitaliza a primeira letra de cada palavra
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
      }
    }

    // Junta as palavras novamente em uma única string
    return words.join(' ');
  }
}

// Classe auxiliar para converter apenas a primeira letra da primeira palavra em maiúscula
class CapitalizeFirstLetterTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: capitalizeFirstLetter(newValue.text));
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }

    // Divide o texto em palavras
    List<String> words = input.split(' ');

    // Capitaliza apenas a primeira letra da primeira palavra
    if (words.isNotEmpty && words[0].isNotEmpty) {
      words[0] = '${words[0][0].toUpperCase()}${words[0].substring(1)}';
    }

    // Junta as palavras novamente em uma única string
    return words.join(' ');
  }
}
