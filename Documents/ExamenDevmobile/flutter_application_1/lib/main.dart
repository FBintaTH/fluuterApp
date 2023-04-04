
import 'package:flutter_application_1/villes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/progress_screen.dart';

//cette fonction sert à exécuter l'application mobile Flutter en démarrant le Widget racine MyApp().
void main() {
  runApp(MyApp());
}
//cette classe sert à définir l'objet principal qui représente l'application elle-même et à configurer 
//les propriétés de l'objet MaterialApp qui déterminent l'apparence et le comportement de l'application.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Météo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Accueil'),
    );
  }
}
//Cette classe est utilisée pour créer un widget qui affiche le contenu de la page d'accueil, 
//qui peut être modifié en fonction des besoins de l'application.
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

//cette méthode build sert à définir la structure et le contenu de la page d'accueil de l'application 
//mobile. Elle utilise le widget 'Scaffold' pour définir une barre d'applications et un corps de page, 
//qui contiennent une image de fond, un texte et un bouton qui permet de naviguer vers une autre page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/5.jpg'),
        
          fit: BoxFit.cover,
        ),
      ),
      width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Positioned(
  top: 80,
  left: 20,
  child: Center(
    child: Text(
      'Bienvenue sur notre application',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        color: Color(0xD6050CE1), // nouvelle couleur
        fontWeight: FontWeight.bold,
        
      ),
    ),
  ),
),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Villes()),
                );
              },
              
              child: Text('Démarrer'),
              
            ),
          ],
        ),
      ),
    );
  }
}


