import 'package:covid19/constant.dart';
import 'package:covid19/data/response_data.dart';
import 'package:flui/flui.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class MCovidStatisticScreen extends StatelessWidget {
  static const routeName = 'statistic';

  final ResponseData data;

  MCovidStatisticScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 11,
      child: Scaffold(
        appBar: AppBar(
          title: FLAppBarTitle(
            title: 'Statistik',
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Semua',
              ),
              Tab(
                text: 'Cigugur',
              ),
              Tab(
                text: 'Cijulang',
              ),
              Tab(
                text: 'Cimerak',
              ),
              Tab(
                text: 'Kalipucang',
              ),
              Tab(
                text: 'Langkaplancar',
              ),
              Tab(
                text: 'Mangunjaya',
              ),
              Tab(
                text: 'Padaherang',
              ),
              Tab(
                text: 'Pangandaran',
              ),
              Tab(
                text: 'Parigi',
              ),
              Tab(
                text: 'Sidamulih',
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: <Widget>[
              _createWidget(Cigugur(
                  odpProcess: data.data.odp.process,
                  otgProcess: data.data.otg.process,
                  pdpProcess: data.data.pdp.process,
                  population: data.data.population,
                  positifActive: data.data.confirmed.active,
                  positifDead: data.data.confirmed.dead,
                  positifRecover: data.data.confirmed.recover,
                  ratio: data.data.ratio,
                  percentage: data.data.percentage)),
              _createWidget(data.data.kecamatan.cigugur),
              _createWidget(data.data.kecamatan.cijulang),
              _createWidget(data.data.kecamatan.cimerak),
              _createWidget(data.data.kecamatan.kalipucang),
              _createWidget(data.data.kecamatan.langkaplancar),
              _createWidget(data.data.kecamatan.mangunjaya),
              _createWidget(data.data.kecamatan.padaherang),
              _createWidget(data.data.kecamatan.pangandaran),
              _createWidget(data.data.kecamatan.parigi),
              _createWidget(data.data.kecamatan.sidamulih),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _createWidget(Cigugur kecamatan) {
    bool shouldPiechart = (kecamatan.positifActive +
            kecamatan.positifDead +
            kecamatan.positifRecover) >
        0;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            child: Padding(
              padding: EdgeInsets.only(
                top: 40,
              ),
              child: shouldPiechart
                  ? charts.PieChart(
                      MCovidStatisticScreen._createSampleData(
                          kecamatan.positifActive,
                          kecamatan.positifDead,
                          kecamatan.positifRecover),
                      animate: true,
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.outside)
                          ]),
                    )
                  : Text('Belum ada data di kecamatan ini', style: TextStyle(color: ColorPallete.grey),),
            ),
          ),
          Container(
            child: FLStaticListView(
              sections: [
                FLStaticSectionData(
                  headerTitle: 'Kasus',
                  itemList: [
                    FLStaticItemData(
                        title: 'Terkonfirmasi positif',
                        accessoryType: FLStaticListCellAccessoryType.accNone,
                        subtitle:
                            '${kecamatan.positifActive + kecamatan.positifDead + kecamatan.positifRecover} orang',
                        onTap: null),
                    FLStaticItemData(
                        title: 'Dalam perawatan',
                        accessoryType: FLStaticListCellAccessoryType.accNone,
                        subtitle: '${kecamatan.positifActive} orang',
                        onTap: null),
                    FLStaticItemData(
                        title: 'Meninggal dunia',
                        accessoryType: FLStaticListCellAccessoryType.accNone,
                        subtitle: '${kecamatan.positifDead} orang',
                        onTap: null),
                    FLStaticItemData(
                        title: 'Rasio total kasus dengan populasi',
                        accessoryType: FLStaticListCellAccessoryType.accNone,
                        subtitle:
                            '1 : ${kecamatan.ratio} (${kecamatan.percentage})',
                        onTap: null),
                  ],
                ),
              ],
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearStatus, int>> _createSampleData(
      positif, meninggal, sembuh) {
    final data = [
      new LinearStatus('Aktif', positif),
      new LinearStatus('Meninggal', meninggal),
      new LinearStatus('Sembuh', sembuh),
    ];

    return [
      new charts.Series<LinearStatus, int>(
        id: 'Sales',
        domainFn: (LinearStatus dot, _) => dot.value,
        measureFn: (LinearStatus dot, _) => dot.value,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearStatus row, _) => '${row.text}: ${row.value}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearStatus {
  final String text;
  final int value;

  LinearStatus(this.text, this.value);
}
