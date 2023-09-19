import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/assets/global_values.dart';
import 'package:login/assets/stylesApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkMode = false; // Variable para el estado del tema aqui empieza la magia

  @override
  void initState() {
    super.initState();
    loadTheme(); // Carga el tema al iniciar la aplicación
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
    Navigator.pushReplacementNamed(context, '/login');
  }

  void toggleTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = isDark;
      prefs.setBool('isDarkMode', isDarkMode); // Guarda el estado del tema en SharedPreferences
    });
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false; // Recupera el estado del tema guardado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? StylesApp.darkTheme(context) : StylesApp.lightTheme(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bienvenidos :)'),
        ),
        drawer: createDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget createDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/400'),
            ),
            accountName: Text('Joseph'),
            accountEmail: Text('Maldonadojose@gmail.com'),
          ),
          ListTile(
            leading: Image.asset('assets/fresa.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('furitApp'),
            subtitle: Text('Carrucel'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: isDarkMode,
            onStateChanged: (isDarkModeEnabled) {
              toggleTheme(isDarkModeEnabled); // Llama a toggleTheme cuando se cambia el tema
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Ícono de cerrar sesión o foto relacionada xd
            title: Text('Cerrar sesión'),
            onTap: () {
              logout(); // Llama a la función logout al hacer clic en "Cerrar sesión" 
            },
          ),
        ],
      ),
    );
  }
}
