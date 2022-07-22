import 'package:flutter/material.dart';
import 'package:help_your_city/db/models/basic_card_model.dart';
import 'package:help_your_city/ui/screens/news_detail_screen.dart';

Widget newsPreview(
    BuildContext context, String image, String title, String? body) {
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

  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
              basicCardModel:
                  BasicCardModel(image: image, title: title, body: body),
            ),
          ));
    },
    child: Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: image,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage(
                    image,
                  ),
                ),
              ),
            ),
          ),
          Hero(
            flightShuttleBuilder: _flightShuttleBuilder,
            tag: title,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          if (body != null)
            Hero(
              flightShuttleBuilder: _flightShuttleBuilder,
              tag: body,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  body,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
