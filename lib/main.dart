import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _temp = 18;
  String _city = 'Barcelona';
  int _minTemp = 10;
  int _maxTemp = 22;
  String _description = 'Clouds';
  ListView _listView = new ListView();
  List<String> _entries = <String>['A', 'B', 'C'];
  List<int> _colorCodes = <int>[600, 500, 100];
  List<Weather> _forecasts = <Weather>[];
  late WeatherFactory wf;

  void _incrementCounter() async {
    wf = WeatherFactory('6a408860302c1893ee3c25b9f9b1024e');
    Weather w = await wf.currentWeatherByCityName(_city);
    _forecasts = await wf.fiveDayForecastByCityName(_city);
    setState(() {
      _temp = (w.temperature!.celsius!).round();
      _minTemp = (w.tempMin!.celsius!).round();
      _maxTemp = (w.tempMax!.celsius!).round();
      _description = w.weatherDescription!;
    });
  }

  @override
  void initState() {
    _incrementCounter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 50,
            width: 0,
          ),
          Text(
            '$_city',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 20,
            width: 0,
          ),
          Text(
            '$_temp\º',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 20,
            width: 0,
          ),
          Text(
            '$_description',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 20,
            width: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Max. $_maxTemp\º',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                width: 20,
                height: 0,
              ),
              Text(
                'Min. $_minTemp\º',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _forecasts.length,
              itemBuilder: (BuildContext context, int index) {
                var item = _forecasts[index];
                var tempMin = item.tempMin!.celsius!.toStringAsFixed(1);
                var day = item.date!.day;
                var month = item.date!.month;

                var hour = item.date!.hour;
                var tempMax = item.tempMax!.celsius!.toStringAsFixed(1);
                print("hola");
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(child: SizedBox(width: 40,
                      height: 0,)),
                    Text(
                      '$day\/$month',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Expanded(child: SizedBox(width: 30,
                    height: 0,)),
                    Text(
                      '$hour\h',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Expanded(child: SizedBox(width: 30,
                    height: 0,)),
                    Text(
                      '$tempMax\º - $tempMin\º',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Expanded(child: SizedBox(width: 40,
                      height: 0,)),
                  ],
                );
              })
        ],
      ),
    ));
  }
}
