import 'dart:developer';

import 'dart:math' show cos, sqrt, asin;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19/constant.dart';
import 'package:covid19/data/response_data.dart';
import 'package:covid19/screens/collaboration_screen.dart';
import 'package:covid19/screens/informasi_selengkapnya_screen.dart';
import 'package:covid19/screens/photoview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidAppBar extends AppBar {
  CovidAppBar(context)
      : super(
            elevation: 0.25,
            backgroundColor: Colors.white,
            flexibleSpace: _buildCovidAppbar(context));

  static Widget _buildCovidAppbar(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            "assets/images/logo_pangandaran_hebat.png",
            height: 50.0,
            width: 100.0,
          ),
          IconButton(
            icon: Icon(Icons.live_help),
            onPressed: () {
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InCollaborationScreen()));
            },
            color: ColorPallete.grey,
          )
        ],
      ),
    );
  }
}

class CovidService {
  IconData image;
  Color color;
  String title;
  Function onTap;

  CovidService({this.image, this.title, this.color, this.onTap});
}

class MyInAppBrowser extends InAppBrowser {}

class MyChromeSafariBrowser extends ChromeSafariBrowser {
  MyChromeSafariBrowser(browserFallback) : super(bFallback: browserFallback);
}

class MCovidHomeScreen extends StatefulWidget {
  static const routeName = 'home';

  final ResponseData data;
  final ChromeSafariBrowser browser = MyChromeSafariBrowser(MyInAppBrowser());

  MCovidHomeScreen({this.data});

  @override
  _MCovidHomeScreenState createState() => _MCovidHomeScreenState();
}

class _MCovidHomeScreenState extends State<MCovidHomeScreen> {
  List<CovidService> _covidService = [];
  List<Widget> imageSliders = List.of([]);
  List<Map<dynamic, dynamic>> imgList = List.of([]);

  @override
  void initState() {
    _covidService.add(
      CovidService(
        image: Icons.apps,
        color: ColorPallete.menuMart,
        title: "PORTAL",
        onTap: () async {
          await widget.browser.open(
              url: 'https://covid19.pangandarankab.go.id/',
              options: ChromeSafariBrowserClassOptions(
                  android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false),
                  ios: IOSSafariOptions(barCollapsingEnabled: true)));
        },
      ),
    );
    _covidService.add(
      CovidService(
          image: Icons.call,
          color: ColorPallete.menuRide,
          title: "HOTLINE",
          onTap: () async {
            if (await canLaunch('tel://+6285320643695')) {
              await launch('tel:+6285320643695');
            }
          }),
    );
    _covidService.add(
      CovidService(
          image: Icons.face,
          color: ColorPallete.menuTix,
          title: "PERIKSA MANDIRI",
          onTap: () async {
            await widget.browser.open(
                url: 'https://www.prixa.ai/corona?lang=en',
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                        addDefaultShareMenuItem: false),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          }),
    );
    _covidService.add(
      CovidService(
          image: Icons.launch,
          color: ColorPallete.menuSend,
          title: "PIKOBAR",
          onTap: () async {
            await widget.browser.open(
                url: 'https://pikobar.jabarprov.go.id/',
                options: ChromeSafariBrowserClassOptions(
                    android: AndroidChromeCustomTabsOptions(
                        addDefaultShareMenuItem: false),
                    ios: IOSSafariOptions(barCollapsingEnabled: true)));
          }),
    );

    imgList = widget.data.data.slideshow
        .map((e) => {
              'url': e.url,
              'to': () async {
                if (e.to == null) {
                  return;
                } else {
                  await widget.browser.open(
                      url: e.to,
                      options: ChromeSafariBrowserClassOptions(
                          android: AndroidChromeCustomTabsOptions(
                              addDefaultShareMenuItem: false),
                          ios: IOSSafariOptions(barCollapsingEnabled: true)));
                }
              },
            })
        .toList();

    imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        GestureDetector(
                          child: CachedNetworkImage(
                            imageUrl: item['url'],
                            width: 1024.0,
                            height: 600.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Image.asset('assets/images/placeholder.png'),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // child: Image.network(
                          //   item['url'],
                          //   fit: BoxFit.cover,
                          //   width: 1024.0,
                          //   height: 600.0,
                          // ),
                          onTap: item['to'],
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    _getLocation(true);

    super.initState();
  }

  Location location = Location();
  LocationData currentLocation;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  int statusLocation = 0;

  double calculateDistance(LatLng f, LatLng g) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((g.latitude - f.latitude) * p) / 2 +
        c(f.latitude * p) *
            c(g.latitude * p) *
            (1 - c((g.longitude - f.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  Future<bool> _showDialog() async {
    // flutter defined function
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Fitur Lokasi"),
          content: new Text(
              "Anda bisa mengaktifkan lokasi untuk menikmati beberapa fitur tambahan yang hanya bisa dilakukan ketika lokasi aktif. Lokasi anda tidak akan dikirimkan ke server dan semua operasi dilakukan secara lokal."),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Batal",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: new Text("Setuju"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void _getLocation(bool isAutomatic) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      final bool returnDialog = await _showDialog();
      if (returnDialog == true) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      } else {
        return;
      }
    }

    try {
      if (currentLocation == null) {
        currentLocation = await location.getLocation();

        int activeInTenKM = 0;

        widget.data.data.maps.forEach((element) {
          final String image = element[2].toString().split('/')[5];

          // log(calculateDistance(element, LatLng(currentLocation.latitude, currentLocation.longitude)).toString());
          if (image == 'positif.png' &&
              calculateDistance(
                      LatLng(element[0], element[1]),
                      LatLng(currentLocation.latitude,
                          currentLocation.longitude)) <=
                  5) {
            activeInTenKM++;
          }
        });

        if (activeInTenKM > 0) {
          statusLocation = 1;
        } else {
          statusLocation = 2;
        }
      }

      setState(
          () {}); //rebuild the widget after getting the current location of the user
    } on Exception {
      currentLocation = null;
    }
  }

  Widget createStatusWidget() {
    if (_permissionGranted != PermissionStatus.granted) {
      return Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.all(12.0),
        // margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: 110.0,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorPallete.green.withOpacity(0.95),
                ColorPallete.green.withOpacity(0.95)
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(0.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Lokasi tidak diaktifkan",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontFamily: "NeoSansBold"),
                ),
                SizedBox(height: 3),
                Text('Klik disini untuk mengaktifkan fitur lokasi.',
                    style: TextStyle(fontSize: 10.0, color: Colors.white)),
                RaisedButton.icon(
                    color: ColorPallete.green,
                    onPressed: () {
                      _getLocation(false);
                    },
                    icon: Icon(Icons.location_on, color: Colors.white),
                    label: Text(
                      'Aktifkan lokasi',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            Container(
              child: Icon(
                Icons.location_disabled,
                color: Colors.white30,
                size: 150,
              ),
            )
          ],
        ),
      );
    }

    String text = '';
    String description = '';
    Color color = ColorPallete.green;

    if (currentLocation == null || statusLocation == 0) {
      text = 'Mengambil lokasi...';
      description = 'Sedang mengambil lokasi anda, mohon tunggu.';
    } else {
      if (statusLocation == 1) {
        text = 'Hati-Hati';
        description =
            'Terdapat kasus positif yang aktif pada jarak 5 KM dari lokasi anda.';
        color = Colors.red[900];
      } else {
        text = 'Tetap Siaga';
        description =
            'Tidak ada kasus positif aktif di sekitar anda, tetap waspada.';
      }
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.all(12.0),
      // margin: EdgeInsets.all(10.0),
      width: double.infinity,
      height: 62.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withOpacity(0.95), color.withOpacity(0.95)],
          ),
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 18.0, color: Colors.white, fontFamily: "NeoSansBold"),
          ),
          SizedBox(height: 3),
          Text(description,
              style: TextStyle(fontSize: 10.0, color: Colors.white))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    log('Building home screen');

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: CovidAppBar(context),
            body: Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  (imageSliders.length > 0)
                      ? Container(
                          color: Colors.white,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: false,
                            ),
                            items: imageSliders,
                          ),
                        )
                      : Container(),
                  Container(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        ColorPallete.green,
                                        ColorPallete.green
                                      ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(3.0))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "ACTIVE CASE",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontFamily: "NeoSansBold"),
                                        ),
                                        Container(
                                          child: Text(
                                            widget.data.data.confirmed.active
                                                    .toString() +
                                                ' ORANG',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white,
                                                fontFamily: "NeoSansBold"),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                        'Sumber Data: Dinas Kesehatan Kabupaten Pangandaran',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(3.0)),
                          //   border: Border.all(
                          //     color: ColorPallete.green,
                          //     width: 4.0
                          //   ),
                          // ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Card(
                                  // color: Theme.of(context).primaryColor,
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Terkonfirmasi',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorPallete.green,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Orang yang terkonfirmasi positif menggunakan PCR',
                                          style: TextStyle(
                                            color: ColorPallete.green,
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              widget.data.data.confirmed.total
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: ColorPallete.green,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_up,
                                              color: ColorPallete.green,
                                            ),
                                            Text(
                                              widget.data.data.confirmed
                                                  .rRechange.active
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: ColorPallete.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  // color: Colors.green,
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Sembuh',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[800],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Orang yang telah sembuh dan negatif PCR',
                                          style: TextStyle(
                                            color: Colors.green[800],
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              widget.data.data.confirmed.recover
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green[800],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_up,
                                              color: Colors.green[800],
                                            ),
                                            Text(
                                              widget.data.data.confirmed
                                                  .rRechange.recover
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.green[800]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  // color: Colors.red,
                                  elevation: 0,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Meninggal',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red[600],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          'Orang yang terkonfirmasi dan meninggal dunia',
                                          style: TextStyle(
                                            color: Colors.red[600],
                                            fontSize: 10.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              widget.data.data.confirmed.dead
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red[600],
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_up,
                                              color: Colors.red[600],
                                            ),
                                            Text(
                                              widget.data.data.confirmed
                                                  .rRechange.dead
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.red[600]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        FlatButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MCovidInformasiSelengkapnyaScreen(
                                          data: widget.data,
                                        )));
                          },
                          icon: Icon(Icons.more_horiz),
                          textColor: ColorPallete.grey,
                          label: Text('Selengkapnya'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: createStatusWidget(),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Pelayanan COVID-19",
                          style: TextStyle(fontFamily: "NeoSansBold"),
                        ),
                        Container(
                          height: 85.0,
                          child: Container(
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (context, position) {
                                CovidService covidService =
                                    _covidService[position];

                                return GestureDetector(
                                  onTap: covidService.onTap,
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(12.0),
                                          child: Icon(
                                            covidService.image,
                                            color: covidService.color,
                                            size: 32.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 6.0),
                                        ),
                                        Text(
                                          covidService.title,
                                          style: TextStyle(
                                            fontSize: 10.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            // color: Theme.of(context).primaryColor,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'RDT',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: ColorPallete.menuRide,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Rapid Diagnostic Test',
                                    style: TextStyle(
                                      color: ColorPallete.menuRide,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        widget.data.data.rdt.toString(),
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPallete.menuRide,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            // color: Colors.green,
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'PCR',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: ColorPallete.menuTix,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    'Polymerase Chain Reaction',
                                    style: TextStyle(
                                      color: ColorPallete.menuTix,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        widget.data.data.pcr.toString(),
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorPallete.menuTix,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (widget.data.data.beritas.length > 0)
                      ? Container(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Berita",
                                style: TextStyle(fontFamily: "NeoSansBold"),
                              ),
                              Text(
                                "Informasi terbaru tentang COVID-19 di Kabupaten Pangandaran",
                                style: TextStyle(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 200,
                                child: ListView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  // shrinkWrap: true,
                                  itemCount: widget.data.data.beritas.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Beritas berita =
                                        widget.data.data.beritas[index];

                                    return GestureDetector(
                                      onTap: () async {
                                        await widget.browser.open(
                                            url: berita.link,
                                            options: ChromeSafariBrowserClassOptions(
                                                android:
                                                    AndroidChromeCustomTabsOptions(
                                                        addDefaultShareMenuItem:
                                                            false),
                                                ios: IOSSafariOptions(
                                                    barCollapsingEnabled:
                                                        true)));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5.0),
                                        width: 200,
                                        child: Stack(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              height: 200,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(3.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: berita.image,
                                                  // width: 100,
                                                  // height: 60,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Image.asset(
                                                          'assets/images/placeholder.png'),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(height: 10),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Container(
                                                color: Colors.black54,
                                                width: 200,
                                                height: 50,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    berita.title.trim(),
                                                    textAlign: TextAlign.start,
                                                    softWrap: true,
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Infografis",
                          style: TextStyle(fontFamily: "NeoSansBold"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 360,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              Infographic nows =
                                  widget.data.data.infographic[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhotoViewScreen(
                                            url: nows.image,
                                          )));
                                },
                                child: CachedNetworkImage(
                                  imageUrl: nows.image,
                                  placeholder: (context, url) => Image.asset(
                                      'assets/images/placeholder.png'),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              );
                            },
                            itemCount: widget.data.data.infographic.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
