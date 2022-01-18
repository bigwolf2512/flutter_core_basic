import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'crud_repo.dart';
import 'graphql_list_provider.dart';

class GraphqlListLoadMoreProvider<T> extends GraphqlListProvider<T> {
  Rx<List<T>> loadMoreItems = Rx<List<T>>([]);
  bool lastItem = false;
  int defaultLimit = 10;

  GraphqlListLoadMoreProvider(
      {required service, QueryInput? query, required String fragment})
      : super(service: service, query: query, fragment: fragment);

  Future loadMore() async {
    // print("length - ${this.loadMoreItems.value}");
    // print("lastItem - ${this.lastItem}");
    // print("this.pagination.value.page  ${this.pagination.value.page }");
    if (lastItem == true) return;
    var items = await loadAll(
        query: QueryInput(page: (pagination.value.page ?? 0) + 1));
    // print("items.length ${items.length}");
    if (items.length < (pagination.value.limit ?? defaultLimit)) {
      lastItem = true;
    }
    loadMoreItems.value = [...loadMoreItems.value, ...items];

    update();
  }

  refreshData({query}) async {
    lastItem = false;
    await service.clearCache();
    await loadAll(query: query ?? QueryInput(page: 1));
  }

  @override
  Future<List<T>> loadAll({QueryInput? query}) async {
    return super.loadAll(query: query).then((res) {
      if (pagination.value.page == 1) {
        if (res.length < (pagination.value.limit ?? defaultLimit)) {
          lastItem = true;
        }
        loadMoreItems.value = res;
        // print("res.total - $total - ${res.length}");
        //
        // print("loadAll length - ${this.loadMoreItems.value.length}");

        ///region dùng test data
        // loadMoreItems.value.addAll(res);
        // loadMoreItems.value.addAll(res);
        // loadMoreItems.value.addAll(res);
        ///endregion
      }
      update();

      return res;
    });
  }
}
