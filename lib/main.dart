import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/configuration_screen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controllerAmount = TextEditingController();
  final controllerPercent = TextEditingController();
  double tip = 0;

  void setDefaultValues(double value) async {
	  final prefs = await SharedPreferences.getInstance();
	  await prefs.setDouble('percent', value);
  }

  Future<double?>getDefaultValues() async {
	  final prefs = await SharedPreferences.getInstance();
	  final double percent = prefs.getDouble('precent')??15;

	return percent;
  }
  
  @override
  Widget build(BuildContext context) {
	  getDefaultValues().then((value) => {
		controllerPercent.text = value.toString()
  });
  
    return Scaffold(
      appBar: AppBar(title: const Text("Tips"),),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: TextFormField(
                controller: controllerAmount,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText:"Amount",
                  border: UnderlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: TextFormField(
                controller: controllerPercent,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText:"Percent",
                  border: UnderlineInputBorder()
                ),
              ),
            ),
            Text('Tip to pay\$$tip'),
            ElevatedButton(
              onPressed: (){
                setState((){
	                double amount = double.parse(controllerAmount.text);
	                double percent = double.parse(controllerPercent.text);

	                tip = amount * percent / 100;
	                //setDefaultValues(percent);
	              });
              },
              child: const Text('Calculate')
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfigurationScreen()));
              },
              child: const Text('Go to second screen')),
          ]
        ),
      )
    );
  }
}