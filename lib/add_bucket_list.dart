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
        "cost": int.tryParse(costText.text),
        "image": imageURL.text,
        "complete": false
      };
      await Dio().patch(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json",
          data: data);
      Navigator.pop(context, "refresh");
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Bucket List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: addForm,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "Must be more than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This must not be empty.";
                  }
                  return null;
                },
                controller: nameText,
                decoration: InputDecoration(label: Text("Name Bucket List")),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This must not be empty.";
                  }

                  return null;
                },
                controller: costText,
                decoration: InputDecoration(label: Text("Estimated Cost")),
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "Must be more than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This must not be empty.";
                  }
                  return null;
                },
                controller: imageURL,
                decoration: InputDecoration(label: Text("Image URL")),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (addForm.currentState!.validate()) {
                              addData();
                            }
                          },
                          child: Text("Submit"))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
