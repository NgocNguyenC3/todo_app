import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:todo_app/components/base_text_field.dart';
import 'package:todo_app/model/tag.dart';
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
                tabPage(context)
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Column tabPage(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorList[model.typeColor].withOpacity(0.5)),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: text14,
                  ),
                  Text(
                    'Time:${model.time}',
                    style: text14.copyWith(color: Colors.green),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Wrap(
                    spacing: 5,
                    children: [
                      ...model.tags.map((e) => Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                color:
                                    colorList[model.typeColor].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(2)),
                            child: Text(
                              e.tag,
                              style: text12.copyWith(color: Colors.white),
                            ),
                          ))
                    ],
                  )
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.delete,
                color: Colors.red,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Divider(
            color: Colors.black,
          ),
        )
      ],
    );
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
    tags: [
      TagModel(tag: '#School'),
      TagModel(tag: '#Math'),
    ],
    time: '10:00 AM',
    title: 'Người muốn kêu ai',
    typeColor: 0);
