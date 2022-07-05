part of 'service_requirements.dart';

class ServiceRequirementsPage extends StatefulWidget {
  const ServiceRequirementsPage({Key key}) : super(key: key);

  @override
  State<ServiceRequirementsPage> createState() =>
      _ServiceRequirementsPageState();
}

class _ServiceRequirementsPageState extends State<ServiceRequirementsPage> {
  String apiKey;

  List data = [];

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
          title: "Persyaratan Layanan", subtitle: "Detail Persyaratan Layanan"),
      body: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          // Konten persyaratan pelayanan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: FutureBuilder(
                future: getPelayanan(),
                builder: (context, snapshot) {
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
                                image:
                                    AssetImage('assets/images/empty_box.png'),
                              ),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: edge / 2)),
                          Text("Maaf, ada kesalahan saat pengambilan data!.",
                              style: blackTextStyle.copyWith(fontSize: 14.0)),
                        ],
                      );
                    }

                    // Kondisi apabila data tidak kosong
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount:
                          snapshot.data == null ? 0 : snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListCard(
                          title: snapshot.data[index]['jenis_pelayanan']
                              .toString(),
                          iconData: Icons.widgets,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => DetailRequirementsPage(
                                  list: snapshot.data, index: index),
                            ));
                          },
                        );
                      },
                    );
                  }

                  // Kondisi apabila data masih dalam proses pengambilan / loading
                  return Container();
                }),
          ),
        ],
      ),
    );
  }

  //function get pelayanan
  Future<void> getPelayanan() async {
    final response = await http.get(Uri.parse(ServiceUrl.pelayanan), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    SmartDialog.dismiss();
    // print(json.decode(response.body));
    return json.decode(response.body);
  }
}
