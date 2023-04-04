import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

 //cette classe sert à définir la page de l'application mobile qui affiche la liste de villes. 
 //Elle étend la classe 'StatefulWidget' pour avoir un état mutable interne et permet de créer 
 //l'état interne de la page à l'aide de la méthode createState().

class Villes extends StatefulWidget {
  Villes({Key? key}) : super(key: key);
  @override
  _VillesState createState() => _VillesState();
}
 
 //cette classe sert à définir l'état interne de la page de l'application mobile 
 //qui affiche une liste de villes. Elle étend la classe 'State<Villes>' pour avoir un état 
 //mutable interne et permet d'initialiser l'état interne de la page à l'aide de la méthode 'initState()'.

class _VillesState extends State<Villes> {
  double _progress = 0.0;
  List<Map<String, dynamic>> allCitiesWeather = [];
  List<String> cities = ['Rennes', 'Paris', 'Nantes', 'Bordeaux', 'Lyon'];
  List<String> messages = [
    'Nous téléchargeons les données...',
    'C\'est presque fini...',
    'Plus que quelques secondes avant d\'avoir le résultat...'
  ];
  int messageIndex = 0;
  Timer? timer;
  bool _downloadFinished = false;
 
  void initState() {
    super.initState();
    _updateProgress();
    startTimer();
  }
 
 //Cette méthode permet de mettre à jour la barre de progression du téléchargement des données
 // météorologiques des villes.

  void _updateProgress() async {
    for (var i = 0; i < 60; i++) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _progress = (i + 1) * (100 / 60);
      });
    }
    setState(() {
      _downloadFinished = true;
    });
  }

 //Cette fonction utilise l'API OpenWeatherMap pour récupérer 
 //les données météorologiques d'une ville donnée.

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    String apiKey = '79b208e2e2e510b9ba4de0155a534fc5';
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data for $city');
    }
  }

 //Cette fonction est utilisée pour récupérer les données météorologiques
 // pour toutes les villes de la liste citees que nous avons vue précédemment.

  void printWeatherDataForOneCity(String cityName) async {
    final weatherData = await fetchWeather(cityName);
    setState(() {
      allCitiesWeather.add(weatherData);
    });
    print('$cityName: $weatherData');
    print('allCitiesWeather: $allCitiesWeather');
  }
 
 //cette fonction permet de d'initialiserer un 'timer' et declencher une action chaque 6s 
 //pendant 4 iterations.
 //À chaque itération, la fonction printWeatherDataForOneCity() est appelée avec la ville correspondante. 
 //qui a son tour appelle l'API météo avec le nom de la ville et ajoute les données météo à une liste.
 //La variable 'messageIndex' est également mise à jour pour changer le message d'indicateur
 // de progression affiché à l'écran.

  void startTimer() {
    int x = 0;
    timer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (x == 4) timer.cancel();
      print('x:$x');
      printWeatherDataForOneCity(cities[x]);
      x = x + 1;
      setState(() {
        messageIndex = (messageIndex + 1) % messages.length;
      });
    });
  }
 //Cette fonction est utilisée pour permettre à l'utilisateur 
 //de relancer le téléchargement des données après un échec ou pour mettre à jour 
 //les données en temps réel.

  void _restartDownload() {
    setState(() {
      _progress = 0.0;
      allCitiesWeather.clear();
      _downloadFinished = false;
    });
    _updateProgress();
    startTimer();
  }

 //cette fonction et le widget donnés sont utilisés pour afficher la barre de progression 
 //et les données météorologiques téléchargées à partir de l'API dans l'application mobile.

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Météo des villes'),
    ),
     body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/cloud.jpg'),
          
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
      
    
    child: Column (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        Text(
          messages[messageIndex],
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        if (_downloadFinished)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                // Réinitialiser les variables et relancer le téléchargement
                setState(() {
                  _progress = 0.0;
                  allCitiesWeather = [];
                  _downloadFinished = false;
                });
                startTimer();
                _updateProgress();
              },
              child: Text(
                'Recommencer',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
    if (_progress < 100)
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: LinearProgressIndicator(
      value: _progress / 100,
      backgroundColor: Color.fromRGBO(233, 231, 231, 1),
      valueColor: AlwaysStoppedAnimation<Color>(
          Color.fromRGBO(129, 0, 255, 1)), // violet
      minHeight: 20,
       
     // minWidth: double.infinity,
      // Utilisez la propriété "height" pour définir la hauteur
      // de la barre de progression, plutôt que "heightFactor"
      // qui peut ne pas fonctionner correctement dans tous les cas.
      //height: 10,
    ),
  ),



       
        Text(
          '${_progress.round()}%',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),

Expanded(
  child: ListView.builder(
    itemCount: allCitiesWeather.length,
    itemBuilder: (BuildContext context, int index) {
      final cityName = allCitiesWeather[index]['name'];
      final temp = allCitiesWeather[index]['main']['temp'];
      final feelsLike = allCitiesWeather[index]['main']['feels_like'];
      final tempMin = allCitiesWeather[index]['main']['temp_min'];
      final tempMax = allCitiesWeather[index]['main']['temp_max'];
      final humidity = allCitiesWeather[index]['main']['humidity'];
      final windSpeed = allCitiesWeather[index]['wind']['speed'];
      final iconCode = allCitiesWeather[index]['weather'][0]['icon'];
      final description = allCitiesWeather[index]['weather'][0]['description'];
      
      return Card(
        elevation: 5,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
       // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cityName,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$temp°C',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description.toUpperCase(),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$tempMin°C',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_upward,
                            size: 20,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '$tempMax°C',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Image.network(
                    'http://openweathermap.org/img/w/$iconCode.png',
                    width: 70,
                    height: 70,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Feels like: $feelsLike°C'),
                      Text('Humidity: $humidity%'),
                      Text('Wind: $windSpeed m/s'),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  ),
),
   ],
    ),
  ),
   );
 }
 }


// Expanded(
// //   child: ListView.builder(
// //     itemCount: allCitiesWeather.length,
// //     itemBuilder: (BuildContext context, int index) {
      
// //       final cityName = allCitiesWeather[index]['name'];
// //       final temp = allCitiesWeather[index]['main']['temp'];
// //       final iconCode = allCitiesWeather[index]['weather'][0]['icon'];
// //       final description = allCitiesWeather[index]['weather'][0]['description'];
// //       final humidity = allCitiesWeather[index]['main']['humidity'];

// //     return Container(
// //                         margin:
// //                             EdgeInsets.symmetric(vertical: 5, horizontal: 10),
// //                         decoration: BoxDecoration(
// //                           color: Color.fromARGB(255, 10, 179, 216).withOpacity(0.4),
// //                           borderRadius: BorderRadius.circular(14),
// //                           backgroundBlendMode: BlendMode.multiply,
// // boxShadow: [
// //                             BoxShadow(
// //                               color: Color.fromARGB(255, 13, 182, 220)
// //                                   .withOpacity(0.5),
// //                               spreadRadius: 2,
// //                               blurRadius: 5,
// //                               offset: Offset(0, 3),
// //                             ),
// //                           ],
// //                         ),
    

// //   child: ListTile(
// //         title: Text('$cityName: $temp°C'),
// //         subtitle: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Image.network(
// //                   'http://openweathermap.org/img/w/$iconCode.png',
// //                   width: 50,
// //                   height: 50,
// //                 ),
// //                 SizedBox(width: 10),
// //                 Text(description),
// //               ],
// //             ),
// //             Text('Humidity: $humidity%'),
// //           ],
// //         ),
// //       ),
// //     );
// //     },
// //   ),
// ),
//      ],
//     ),
//   ),
//   );
// }
// }