import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

import 'package:todo_app/components/base_text_field.dart';
import 'package:todo_app/components/to_do_item.dart';
import 'package:todo_app/model/to_do.dart';

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
  final LocalStorage storage = LocalStorage('todo_app');
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabControler = TabController(vsync: this, length: 3);
    getData();
  }

  _saveToStorage() {
    storage.setItem('todos', ToDoModel.toJSONEncodableList(listItem));
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ...tabPage(filterList(listItem, tab))
              ],
            );
          }).toList(),
        ),
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
                  time: DateTime.now()),
              isSave: true, onSaveData: (data) {
            listItem.add(data);
            _saveToStorage();
            getData();
          });
        },
        child: const Icon(Icons.add));
  }

  AppBar appBarApp() {
    return AppBar(
      actions: const [Icon(Icons.notifications), SizedBox(width: 15)],
      title: baseTextField(
          onChanged: (value) {},
          controller: searchController,
          isOutline: true,
          hintText: 'Search',
          icon: const Icon(Icons.search)),
      bottom: const TabBar(
        tabs: tabs,
      ),
    );
  }

  void getData() {
    setState(() {
      var items = storage.getItem('todos');

      listItem = items == null
          ? []
          : List<ToDoModel>.from((items as List).map(
              (item) => ToDoModel(
                title: item['title'],
                id: item['id'],
                content: item['content'],
                time: stringToDate(item['time']),
                typeColor: item['typeColor'],
              ),
            ));
    });
  }

  List<ToDoModel> filterList(List<ToDoModel> listItem, Tab tab) {
    return listItem
        .where((element) => element.title.contains(searchController.text))
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
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'All'),
  Tab(text: 'Today'),
  Tab(text: 'UpComing'),
];
