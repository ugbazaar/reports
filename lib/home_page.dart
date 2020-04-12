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
        title: Text("Http Test App"),
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
                      childAspectRatio: 1.8),
                  children: <Widget>[
                    customTemplate(
                        "Year-to-Year Today", snapshot.data.appDataModel[0]),
                    customTemplate(
                        "Year-to-Year 7 Days", snapshot.data.appDataModel[1]),
                    customTemplate(
                        "Year-to-Year 30 Days", snapshot.data.appDataModel[2]),
                    customTemplate(
                        "Year-to-Year 90 Days", snapshot.data.appDataModel[3]),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                  ),
                ),
                Divider(),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Last Year",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        Text("${dataModel.lastYear.createdCount} new orders"),
                        Text("Rs. ${dataModel.lastYear.createdAmount}"),
                        Text("${dataModel.lastYear.deliveredCount} deliveries"),
                        Text("Rs. ${dataModel.lastYear.deliveredAmount}"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "This Year",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        Text("${dataModel.thisYear.createdCount} new orders"),
                        Text("Rs. ${dataModel.thisYear.createdAmount}"),
                        Text("${dataModel.thisYear.deliveredCount} deliveries"),
                        Text("Rs. ${dataModel.thisYear.deliveredAmount}"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Change",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w700),
                        ),
                        Divider(),
                        Text(
                            "${dataModel.difference.createdCount.sign}${dataModel.difference.createdCount.percent}%"),
                        Text(
                            "${dataModel.difference.createdCount.sign}${dataModel.difference.createdAmount.percent}%"),
                        Text(
                            "${dataModel.difference.createdCount.sign}${dataModel.difference.deliveredCount.percent}%"),
                        Text(
                            "${dataModel.difference.createdCount.sign}${dataModel.difference.deliveredAmount.percent}%"),
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
