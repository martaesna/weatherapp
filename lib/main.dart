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

  void _APIRequest() async {
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
    _APIRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[
            Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/gifBack.gif'),
                  fit: BoxFit.cover),
            ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                      width: 0,
                    ),
                    Text(
                      '$_city',
                      style: const TextStyle(fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        color : Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 0,
                    ),
                    Text(
                      '$_temp\º',
                      style: const TextStyle(fontSize: 120.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                      width: 0,
                    ),
                    Text(
                      '$_description',
                      style: const TextStyle(fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 20.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
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
                          style: const TextStyle(fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 20.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 20.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                          height: 0,
                        ),
                        Text(
                          'Min. $_minTemp\º',
                          style: const TextStyle(fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 20.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 20.0,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child:
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _forecasts.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = _forecasts[index];
                              var tempMin = item.tempMin!.celsius!.toStringAsFixed(1);
                              var day = item.date!.day;
                              var month = item.date!.month;

                              var hour = item.date!.hour;
                              var tempMax = item.tempMax!.celsius!.toStringAsFixed(1);
                              return Container(
                                padding: const EdgeInsets.all(1.0),
                                child: Material(
                                  elevation: 4.0,
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.grey.withOpacity(0.2),
                                  child: Center(
                                    heightFactor: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        const Expanded(child: SizedBox(width: 40,
                                          height: 0,)),
                                        Text(
                                          '$day\/$month',
                                          style: const TextStyle(fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const Expanded(child: SizedBox(width: 30,
                                          height: 0,)),
                                        Text(
                                          '$hour\h',
                                          style: const TextStyle(fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),                              ),
                                        const Expanded(child: SizedBox(width: 30,
                                          height: 0,)),
                                        Text(
                                          '$tempMax\º - $tempMin\º',
                                          style: const TextStyle(fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),                              ),
                                        const Expanded(child: SizedBox(width: 40,
                                          height: 0,)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                    )
                  ],
                ),
              ),
          ),
          ]
        ),
    );
  }
}
