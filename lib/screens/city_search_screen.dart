import 'package:flutter/material.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final TextEditingController _cityTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Search'),
      ),
      body: Form(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  controller: _cityTextController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a city',
                    hintText: 'Example: London',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pop(context, _cityTextController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
