import 'package:bucketlist/add_bucket_list.dart';
import 'package:bucketlist/view_item.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  bool isError = false;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://flutterapitesting123-default-rtdb.firebaseio.com/bucketlist.json");

      response.data is List
          ? bucketListData = response.data
          : bucketListData = [];
      isLoading = false;
      isError = false;
      setState(() {});
    } catch (exception) {
      isLoading = false;
      isError = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning),
          Text("Error getting bucket list data."),
          ElevatedButton(onPressed: getData, child: Text("Try Again"))
        ],
      ),
    );
  }

  Widget listDataWidget() {
    return ListView.builder(
      itemCount: bucketListData.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: (bucketListData[index] is Map)
              ? ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ViewItem(
                            title: bucketListData[index]['item'] ?? "",
                            image: bucketListData[index]['image'] ?? "",
                            index: index,
                          );
                        },
                      ),
                    ).then((value) {
                      getData();
                    });
                  },
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage(bucketListData[index]?['image'] ?? ""),
                  ),
                  title: Text(bucketListData[index]?['item'] ?? ""),
                  trailing:
                      Text(bucketListData[index]?['cost'].toString() ?? ""),
                )
              : SizedBox(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddBucketList();
          }));
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Bucket List"),
        actions: [
          InkWell(
            onTap: getData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isError
                ? errorWidget()
                : bucketListData.isEmpty
                    ? Center(child: Text("You don't have bucket list."))
                    : listDataWidget(),
      ),
    );
  }
}
