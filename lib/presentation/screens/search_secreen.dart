import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathet_app_bloc/logic/cubits/weather/weather_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  static const String routName = '/search-screen';
  final _formKey = GlobalKey<FormState>();
  String? _city;

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(_city!);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build------------------->');
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search a City"),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<WeatherCubit, WeatherState>(
                  builder: (context, state) {
                    print('Blok builder $state');
                    return TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          labelText: 'Enter a City',
                          hintText: 'Enter a City'
                      ),
                      onSaved: (newValue) {
                        _city = newValue;
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return 'Place enter a city';
                        }
                      },
                    );
                  },
                ),

                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(onPressed: () {
                  _submit(context);
                }, child: const Text("GET WEATHER"))
              ],
            ),
          ),
        ));
  }
}
