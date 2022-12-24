import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_case_weather_app/Models/Activity.dart';

import '../Providers/ActivityProvider.dart';

class UpdateActivityScreen extends StatefulWidget {
  final Activity activity;

  const UpdateActivityScreen({Key? key, required this.activity})
      : super(key: key);

  @override
  State<UpdateActivityScreen> createState() => _UpdateActivityScreenState();
}

class _UpdateActivityScreenState extends State<UpdateActivityScreen> {
  var idC = TextEditingController();
  var titleC = TextEditingController();
  var descriptionC = TextEditingController();
  var categoryC = TextEditingController();
  var cityC = TextEditingController();
  var venueC = TextEditingController();
  var dateC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Activity'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text('Id'),
                      TextFormField(
                        controller: idC,
                        enabled: false,
                        decoration: const InputDecoration(
                            hintText: 'Id',
                            fillColor: Colors.grey,
                            filled: true),
                      ),
                      TextFormField(
                        controller: titleC,
                        decoration: const InputDecoration(hintText: 'Title'),
                        validator: (val) {
                          print(val);
                          if (val == null || val.isEmpty) {
                            return 'Title cannot be null';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: dateC,
                        decoration: const InputDecoration(hintText: 'Date'),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now()
                                      .add(const Duration(days: -999)),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 999)))
                              .then((value) {
                            dateC.text = value?.toString() ?? '';
                          });
                        },
                      ),
                      TextFormField(
                        controller: descriptionC,
                        decoration:
                            const InputDecoration(hintText: 'Description'),
                      ),
                      TextFormField(
                        controller: categoryC,
                        decoration: const InputDecoration(hintText: 'Category'),
                      ),
                      TextFormField(
                        controller: cityC,
                        decoration: const InputDecoration(hintText: 'City'),
                      ),
                      TextFormField(
                        controller: venueC,
                        decoration: const InputDecoration(hintText: 'Venue'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          var isValid = _formKey.currentState!.validate();
                          if (isValid) {
                            update();
                          }
                        },
                        shape: const StadiumBorder(),
                        color: Colors.blue,
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    idC.text = widget.activity.id ?? '';
    titleC.text = widget.activity.title ?? '';
    descriptionC.text = widget.activity.description ?? '';
    cityC.text = widget.activity.city ?? '';
    categoryC.text = widget.activity.category ?? '';
    venueC.text = widget.activity.venue ?? '';
    dateC.text = widget.activity.date?.toString() ?? '';
    super.initState();
  }

  Future<void> update() async {
    widget.activity.title = titleC.text.isNotEmpty ? titleC.text : null;
    widget.activity.description =
        descriptionC.text.isNotEmpty ? descriptionC.text : null;
    widget.activity.category =
        categoryC.text.isNotEmpty ? categoryC.text : null;
    widget.activity.city = cityC.text.isNotEmpty ? cityC.text : null;
    widget.activity.venue = venueC.text.isNotEmpty ? venueC.text : null;
    widget.activity.date =
        dateC.text.isNotEmpty ? DateTime.parse(dateC.text) : null;
    await context.read<ActivityProvider>().updateActivity(widget.activity);
    Navigator.pop(context, true);
  }
}
