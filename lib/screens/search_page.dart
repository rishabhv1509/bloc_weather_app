import 'package:flutter/material.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/services/size_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff324098),
      appBar: AppBar(
        title: Text('Please search your city here'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _searchController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              // SizedBox(width: 30.toWidth),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.bloc<WeatherBloc>()
                    ..add(WeatherFetchedByCity(city: _searchController.text));
                  _searchController.clear();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.white, fontSize: 30.toFont),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
