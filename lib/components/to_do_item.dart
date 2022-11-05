// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/base_text_field.dart';
import 'package:todo_app/components/loading/loading_button.dart';
import 'package:todo_app/model/to_do.dart';

class ToDoItem extends StatefulWidget {
  ToDoModel mainModel;
  dynamic onSaveData;
  dynamic onDeleteData;
  ToDoItem({
    Key? key,
    required this.mainModel,
    required this.onSaveData,
    this.onDeleteData,
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mainModel.time.isBefore(DateTime.now()));
    return InkWell(
      onTap: () {
        hanldeClickItem(context, widget.mainModel,
            onSaveData: widget.onSaveData);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.mainModel.time.isAfter(DateTime.now())
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorList[widget.mainModel.typeColor]
                            .withOpacity(0.5)),
                  )
                : const SizedBox(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mainModel.title,
                  style: text14,
                ),
                const SizedBox(width: 10),
                Text(
                  'Time: ${formatDate(widget.mainModel.time)}',
                  style: text14.copyWith(
                      color: colorList[widget.mainModel.typeColor]
                          .withOpacity(0.5)),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                widget.onDeleteData(widget.mainModel);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
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

Future<dynamic> hanldeClickItem(BuildContext context, ToDoModel _model,
    {bool isSave = false, required onSaveData}) {
  TextEditingController controller = TextEditingController();
  TextEditingController titleController = TextEditingController();
  controller.text = _model.content;
  titleController.text = _model.title;

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)), //this right here
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => SizedBox(
              height: 250,
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
                        hintText: 'Title',
                        validator: (value) =>
                            (value == null || value.isEmpty) ? 'Empty' : null,
                        textStyle: text18.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                colorList[_model.typeColor].withOpacity(0.5)),
                        vertical: 0.0),
                    const SizedBox(
                      height: 10,
                    ),
                    baseTextField(
                        onChanged: (value) {},
                        controller: controller,
                        hintText: 'Content',
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
                            onTap: () {
                              dateTimePicked(
                                  context,
                                  cupertinoDateTimePicker((value) {
                                    setState(
                                      () => _model.time = value,
                                    );
                                  }, _model.time));
                            },
                            child: Text(
                              'Time: ${formatDate(_model.time)}',
                              style: text14.copyWith(
                                  color: colorList[_model.typeColor]
                                      .withOpacity(0.5)),
                            ),
                            borderColor:
                                colorList[_model.typeColor].withOpacity(0.5)),
                        boxContainer(
                            onTap: () {
                              setState(() {
                                _model.changedLevel();
                              });
                            },
                            child: Text(
                              'Level: ${level[_model.typeColor]}',
                              style: text14.copyWith(
                                  color: colorList[_model.typeColor]
                                      .withOpacity(0.5)),
                            ),
                            borderColor:
                                colorList[_model.typeColor].withOpacity(0.5)),
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
                            submit: () {
                              if (titleController.text.isEmpty) {
                                titleController.text = ' ';
                                titleController.text = '';
                                return;
                              }
                              _model.title = titleController.text;
                              _model.content = controller.text;
                              onSaveData(_model);
                              Navigator.of(context).pop();
                            },
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

dateTimePicked(BuildContext context, Widget child) async {
  showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          ));
}

Widget cupertinoDateTimePicker(onchanged, initTime) {
  return CupertinoDatePicker(
    initialDateTime: initTime ?? DateTime.now(),
    mode: CupertinoDatePickerMode.dateAndTime,
    use24hFormat: true,
    onDateTimeChanged: (DateTime newTime) {
      onchanged(newTime);
    },
  );
}

String formatDate(time) =>
    DateFormat('yyyy/MM/dd HH:mm').format(time).toString();

String formatDay(time) => DateFormat('yyyy/MM/dd').format(time).toString();

DateTime stringToDate(time) => DateFormat('yyyy/MM/dd HH:mm').parse(time);
