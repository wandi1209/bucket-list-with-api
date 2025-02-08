import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];

  Future<void> getData() async {
    try {
      Response response = await Dio().get(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;
      setState(() {});
    } catch (exception) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  Text("Cannot connect to the server. Try after few second!"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bucket List")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: getData,
            child: Text("Get Data"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(bucketListData[index]['image'] ?? ""),
                      ),
                      title: Text(bucketListData[index]['item'] ?? ""),
                      trailing:
                          Text(bucketListData[index]['cost'].toString() ?? ""),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
