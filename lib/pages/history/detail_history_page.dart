part of 'history.dart';

class HistoryDetailPage extends StatelessWidget {
  final IconData statusIcon;
  final dynamic data;

  const HistoryDetailPage(
      {Key key, @required this.data, @required this.statusIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          primary: true,
          children: [
            const SizedBox(
              height: edge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                data['order'] ?? '-',
                style: blackTextStyle.copyWith(fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Text(
                'Detail Pemesanan Pelayanan',
                style: grayTextStyle.copyWith(fontSize: 14.0),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 10,
                shadowColor: grayColor.withAlpha(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: edge),
                  child: ListView(
                    primary: false,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Order',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['order'],
                              style: regularTextStyle,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nama Klien',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['klien']['nama_klien'] ?? '-',
                              style: regularTextStyle,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Email',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['klien']['email'] ?? '-',
                              style: regularTextStyle,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alamat',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['klien']['alamat'] ?? '-',
                              style: regularTextStyle,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: edge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nomor Telepon',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data['klien']['no_telepon'] ?? '-',
                              style: regularTextStyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: edge),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10,
                  shadowColor: grayColor.withAlpha(100),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: edge),
                      child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: edge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Jenis Pelayanan',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data['pelayanan']['jenis_pelayanan'],
                                  style: regularTextStyle,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: edge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
                                  style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      statusIcon,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      data['status'],
                                      style: regularTextStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: edge),
                            child: Text(
                              'Keterangan',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: edge),
                            child: Text(
                              data['pelayanan']['keterangan'],
                              style: regularTextStyle,
                            ),
                          )
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
