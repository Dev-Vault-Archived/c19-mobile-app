import 'dart:io';

import 'package:covid19/constant.dart';
import 'package:covid19/data/response_data.dart';
import 'package:covid19/screens/home_screen.dart';
import 'package:covid19/screens/maps_screen.dart';
import 'package:covid19/screens/statistic_screen.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MCovidApplication());

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MCovidApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '#LawanCovid Pangandaran',
      theme: ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: ColorPallete.green,
        accentColor: ColorPallete.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '@',
      home: HomeTab(),
      routes: {
        '@': (BuildContext ctx) => HomeTab(),
        MCovidHomeScreen.routeName: (BuildContext ctx) => MCovidHomeScreen(),
      },
    );
  }
}

class HomeTab extends StatefulWidget {
  static const String routeName = '/';

  HomeTab({Key key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static Dio _dio;
  int _currentIndex = 0;

  Future<ResponseData> _loadingResponseData;

  @override
  void initState() {
    _dio = Dio(BaseOptions())
      ..interceptors.add(DioCacheManager(CacheConfig())
          .interceptor)
      ..interceptors.add(LogInterceptor(responseBody: true));

    _loadingResponseData = _fetchingdata();

    super.initState();
  }

  Future<ResponseData> _fetchingdata() async {
    try {

      await new Future.delayed(const Duration(seconds: 2));

      Response response = await _dio.get(
        'https://covid-19-backend-pangandaran.herokuapp.com/',
        options: buildCacheOptions(Duration(hours: 6)),
      );

      ResponseData responseDataRes = ResponseData.fromJson(response.data);

      if (responseDataRes.status == true) {
        return responseDataRes;
      } else {
        return Future<ResponseData>.error("Kesalahan, belum ada data");
      }
    } catch (e) {
      return Future<ResponseData>.error("Kesalahan");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseData>(
      future: _loadingResponseData,
      builder: (BuildContext context, AsyncSnapshot<ResponseData> snapshot) {
        if (snapshot.hasData) {
          List<Widget> pages = [
            MCovidHomeScreen(
              data: snapshot.data,
            ),
            MCovidStatisticScreen(
              data: snapshot.data,
            ),
            MCovidMapsScreen(data: snapshot.data),
          ];

          return Scaffold(
            backgroundColor: Colors.white,
            body: IndexedStack(
              index: _currentIndex,
              children: pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              // elevation: 10,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home,
                    color: ColorPallete.green,
                  ),
                  icon: Icon(
                    Icons.home,
                    color: ColorPallete.grey,
                  ),
                  title: Text('Beranda'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.show_chart,
                    color: ColorPallete.green,
                  ),
                  icon: Icon(
                    Icons.show_chart,
                    color: ColorPallete.grey,
                  ),
                  title: Text('Statistik'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.map,
                    color: ColorPallete.green,
                  ),
                  icon: Icon(
                    Icons.map,
                    color: ColorPallete.grey,
                  ),
                  title: Text('Peta'),
                ),
              ],
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          );
        } else {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.black,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/logo_pangandaran_hebat.png',
                                width: 200,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Portal COVID-19",
                                style: TextStyle(
                                    color: ColorPallete.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Pemerintah Kabupaten Pangandaran",
                                style: TextStyle(color: ColorPallete.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            snapshot.hasError
                                ? Text('Sedang melakukan pemeliharaan',
                                    style:
                                        TextStyle(color: ColorPallete.grey200))
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
