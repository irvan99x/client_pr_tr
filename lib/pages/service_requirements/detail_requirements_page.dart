part of 'service_requirements.dart';

class DetailRequirementsPage extends StatefulWidget {
  final List list;
  final int index;

  const DetailRequirementsPage({Key key, this.list, this.index})
      : super(key: key);

  @override
  State<DetailRequirementsPage> createState() => _DetailRequirementsPageState();
}

class _DetailRequirementsPageState extends State<DetailRequirementsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferedAppbar(
          title: widget.list[widget.index]['jenis_pelayanan'] ?? '-',
          subtitle: "Detail Pelayanan"),
      body: SafeArea(
        bottom: false,
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                "Keterangan : " ?? '-',
                style: regularTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                widget.list[widget.index]['keterangan'] ?? '-',
                style: regularTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
