import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api_example/backend/api_service.dart';
import 'package:flutter_api_example/components/quote_card.dart';
import 'package:http/http.dart';

import '../backend/api.dart';
import '../model/quote.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<Quote> quotes = [];
  Quote randomQuote;

  bool connection = true;
  bool loadingRandom = false;

  @override
  void initState() {
    _getData(Endpoint.all);
    super.initState();
  }

  _getData(Endpoint endpoint) async {
    try {
      APIService apiService = APIService(API());

      List _quotes = await apiService.getEndpointData(endpoint: endpoint);

      setState(() {

        connection = true;

        if (_quotes.length == 1) {
          randomQuote = _quotes[0];
        } else {
          quotes = _quotes;
        }

      });
    } on Response catch (_) {
      setState(() {
        connection = false;
      });
    } on SocketException catch (_) {
      rethrow;
    } catch (error) {
      _showSnackBar(context, "There was an error.");
    }
  }

  _showRandomQuote(BuildContext context) async {
    try {
      _setLoading(true);
      await _getData(Endpoint.random);
      _setLoading(false);

      final result = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\"${randomQuote.content}\""),
                  SizedBox(height: 10),
                  Text(
                    "${randomQuote.author}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("Copy"))
            ],
          );
        },
      );
      if (result == true) {
        _showSnackBar(context, "Copied to clipboard!");
      }
    } catch (error) {
      _setLoading(false);
      _showSnackBar(context, "Server error, check your connection.");
    }
  }

  _showSnackBar(BuildContext context, String content) {
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(content),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  _setLoading(bool value) {
    setState(() {
      loadingRandom = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programming Quotes"),
      ),
      body: RefreshIndicator(
          onRefresh: () => _getData(Endpoint.all),
          child: Stack(
            children: [
              if (!connection)
                Center(
                  child: Text("You have no internet connection."),
                ),
              Builder(
                builder: (context) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          _randomQuoteButton(context),
                          _quotesList(context),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }

  Widget _quotesList(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          if (connection && quotes.isEmpty)
            Center(child: CircularProgressIndicator()),
          if (quotes != null && connection)
            for (Quote quote in quotes)
              QuoteCard(
                quote: quote,
                context: context,
              ),
        ],
      ),
    );
  }

  Widget _randomQuoteButton(BuildContext context) {
    return Container(
      height: 30,
      child: FlatButton(
        textColor: Theme.of(context).primaryColor,
        child: Text("Random Quote"),
        onPressed: loadingRandom ? null : () => _showRandomQuote(context),
      ),
    );
  }
}
