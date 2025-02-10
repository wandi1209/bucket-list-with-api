import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketList extends StatefulWidget {
  int newIndex;
  AddBucketList({super.key, required this.newIndex});

  @override
  State<AddBucketList> createState() => _AddBucketListState();
}

class _AddBucketListState extends State<AddBucketList> {
  TextEditingController nameText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imageURL = TextEditingController();
  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "item": nameText.text,
        "cost": costText.text,
        "image": imageURL.text,
        "complete": false
      };
      Response response = await Dio().patch(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
          data: data);
      Navigator.pop(context, "refresh");
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bucket List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameText,
              decoration: InputDecoration(label: Text("Name Bucket List")),
            ),
            SizedBox(height: 20),
            TextField(
              controller: costText,
              decoration: InputDecoration(label: Text("Estimated Cost")),
            ),
            SizedBox(height: 20),
            TextField(
              controller: imageURL,
              decoration: InputDecoration(label: Text("Image URL")),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: addData, child: Text("Submit"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
