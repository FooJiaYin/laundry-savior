import 'package:flutter/material.dart';
import '../../models/sample.dart';
import '../../theme/theme.dart';
import '../widgets/container.dart';
import '../widgets/scaffold_page.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    required this.data,
    Key? key,
  }) : super(key: key);

  final SampleData data;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  SampleData get data => widget.data;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBar: AppBar(title: Text(data.name)),
      child: CardContainer(
        shadows: ThemeDecoration.shadow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.name),
            if (data.description != null) Text(data.description!),
          ],
        ),
      ),
    );
  }
}
