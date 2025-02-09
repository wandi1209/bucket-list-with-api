import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class ViewItem extends StatefulWidget {
  String title;
  String image;
  int index;
  ViewItem({
    super.key,
    required this.title,
    required this.image,
    required this.index,
  });

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response response = await Dio().delete(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
      Navigator.pop(context, "refresh");
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> markAsCoomplete() async {
    try {
      Map<String, dynamic> data = {"complete": true};
      Response response = await Dio().patch(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json",
          data: data);
      Navigator.pop(context, "refresh");
      // ignore: empty_catches
    } catch (e) {}
  }

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
                        InkWell(onTap: deleteData, child: Text("Confirm")),
                      ],
                    );
                  },
                );
              }
              if (value == 2) {
                markAsCoomplete();
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
