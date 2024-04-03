import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final dynamic cloudUrl;
  final String displayPic;
  final String firstName;
  final double initialsSize;

  const ProfileImage({
    required this.cloudUrl,
    required this.displayPic,
    required this.firstName,
    required this.initialsSize,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ), // Add black border
          ),
          child: CircleAvatar(
            radius: widget.initialsSize,
            backgroundColor: Colors.transparent,
            backgroundImage: widget.displayPic.isNotEmpty
                ? NetworkImage('${widget.cloudUrl}${widget.displayPic}')
                : null, // Set to null if image data is not present
            child: widget.displayPic.isEmpty
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Text(
                        widget.firstName.isNotEmpty
                            ? widget.firstName[0].toUpperCase()
                            : '',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 6, 65, 113),
                          fontSize: widget.initialsSize,
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        )
      ],
    );
  }
}
