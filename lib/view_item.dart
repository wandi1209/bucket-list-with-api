import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewItem extends StatefulWidget {
  String title;
  String image;
  ViewItem({super.key, required this.title, required this.image});

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 1) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Are you sure to delete?",
                      ),
                      actions: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel")),
                        Text("Confirm"),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 2,
                  child: Text("Mark as complete"),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text("Delete"),
                ),
              ];
            },
          ),
        ],
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.image),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
