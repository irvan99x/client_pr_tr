part of 'widgets.dart';

class ItemCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String title;

  const ItemCard(
      {Key key,
      @required this.onTap,
      @required this.iconData,
      @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 10,
        shadowColor: grayColor.withAlpha(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundColor: greenColor,
                foregroundColor: Colors.white,
                child: Icon(
                  iconData,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge / 2),
              child: Text(
                title,
                style: regularTextStyle.copyWith(fontSize: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String title;

  const ListCard(
      {Key key,
      @required this.title,
      @required this.iconData,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8.0,
        shadowColor: Colors.grey[50],
        child: ListTile(
            title: Text(
              title,
              style: regularTextStyle,
            ),
            leading: Icon(iconData),
            trailing: const Icon(Icons.chevron_right)),
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final VoidCallback onTap;
  final IconData iconData;
  final String title, subtitle;
  final Color color;

  const HistoryCard(
      {Key key,
      @required this.iconData,
      @required this.title,
      this.subtitle,
      this.color,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 10,
        shadowColor: grayColor.withAlpha(100),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color ?? greenColor,
            child: Icon((iconData ?? Icons.dashboard), color: Colors.white),
          ),
          title: Text(
            title ?? '-',
            style: regularTextStyle,
          ),
          subtitle: Text(
            subtitle ?? '-',
            style: regularTextStyle,
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  final String title;

  const LoadingCard({Key key, this.title = "Harap Tunggu!"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        shadowColor: grayColor.withAlpha(100),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                title,
                style: regularTextStyle,
              )
            ],
          ),
        ));
  }
}
