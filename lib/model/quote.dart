class Quote {
  final String content;
  final String author;

  Quote.fromJson(Map<String, dynamic> json)
      : content = json['en'] as String,
        author = json['author'] as String;
}
