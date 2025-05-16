import 'dart:io';

import 'package:client_side/core/theme/app_pallete.dart';
import 'package:client_side/core/utils.dart';
import 'package:client_side/core/widgets/custom_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final songController = TextEditingController();
  final artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  @override
  void dispose() {
    songController.dispose();
    artistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Song'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        ))
                    : DottedBorder(
                        dashPattern: [4, 10],
                        color: Pallete.borderColor,
                        radius: Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        borderType: BorderType.RRect,
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select the thumbnail for your song',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomField(
                hintText: 'Pick a song',
                controller: null,
                readOnly: true,
                onTap: () {
                  selectAudio();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                hintText: 'Artist',
                controller: artistController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomField(
                hintText: 'Song Name',
                controller: songController,
              ),
              const SizedBox(
                height: 20,
              ),
              ColorPicker(
                  pickersEnabled: {
                    ColorPickerType.wheel: true,
                  },
                  color: selectedColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      selectedColor = color;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
