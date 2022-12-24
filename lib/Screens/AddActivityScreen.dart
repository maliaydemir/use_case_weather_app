import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_case_weather_app/Models/Activity.dart';
import 'package:use_case_weather_app/Providers/ActivityProvider.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({Key? key}) : super(key: key);

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
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
        title: const Text('Add Activity'),
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
                            save();
                          }
                        },
                        shape: const StadiumBorder(),
                        color: Colors.blue,
                        child: const Text(
                          'Save',
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

  Future<void> save() async {
    var activity = Activity();
    activity.title = titleC.text.isNotEmpty ? titleC.text : null;
    activity.description =
        descriptionC.text.isNotEmpty ? descriptionC.text : null;
    activity.category = categoryC.text.isNotEmpty ? categoryC.text : null;
    activity.city = cityC.text.isNotEmpty ? cityC.text : null;
    activity.venue = venueC.text.isNotEmpty ? venueC.text : null;
    activity.date = dateC.text.isNotEmpty ? DateTime.parse(dateC.text) : null;
    await context.read<ActivityProvider>().addActivity(activity);
    Navigator.pop(context,true);
  }
}
