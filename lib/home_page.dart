import 'package:flutter/material.dart';
import 'package:http_test/service/service.dart';

import 'model/app_data_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Future<AppDataModel> fetchData() async {
  return await Service().getTestData();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Year to Year Comparison"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchData(),
          builder:
              (BuildContext context, AsyncSnapshot<AppDataModel> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 1
                          : 2,
                      childAspectRatio: 1.7),
                  children: <Widget>[
                    customTemplate(
                        "Year-to-Year Today", snapshot.data.appDataModel[0]),
                    customTemplate("Year-to-Year 7 Days (Excl. Today)",
                        snapshot.data.appDataModel[1]),
                    customTemplate("Year-to-Year 30 Days (Excl. Today)",
                        snapshot.data.appDataModel[2]),
                    customTemplate("Year-to-Year 90 Days (Excl. Today)",
                        snapshot.data.appDataModel[3]),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customTemplate(String title, DataModel dataModel) {
    Color backgroundColor = Color(0x99ffaa00);
    if (dataModel.difference.createdCount.sign == '+' &&
        dataModel.difference.createdAmount.sign == '+' &&
        dataModel.difference.deliveredCount.sign == '+' &&
        dataModel.difference.deliveredAmount.sign == '+') {
      backgroundColor = Color(0xaa00ff00);
    } else if (dataModel.difference.createdAmount.sign == '+' &&
        dataModel.difference.deliveredAmount.sign == '+') {
      backgroundColor = Color(0x3300ff00);
    } else if (dataModel.difference.createdAmount.sign == '-' &&
        dataModel.difference.deliveredAmount.sign == '-') {
      backgroundColor = Color(0xaaff0000);
    } else if (dataModel.difference.createdAmount.sign == '-' ||
        dataModel.difference.deliveredAmount.sign == '-') {
      backgroundColor = Color(0x44ff0000);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 100,
        child: Card(
          color: backgroundColor, // This color should be dyanamic
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Last Year",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Divider(),
                        Text("${dataModel.lastYear.createdCount} new orders:"),
                        Text(
                          "Rs. ${dataModel.lastYear.createdAmount}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                            "${dataModel.lastYear.deliveredCount} deliveries:"),
                        Text(
                          "Rs. ${dataModel.lastYear.deliveredAmount}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "This Year",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Divider(),
                        Text("${dataModel.thisYear.createdCount} new orders:"),
                        Text(
                          "Rs. ${dataModel.thisYear.createdAmount}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                            "${dataModel.thisYear.deliveredCount} deliveries:"),
                        Text(
                          "Rs. ${dataModel.thisYear.deliveredAmount}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Change",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        Divider(),
                        Text(
                            "${dataModel.difference.createdCount.sign}${dataModel.difference.createdCount.percent}%"),
                        Text(
                            "${dataModel.difference.createdAmount.sign}${dataModel.difference.createdAmount.percent}%"),
                        SizedBox(height: 15),
                        Text(
                            "${dataModel.difference.deliveredCount.sign}${dataModel.difference.deliveredCount.percent}%"),
                        Text(
                            "${dataModel.difference.deliveredAmount.sign}${dataModel.difference.deliveredAmount.percent}%"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
