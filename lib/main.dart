import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields(){
    setState(() {
      weightController.text = "";
      heightController.text = "";
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _validadeFields(){

    if(weightController.text.isNotEmpty && heightController.text.isNotEmpty){
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      _calculate(weight,height);
    }
  }

  void _calculate(double weight, double height){
    double imc = weight / (height * height);
    setState(() {
      if(imc <18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc <24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc <29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc <34.9){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc <39.9){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(3)})";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outlined,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (String? value) {
                  if(value!.isEmpty ){
                    return "Insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (String? value) {
                  if(value!.isEmpty ){
                    return "Insira sua altura!";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _validadeFields();
                    }
                  },
                  child: const Text("Calcular", style: TextStyle(fontSize: 25),),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
