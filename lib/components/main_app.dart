import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    tabControler = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: appBarApp(),
        floatingActionButton: floatingButton(),
        body: TabBarView(
          children: tabs.map((Tab tab) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ...tabPage([model])
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
                  mainModel: model,
                ),
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

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
        onPressed: handleAddEvent, child: const Icon(Icons.add));
  }

  AppBar appBarApp() {
    return AppBar(
      actions: const [Icon(Icons.notifications), SizedBox(width: 15)],
      title: baseTextField(
          onChanged: (value) {},
          controller: null,
          isOutline: true,
          hintText: 'Search',
          icon: const Icon(Icons.search)),
      bottom: const TabBar(
        tabs: tabs,
      ),
    );
  }

  void handleAddEvent() {}
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'All'),
  Tab(text: 'Today'),
  Tab(text: 'UpComing'),
];

ToDoModel model = ToDoModel(
    content: 'Vì quá ngu si',
    time: '10:00 AM',
    title: 'Người muốn kêu ai',
    typeColor: 0);
