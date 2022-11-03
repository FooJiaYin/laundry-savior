import 'package:flutter/material.dart';
import '../../models/sample.dart';
import '../../services/fake_data.dart';
import '../../theme/theme.dart';
import '../widgets/container.dart';
import '../widgets/scaffold_page.dart';
import 'article.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final String title = "List of Sample Item";
  late List<SampleData> items;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  loadItems() async {
    items = await FakeData.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      appBar: AppBar(
        title: Text(title),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map(itemCard).toList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget itemCard(SampleData e) => CardContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 6,
        ),
        shadows: ThemeDecoration.shadow,
        onTap: () => viewArticle(e),
        onLongPress: () => showDialog(context: context, builder: (_) => itemModal(e)),
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(e.user.profileImage.url!)),
          title: Text(e.name),
          subtitle: Text(e.description ?? ""),
        ),
      );

  void viewArticle(data) => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ArticlePage(data: data),
        ),
      );

  Widget itemModal(SampleData data) => SimpleDialog(
        title: Text(data.name),
        children: [
          ButtonBar(
            children: [TextButton(onPressed: () => viewArticle(data), child: const Text("Continue")), TextButton(onPressed: () => {}, child: const Text("Cancel"))],
          )
        ],
      );
}
