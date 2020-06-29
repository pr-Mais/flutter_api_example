import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/quote.dart';

void copyQuote(Quote quote, BuildContext context) {
  final _quote = "\"${quote.content}\", ${quote.author}";
  Clipboard.setData(new ClipboardData(text: _quote));

  Scaffold.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          "Copied to clipboard!",
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
}

class QuoteCard extends StatelessWidget {
  const QuoteCard({
    Key key,
    @required this.quote,
    @required this.context,
  }) : super(key: key);
  final Quote quote;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: Colors.grey[300]),
          ],
          color: Colors.white),
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\"${quote.content}\"",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${quote.author}",
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
              IconButton(
                  icon: Icon(
                    Icons.content_copy,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => copyQuote(quote, context)),
            ],
          ),
        ],
      ),
    );
  }
}
