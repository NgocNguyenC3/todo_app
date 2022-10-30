import 'package:flutter/material.dart';

import 'package:todo_app/components/base_text_field.dart';
import 'package:todo_app/components/loading/loading_button.dart';
import 'package:todo_app/model/to_do.dart';

class ToDoItem extends StatefulWidget {
  ToDoModel mainModel;

  ToDoItem({
    Key? key,
    required this.mainModel,
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  TextEditingController controller = TextEditingController();
  TextEditingController titleController = TextEditingController();

  late ToDoModel model;

  @override
  void initState() {
    super.initState();

    model = widget.mainModel.cpy();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = model.content;
    titleController.text = model.title;
    return InkWell(
      onTap: () {
        hanldeClickItem(context);
      },
      child: SizedBox(
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
                  style: text14.copyWith(
                      color: colorList[model.typeColor].withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 5,
                ),
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
    );
  }

  Future<dynamic> hanldeClickItem(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => SizedBox(
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      baseTextField(
                          onChanged: (value) {},
                          controller: titleController,
                          maxLength: 50,
                          horizontal: 0.0,
                          textStyle: text18.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  colorList[model.typeColor].withOpacity(0.5)),
                          vertical: 0.0),
                      const SizedBox(
                        height: 10,
                      ),
                      baseTextField(
                          onChanged: (value) {},
                          controller: controller,
                          isOutline: true,
                          maxLines: 3),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          boxContainer(
                              child: Text(
                                'Time: ${model.time}',
                                style: text14.copyWith(
                                    color: colorList[model.typeColor]
                                        .withOpacity(0.5)),
                              ),
                              borderColor:
                                  colorList[model.typeColor].withOpacity(0.5)),
                          boxContainer(
                              onTap: () {
                                setState(() {
                                  model.changedLevel();
                                });
                              },
                              child: Text(
                                'Level: ${level[model.typeColor]}',
                                style: text14.copyWith(
                                    color: colorList[model.typeColor]
                                        .withOpacity(0.5)),
                              ),
                              borderColor:
                                  colorList[model.typeColor].withOpacity(0.5)),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 100,
                          child: LoadingButtonWidget(
                              height: 35,
                              submit: () {},
                              isLoading: false,
                              label: 'Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget boxContainer({required Widget child, color, borderColor, onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(color: borderColor ?? greyBorderColor),
          borderRadius: BorderRadius.circular(5)),
      child: child,
    ),
  );
}
