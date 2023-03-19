import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key, required this.onImagePick})
      : super(key: key);

  final void Function(File image) onImagePick;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  // Estado que vai mudar sempre que selecionar uma img
  File? _image;

  // Vai possuir a logica para obter um arq
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              const Text('Adicionar imagem'),
            ],
          ),
          onPressed: _pickImage,
        )
      ],
    );
  }

  //Metodo que vai selecionar a imagem
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    // Pega a imagem
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      //Diminui a qualidade da imagem
      // Para não ocupar muito espaço no Firebase
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      // Cria um arq a partir da imagem selecionada
      setState(() {
        _image = File(pickedImage.path);
      });

      //Notifica o comp pai que a img foi selecionada
      widget.onImagePick(_image!);
    }
  }
}