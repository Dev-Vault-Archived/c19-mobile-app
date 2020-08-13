import 'package:covid19/data/response_data.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class MCovidInformasiSelengkapnyaScreen extends StatelessWidget {
  final ResponseData data;

  MCovidInformasiSelengkapnyaScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FLAppBarTitle(
          title: 'Penyebaran COVID-19',
        ),
      ),
      body: Container(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ODP (Orang Dalam Pemantauan)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'ODP merupakan orang yang sempat bepergian ke negara atau daerah lain yang merupakan pusat penyebaran virus corona. Selain itu, seseorang yang pernah berkontak langsung dengan orang atau pasien positif corona juga dapat dikatakan sebagai ODP.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Total ODP',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            data.data.odp.total.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          Text(
                            data.data.odp.cChange.total.toString(),
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Proses Pemantauan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.odp.process} (${data.data.odp.percentage.process})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Selesai Pemantauan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.odp.done} (${data.data.odp.percentage.done})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Meninggal Dunia',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.odp.dead} (${data.data.odp.percentage.dead})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'PDP (Pasien Dalam Pengawasan)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'PDP adalah orang yang masuk dalam kategori sudah dirawat oleh tenaga kesehatan (menjadi pasien). Seseorang dikatakan PDP juga apabila terlihat menunjukkan gejala sakit, seperti demam, batuk, pilek, dan sesak napas. Selanjutnya, PDP akan dipantau kembali dengan teliti apakah orang tersebut memiliki riwayat kontak dengan orang positif Covid-19.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Total PDP',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            data.data.pdp.total.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          Text(
                            data.data.pdp.cChange.total.toString(),
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Proses Pengawasan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.pdp.process} (${data.data.pdp.percentage.process})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Selesai Pengawasan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.pdp.done} (${data.data.pdp.percentage.done})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Meninggal Dunia',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.pdp.dead} (${data.data.pdp.percentage.dead})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'OTG (Orang Tanpa Gejala)',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'OTG adalah mereka yang tidak bergejala. Selain itu, mereka juga memiliki risiko tertular dari orang yang terkonfirmasi positif Covid-19. Kategori OTG juga memiliki riwayat kontak erat, baik kontak fisik, berada dalam ruangan atau berkunjung dengan radius 1 meter, dengan pasien Covid-19.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Total OTG',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            data.data.otg.total.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.white,
                          ),
                          Text(
                            data.data.otg.cChange.total.toString(),
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Proses Pemantauan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.otg.process} (${data.data.otg.percentage.process})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Selesai Pemantauan',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.otg.done} (${data.data.otg.percentage.done})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'Meninggal Dunia',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${data.data.otg.dead} (${data.data.otg.percentage.dead})',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
