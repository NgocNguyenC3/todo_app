import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_app/components/base_text_field.dart';
import 'package:todo_app/components/to_do_item.dart';
import 'package:todo_app/model/to_do.dart';
import 'package:todo_app/services/notification.dart';

class MainBodyApp extends StatefulWidget {
  const MainBodyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBodyApp> createState() => _MainBodyAppState();
}

class _MainBodyAppState extends State<MainBodyApp>
    with SingleTickerProviderStateMixin {
  late TabController tabControler;
  List<ToDoModel> listItem = [];
  final TextEditingController searchController = TextEditingController();

  late SharedPreferences prefs;
  late final LocalNotificationService service;

  @override
  void initState() {
    super.initState();
    tabControler = TabController(vsync: this, length: 3);
    service = LocalNotificationService();
    service.intialize();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: appBarApp(),
        floatingActionButton: floatingButton(context),
        body: TabBarView(
          children: tabs.map((Tab tab) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ...tabPage(filterList(listItem, tab))
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  AppBar appBarApp() {
    return AppBar(
      title: baseTextField(
          onChanged: (value) {
            setState(() {});
          },
          controller: searchController,
          isOutline: true,
          hintText: 'Search',
          icon: const Icon(Icons.search)),
      bottom: const TabBar(
        tabs: tabs,
      ),
    );
  }

  List<Widget> tabPage(List<ToDoModel> list) {
    return list
        .map((e) => Column(
              children: [
                ToDoItem(
                    mainModel: e,
                    onDeleteData: (value) {
                      listItem.remove(value);
                      setState(() {});
                      _saveToStorage();
                      getData();
                    },
                    onSaveData: (value) {
                      listItem[listItem.indexOf(e)] = value;
                      _saveToStorage();
                      getData();
                    }),
                const SizedBox(
                  height: 5,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Divider(),
                )
              ],
            ))
        .toList();
  }

  FloatingActionButton floatingButton(context) {
    return FloatingActionButton(
        onPressed: () {
          hanldeClickItem(
              context,
              ToDoModel(
                id: listItem.length,
                title: '',
                content: '',
                typeColor: 1,
                time: DateTime.now(),
              ),
              isSave: true, onSaveData: (data) {
            listItem.add(data);
            _saveToStorage();
            getData();
          });
        },
        child: const Icon(Icons.add));
  }

  List<ToDoModel> filterList(List<ToDoModel> listItem, Tab tab) {
    return listItem
        .where((element) => element.title
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .where((element) {
      String date = formatDay(DateTime.now());
      if (tab.text == 'Today') {
        return date == formatDay(element.time);
      }
      if (tab.text == 'UpComing') {
        return element.time.isAfter(DateTime.now());
      }
      return true;
    }).toList();
  }

  void _saveToStorage() {
    prefs.setString(
        'todos', jsonEncode(ToDoModel.toJSONEncodableList(listItem)));
  }

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      var items = prefs.getString('todos') != null
          ? jsonDecode(prefs.getString('todos')!)
          : null;

      listItem = items != null
          ? List<ToDoModel>.from((items as List).asMap().entries.map(
                (item) => ToDoModel(
                  title: item.value['title'],
                  id: item.key,
                  content: item.value['content'],
                  time: stringToDate(item.value['time']),
                  typeColor: item.value['typeColor'],
                ),
              ))
          : [];
      listItem.sort(((a, b) => a.time.isAfter(b.time) ? 0 : 1));
    });

    notificationData();
  }

  void notificationData() {
    for (var i in listItem) {
      service.showScheduledNotification(
          id: i.id, title: i.title, body: i.content, time: i.time);
    }
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'All'),
  Tab(text: 'Today'),
  Tab(text: 'UpComing'),
];
