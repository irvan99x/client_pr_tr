part of 'history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String apiKey;

  @override
  void initState() {
    getApiKey();

    super.initState();
  }

  void getApiKey() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      apiKey = prefs.get('api_key');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: const PreferedAppbar(
            title: "Riwayat", subtitle: "Riwayat pemesanan pelayanan"),
        body: ListView(primary: true, shrinkWrap: true, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: FutureBuilder(
              future: _getOrder(),
              builder: (_, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  /**
                   * Cek apakah data kosong atau tidak
                   */
                  if (snapshot.data == null) {
                    // Kondisi apabila data kosong / null
                    return Column(
                      children: [
                        SizedBox(
                          height: size.height * .2,
                        ),
                        Container(
                          height: size.width * .2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              image: AssetImage('assets/images/empty_box.png'),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: edge / 2)),
                        Text("Maaf, ada kesalahan saat pengambilan data!.",
                            style: blackTextStyle.copyWith(fontSize: 14.0)),
                      ],
                    );
                  }

                  // Kondisi apabila data tidak kosong
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                    itemBuilder: (context, index) {
                      IconData iconData;
                      Color color;
                      dynamic data = snapshot.data[index];

                      switch (snapshot.data[index]['status']) {
                        case 'masuk':
                          color = grayColor;
                          iconData = Icons.login;
                          break;
                        case 'proses':
                          color = purpleColor;
                          iconData = Icons.timer;
                          break;
                        case 'ditolak':
                          color = redColor;
                          iconData = Icons.close;
                          break;
                        default:
                          color = greenColor;
                          iconData = Icons.check;
                      }

                      return HistoryCard(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HistoryDetailPage(
                                data: data,
                                statusIcon: iconData,
                              ),
                            ),
                          );
                        },
                        title: data['order'],
                        subtitle: snapshot.data[index]['pelayanan']
                            ['jenis_pelayanan'],
                        iconData: iconData,
                        color: color,
                      );
                    },
                  );
                }

                return Container();
              },
            ),
          )
        ]));
  }

  //function get history
  Future<void> _getOrder() async {
    final response = await http.get(Uri.parse(OrderUrl.order), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    SmartDialog.dismiss();

    return json.decode(response.body);
  }
}
