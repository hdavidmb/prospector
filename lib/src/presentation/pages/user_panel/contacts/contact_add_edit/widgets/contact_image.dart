import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  final double size;
  final String? contactPhoto;
  final File? pickedImage;
  const ContactImage({
    Key? key,
    required this.size,
    this.contactPhoto,
    this.pickedImage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        color: Colors.white60,
        child: pickedImage == null
            ? (contactPhoto == null || contactPhoto!.isEmpty)
                ? Image(
                    image: const AssetImage(
                        'assets/images/defaultContactImage.jpg'),
                    height: size,
                    width: size,
                    fit: BoxFit.cover,
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: size,
                    width: size,
                    imageUrl: contactPhoto!,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
            : Image(
                image: FileImage(pickedImage!),
                height: size,
                width: size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
