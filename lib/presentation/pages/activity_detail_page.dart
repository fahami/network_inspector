import 'package:flutter/material.dart';
import 'package:network_inspector/const/network_inspector_value.dart';
import 'package:network_inspector/presentation/widgets/container_label.dart';
import 'package:network_inspector/presentation/widgets/titled_label.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/http_activity.dart';
import '../../network_inspector_presentation.dart';

class ActivityDetailPage extends StatelessWidget {
  final HttpActivity httpActivity;
  const ActivityDetailPage({
    required this.httpActivity,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ActivityDetailProvider>(
      create: (context) => ActivityDetailProvider(
        httpActivity: httpActivity,
        context: context,
      ),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Detail Http Activity'),
        ),
        body: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyHeader(context),
          const Divider(),
          bodyContent(context),
        ],
      ),
    );
  }

  Widget bodyHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitledLabel(
          title: 'Url',
          text: httpActivity.request?.url,
        ),
        TitledLabel(
          title: 'Method',
          content: ContainerLabel(
            text: httpActivity.request?.method,
            color: NetworkInspectorValue
                .containerColor[httpActivity.request?.method]!,
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget bodyContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitledLabel(
          title: 'Size',
          text: '${httpActivity.request?.requestSize ?? 0} kb',
        ),
        const SizedBox(height: 8),
        TitledLabel(
          title: 'Header',
          content: bodyContentHeader(context),
        ),
        const SizedBox(height: 8),
        TitledLabel(
          title: 'Body',
          text: '${httpActivity.request?.requestBody ?? 0}',
        ),
      ],
    );
  }

  Widget bodyContentHeader(BuildContext context) {
    return Visibility(
      visible: Provider.of<ActivityDetailProvider>(context).headerIsNotEmpty(
        httpActivity.request?.requestHeader,
      ),
      replacement: const Text('N/A'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(httpActivity.request?.requestHeader ?? 'N/A'),
          ],
        ),
      ),
    );
  }
}
