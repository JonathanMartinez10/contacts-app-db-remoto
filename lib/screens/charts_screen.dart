import 'package:contacts_app/services/data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/contact.dart';

class GenderPieChart extends StatefulWidget {
  const GenderPieChart({super.key});

  @override
  State<GenderPieChart> createState() => _GenderPieChartState();
}

class _GenderPieChartState extends State<GenderPieChart> {
  List<Contact> contacts = [];
  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    // Obtener los datos de la base de datos
    List<Contact> fetchedContacts = await getAllContacts();

    setState(() {
      contacts = fetchedContacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<GenderData> genderDataList = [];

    List<CivilStatusData> civilStatusDataList = [];
    // Contar la cantidad de personas por género
    int maleCount = 0;
    int femaleCount = 0;
    int otherCount = 0;

    int singleCount = 0;
    int marriedCount = 0;
    int divorcedCount = 0;
    int widowedCount = 0;

    for (var contact in contacts) {
      if (contact.gender == 'Masculino') {
        maleCount++;
      } else if (contact.gender == 'Femenino') {
        femaleCount++;
      } else if (contact.gender == 'Otro') {
        otherCount++;
      }
    }

    for (var contact in contacts) {
      if (contact.civilstatus == 'Soltero/a') {
        singleCount++;
      } else if (contact.civilstatus == 'Casado/a') {
        marriedCount++;
      } else if (contact.civilstatus == 'Divorciado/a') {
        divorcedCount++;
      } else if (contact.civilstatus == 'Viudo/a') {
        widowedCount++;
      }
    }

    genderDataList.add(GenderData('Masculino', maleCount, Colors.blue));
    genderDataList.add(GenderData('Femenino', femaleCount, Colors.pink));
    genderDataList.add(GenderData('Otro', otherCount, Colors.green));

    civilStatusDataList.add(CivilStatusData(
        'Soltero/a', singleCount, const Color.fromARGB(255, 11, 211, 17)));
    civilStatusDataList.add(CivilStatusData(
        'Casado/a', marriedCount, const Color.fromARGB(255, 192, 13, 0)));
    civilStatusDataList.add(CivilStatusData(
        'Divorciado/a', divorcedCount, const Color.fromARGB(255, 126, 2, 148)));
    civilStatusDataList
        .add(CivilStatusData('Viudo/a', widowedCount, Colors.grey));

    // Crear el gráfico de pastel
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Graficas',
          style: TextStyle(fontSize: 26.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 26.0,
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Genero', textStyle: const TextStyle(fontSize: 20)),
              legend: Legend(
                  iconHeight: 20.0,
                  iconWidth: 20.0,
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: const TextStyle(fontSize: 16.0)),
              series: <CircularSeries>[
                PieSeries<GenderData, String>(
                  dataSource: genderDataList,
                  xValueMapper: (GenderData data, _) => data.gender,
                  yValueMapper: (GenderData data, _) => data.count,
                  pointColorMapper: (GenderData data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside),
                ),
              ],
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: 'Estado Civil',
                  textStyle: const TextStyle(fontSize: 20)),
              legend: Legend(
                  iconHeight: 20.0,
                  iconWidth: 20.0,
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  textStyle: const TextStyle(fontSize: 16.0)),
              series: <CircularSeries>[
                PieSeries<CivilStatusData, String>(
                    dataSource: civilStatusDataList,
                    xValueMapper: (CivilStatusData data, _) => data.civilStatus,
                    yValueMapper: (CivilStatusData data, _) => data.count,
                    pointColorMapper: (CivilStatusData data, _) => data.color,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.inside,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GenderData {
  final String gender;
  final int count;
  final Color color;

  GenderData(this.gender, this.count, this.color);
}

class CivilStatusData {
  final String civilStatus;
  final int count;
  final Color color;

  CivilStatusData(this.civilStatus, this.count, this.color);
}
