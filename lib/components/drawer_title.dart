import 'package:flutter/material.dart';
import 'package:login_firebase/utils/page_management.dart';
import 'package:provider/provider.dart';

class DrawerTitle extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int page;

  const DrawerTitle({Key key, this.iconData, this.title, this.page})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final curPage = context.watch<PageManagement>().page;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        context.read<PageManagement>().setPage(page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: curPage == page ? primaryColor : Colors.grey[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
