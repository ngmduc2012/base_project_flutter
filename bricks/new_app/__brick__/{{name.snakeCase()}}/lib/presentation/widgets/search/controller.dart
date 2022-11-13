import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import 'dart:developer' as d;

import '../../../app/core/routes/routes.dart';
import '../../../app/types/image_theme.dart';
import '../../../data/modles/list_item.dart';

class SearchController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  List<ListItem> list = [
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Minh Đức",
        detail: "CEO Apple",
        id: 1),
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Kim Bảng",
        detail: "CEO Google",
        id: 2),
    ListItem(
        avatar: avatarImage,
        title: "Phạm Thị Thu Hiền",
        detail: "CEO Microsoft",
        id: 3),
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Ngọc Khoa",
        detail: "CEO Nhật Nam",
        id: 4),
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Văn Phiến",
        detail: "CEO Amway",
        id: 5),
    ListItem(
        avatar: avatarImage, title: "Bùi Thị Vê", detail: "CEO Alibaba", id: 6),
    ListItem(
        avatar: avatarImage,
        title: "Phạm Văn Mộc",
        detail: "CEO Tiktok",
        id: 7),
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Thị Khuyên",
        detail: "CEO Facebook",
        id: 8),
    ListItem(
        avatar: avatarImage,
        title: "Nguyễn Lương Hàn",
        detail: "CEO Mitas",
        id: 9)
  ];

  List<ListItem> listSearch = [];

  @override
  void onInit() {
    super.onInit();
    listSearch = list;
    searchFocusNode = FocusNode();
    update();
  }

  /// Sử dụng cho chọn 1
  int? selected;

  onChanged(value) {
    selected = value;
    update();
  }

  /// Sử dụng cho chọn nhiều
  List<int> multiSelected = [];

  groupValue(value) {
    for (var element in multiSelected) {
      if (element == value) {
        return value;
      }
    }
    return null;
  }

  onChangedMulti(value, index) {
    if (value == null) {
      multiSelected.remove(index);
      update();
      return;
    }
    if (multiSelected.contains(value)) {
      multiSelected.remove(value);
    } else {
      multiSelected.add(value);
    }

    update();
  }

  /// Filter
  search(value) {
    listSearch =
        list.where((element) => element.title!.contains(value)).toList();
    update();
  }

  List<ListItem> listResult = [];

  getBack() {
    listResult = [];
    for (var item in multiSelected) {
      listResult.add(list.firstWhere((element) => element.id == item));
    }
    // d.log("+${listResult.length}");
    // listResult = list.where((element) => element).toList();
  }

  /// Search buttom
  late FocusNode searchFocusNode;

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  searchBottom() {
    searchFocusNode.requestFocus();
  }
}
