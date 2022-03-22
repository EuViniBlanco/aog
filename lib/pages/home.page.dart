import 'package:aog/widgets/logo.widget.dart';
import 'package:aog/widgets/submit_form.dart';
import 'package:aog/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _color = Colors.deepPurple;
  var _gasCtrl = MoneyMaskedTextController();
  var _alcCtrl = MoneyMaskedTextController();
  var _busy = false;
  var _completed = false;
  var _resultText = "Compensa utilizar Álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(
          milliseconds: 1200,
        ),
        color: _color,
        child: ListView(
          children: <Widget>[
            Logo(),
            _completed
                ? Success(
              result: _resultText,
              reset: reset,
            )
                : SubmitForm(
              gasCtrl: _gasCtrl,
              alcCtrl: _alcCtrl,
              busy: _busy,
              submitFunc: calculate,
            ),
          ],
        ),
      ),
    );
  }

  Future calculate() async {
    double alc =
      double.parse(
        _alcCtrl.text.replaceAll(RegExp(r'[,.]'), ''),
      ) / 100;
    double gas =
        double.parse(
          _gasCtrl.text.replaceAll(RegExp(r'[,.]'), ''),
        ) / 100;
    double res = alc / gas;

    setState(() {
      _color = Colors.deepPurpleAccent;
      _completed = false;
      _busy = true;
    });

    return Future.delayed(const Duration(seconds: 2),
        () {
          setState(() {
          if (res >= 0.7) {
          _resultText = 'Compensa utilizar Gasolina!';
          } else {
          _resultText = 'Compensa utilizar Álcool!';
          }

          _busy = false;
          _completed = true;
          });
        });
  }

  reset() {
    setState(() {
      _alcCtrl = MoneyMaskedTextController();
      _gasCtrl = MoneyMaskedTextController();
      _completed = false;
      _busy = false;
      _color = Theme.of(context).primaryColor;
    });
  }

}