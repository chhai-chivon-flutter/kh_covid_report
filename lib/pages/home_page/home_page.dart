import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/api_service/mock_api_provider.dart';
import 'package:flutter_boiler_plate/constant/resource_path.dart';
import 'package:flutter_boiler_plate/model/dummy_model.dart';
import 'package:flutter_boiler_plate/widgets/common/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../bloc/base_extend_stream.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BaseStream<List<User>> baseStream = BaseStream();

  Future fetchUsers() async {
    baseStream.operation(() async {
      return await MockApiProvider().fetchUserList();
    });
  }

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  @override
  void dispose() {
    baseStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalization.of(context);
    return Provider<BaseStream<List<User>>>(
      create: (_) => baseStream,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Boilerplate"),
          actions: <Widget>[
            IconButton(
              icon: Image.asset(R.images.appicon),
              onPressed: () {},
            )
          ],
        ),
        body: ConnectionChecker(
          reactToConnectionChange: true,
          child: StreamHandler<List<User>>(
            stream: baseStream.stream,
            error: (error) => Text(error, textAlign: TextAlign.center),
            loading: LoadingWidget(),
            ready: (data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = data[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: Text(user.company.name),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
