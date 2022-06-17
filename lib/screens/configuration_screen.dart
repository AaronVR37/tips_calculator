import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationScreen extends StatelessWidget{
  const ConfigurationScreen({Key? key}) : super(key: key);

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
    final controllerAmount = TextEditingController();
    final controllerPercent = TextEditingController();
    double tip = 0;

    return Scaffold(
      appBar: AppBar(title: const Text("Configurations"),
      backgroundColor: const Color.fromARGB(255, 131, 36, 178),
      ),
      body: Center(
        child:
        ElevatedButton(
          onPressed: () {
            setState((){
	                double amount = double.parse(controllerAmount.text);
	                double percent = double.parse(controllerPercent.text);
                  setDefaultValues(percent);

	                tip = amount * percent / 100;
	                //setDefaultValues(percent);
	              });
          },
          child:const Text('Calculate percent'),
        ),
      ),
    );
  }
}

void setState(Null Function() param0) {
}