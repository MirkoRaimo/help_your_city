import 'package:flutter/material.dart';
import 'package:help_your_city/db/models/basic_card_model.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({required this.basicCardModel, Key? key})
      : super(key: key);

  final BasicCardModel basicCardModel;

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          basicCardModel.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              flightShuttleBuilder: _flightShuttleBuilder,
              tag: basicCardModel.image,
              child: Image.asset(
                basicCardModel.image,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Hero(
                      tag: basicCardModel.title,
                      child: Text(
                        basicCardModel.title,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (basicCardModel.body != null)
              Hero(
                flightShuttleBuilder: _flightShuttleBuilder,
                tag: basicCardModel.body!,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Flexible(
                    child: Text(
                      basicCardModel.body!,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
