import 'package:flutter_core_basic/widgets/widget_loading.dart';

import '../../services/graphql/graphql_list_load_more_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// typedef Builder<T> = Widget Function(T valueItem);

abstract class LoadMoreController<D, T extends GraphqlListLoadMoreProvider> {
  ScrollController scrollController = ScrollController();
  late Color primaryColor;

  init({required controller, required Color primaryColor}) {
    this.primaryColor = primaryColor;

    if (controller is T) {
      scrollController.addListener(() async {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          controller.loadMore();
        }
      });
    }
  }

  Widget widgetLoading({
    required bool notData,
    String? title,
    String? titleNotData,
    int? count,
  });

  Widget widgetItemLoadMore(D data, int index);

  widgetLoadMore(
      {String? tag,
      Function? onRefresh,
      EdgeInsetsGeometry? padding,
      bool reverse = false}) {
    return GetBuilder<T>(
        tag: tag,
        builder: (controller) {

          if(onRefresh==null){
            return ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: padding,
              reverse: reverse,
              itemCount: controller.loadMoreItems.value.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.loadMoreItems.value.length) {
                  if (controller.loadMoreItems.value.length >=
                      (controller.pagination.value.limit ?? 10) ||
                      controller.loadMoreItems.value.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: widgetLoading.call(
                        notData: controller.lastItem,
                        count: controller.loadMoreItems.value.length,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                if (controller.lastItem == false &&
                    controller.loadMoreItems.value.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: widgetLoading.call(notData: false),
                  );
                }
                return widgetItemLoadMore.call(
                    controller.loadMoreItems.value[index], index);
              },
            );
          }
          return RefreshIndicator(
            color: primaryColor,
            onRefresh: () async {
              onRefresh.call();
            },
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: padding,
              reverse: reverse,
              itemCount: controller.loadMoreItems.value.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.loadMoreItems.value.length) {
                  if (controller.loadMoreItems.value.length >=
                          (controller.pagination.value.limit ?? 10) ||
                      controller.loadMoreItems.value.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: widgetLoading.call(
                        notData: controller.lastItem,
                        count: controller.loadMoreItems.value.length,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                if (controller.lastItem == false &&
                    controller.loadMoreItems.value.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: widgetLoading.call(notData: false),
                  );
                }
                return widgetItemLoadMore.call(
                    controller.loadMoreItems.value[index], index);
              },
            ),
          );
        });
  }
}
