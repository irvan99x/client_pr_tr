part of 'service_order.dart';

class ServiceOrderPage extends StatefulWidget {
  const ServiceOrderPage({Key key}) : super(key: key);

  @override
  State<ServiceOrderPage> createState() => _ServiceOrderPageState();
}

class _ServiceOrderPageState extends State<ServiceOrderPage> {
  // Variable
  String serviceName;
  String seletectedName;
  String apiKey;
  String _mySelection, _fileName;

  List data = [];
  FilePickerResult result;

  // Controller
  final TextEditingController _controllerOrder = TextEditingController();
  final TextEditingController _controllerFile = TextEditingController();

  @override
  void initState() {
    getApiKey();

    super.initState();
  }

  @override
  void dispose() {
    _controllerOrder.dispose();
    _controllerFile.dispose();

    if (result != null) {
      result.files.clear();
    }

    _fileName = "";

    super.dispose();
  }

  void getApiKey() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      apiKey = prefs.get('api_key');
    });

    getDataPelayanan();
  }

  _showToast(String toast, Color backgroundColor) {
    final snackBar = SnackBar(
      content: Text(toast),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _openFileExplorer() async {
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    } on PlatformException catch (e) {
      _showToast("Unsupported operation" + e.toString(), Colors.red);
    } catch (ex) {
      _showToast(ex.toString(), Colors.red);
    }

    if (!mounted) return;

    setState(() {
      _fileName = result.files.single.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Media size

    return Scaffold(
      appBar: const PreferedAppbar(
          title: "Pemesanan Pelayanan", subtitle: "Buat pemesanan pelayanan"),
      body: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Text("Jenis Pelayanan", style: blackTextStyle),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: data.isNotEmpty ? _mySelection : "",
                  isDense: true,
                  isExpanded: true,
                  items: data.isNotEmpty
                      ? data.map((item) {
                          return DropdownMenuItem(
                            child: Text(item['jenis_pelayanan']),
                            value: item['id'].toString(),
                          );
                        }).toList()
                      : [
                          const DropdownMenuItem(child: Text("-"), value: ""),
                        ],
                  onChanged: (newValue) {
                    setState(() {
                      _mySelection = newValue;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: Text("Berkas Pendukung", style: blackTextStyle),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: edge),
                  child: Text(
                    _fileName ?? '-',
                    style: blackTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: RoundedButton(
                backgroundColor: orangeColor,
                onPressed: () {
                  _openFileExplorer();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Upload",
                      style: whiteTextStyle,
                    ),
                  ],
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Text("Berkas yang didukung *pdf",
                style: blackTextStyle.copyWith(
                    fontSize: 12.0, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: size.width * .1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: RoundedButton(
                onPressed: () {
                  store();
                  // Save data
                  // databaseHelper.adddata(_controllerOrder.text.trim(),
                  //     _controllerFile.text.trim());

                  // Kembali ke halaman utama
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const MainMenuPage(),
                  //   ),
                  // );
                },
                child: Text(
                  "Simpan Data",
                  style: whiteTextStyle,
                )),
          )
        ],
      ),
    );
  }

  /// Get data pelayanan
  Future<void> getDataPelayanan() async {
    http.Response response = await http.get(
      Uri.parse(ServiceUrl.pelayanan),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
    );

    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
      _mySelection = data.isNotEmpty ? data[0]['id'].toString() : "";
    });

    return SmartDialog.dismiss();
  }

  Future<void> store() async {
    _showLoading();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    //create multipart request for POST or PATCH method
    var request = http.MultipartRequest("POST", Uri.parse(OrderUrl.order));
    request.headers.addAll(headers);
    // add additional fields
    // request.fields["field1"] = value1;

    // create multipart using filepath, string or bytes
    var fileToUpload =
        await http.MultipartFile.fromPath("file", result.files.single.path);
    //add multipart to request
    request.files.add(fileToUpload);
    request.fields['pelayanan_id'] = _mySelection;

    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    SmartDialog.dismiss();

    _showToast(json.decode(responseString)['message'], Colors.green);

    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainMenuPage(),
      ),
    );
  }

  void _showLoading() async {
    SmartDialog.showLoading(
        backDismiss: false,
        background: whiteColor,
        widget: const LoadingCard());
  }
}
