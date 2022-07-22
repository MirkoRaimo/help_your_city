import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class WideScreen extends StatelessWidget {
  const WideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text(
            '''L'app non ha ancora una versione desktop.\nProva a rimpicciolire lo schermo'''),
      ),
    );
  }
}
