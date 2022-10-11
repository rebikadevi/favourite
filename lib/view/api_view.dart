import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data_model.dart';
import '../state/app_state.dart';
import '../util/data_util.dart';

class ApiView extends StatelessWidget {
  const ApiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AppState>(
      builder: (context, provider, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(CupertinoIcons.refresh_thick),
            onPressed: () async {
              List<DataModel> data = await DataUtil().getData();
              provider.updateDataModel(data);
            },
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(220, 8, 8, 195),
            title: Row(
              children: [
                IconButton(
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Favorite",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    CupertinoIcons.list_bullet_indent,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Color.fromARGB(220, 8, 8, 195),
            currentIndex: 1,
            type: BottomNavigationBarType.fixed,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.circle_filled,
                label: 'Home',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.heart_fill,
                label: 'favorite',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.plus_circle_fill,
                label: 'post',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.book,
                label: 'inbox',
              ),
              _bottomNavigationBarItem(
                icon: CupertinoIcons.person,
                label: 'Account',
              ),
            ],
          ),
          body: Container(
            child: Container(
              height: size.height -
                  const CupertinoNavigationBar().preferredSize.height,
              width: size.width,
              child: provider.dataList.isEmpty
                  ? Center(
                      child: const Text(
                      "There is No data",
                      style: TextStyle(fontSize: 25),
                    ))
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(
                              top: 20, right: 20, bottom: 15, left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(15),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),

                          child: Column(children: [
                            Row(
                              children: [
                                Image.network(
                                  "https://picsum.photos/300/300?random=${provider.dataList[index].id}",
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${provider.dataList[index].title}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "${provider.dataList[index].description}",
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      Row(
                                        //  mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons.money_dollar,
                                              color: Colors.black38,
                                              size: 20,
                                            ),
                                            onPressed: () {},
                                          ),
                                          Text(
                                            "${provider.dataList[index].price}",
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(
                                              CupertinoIcons.heart_fill,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {},
                                          ),
                                          Text(
                                            "saved on",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // child: ListTile(
                                  //   title: Text("${provider.dataList[index].title}"),
                                ),
                              ],
                            ),
                          ] //   //leading: Text("${provider.dataList[index].id}"),
                              ), // ),
                        );
                      },
                      itemCount: provider.dataList.length,
                    ),
            ),
          ),
        );
      },
    );
  }
}

_bottomNavigationBarItem({IconData? icon, required String label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
