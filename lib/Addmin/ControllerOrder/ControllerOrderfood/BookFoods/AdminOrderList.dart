import 'package:flutter/material.dart';

class AdminOrderList extends StatefulWidget {
  int bt_id;
  List<int> id = [];
  List<String> nameFood;
  List<int> priceFood;
  List<String> imgFood;
  AdminOrderList({this.bt_id, this.id, this.nameFood, this.imgFood, this.priceFood});

  @override
  State<AdminOrderList> createState() => _AdminOrderListState();
}

class _AdminOrderListState extends State<AdminOrderList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
