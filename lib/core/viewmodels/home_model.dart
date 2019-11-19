import 'package:love_book/core/models/request.dart';
import 'package:love_book/core/service/requests_service.dart';
import 'package:love_book/core/viewmodels/base_model.dart';
import 'package:love_book/core/viewstate.dart';
import 'package:love_book/locator.dart';

class HomeModel extends BaseModel {
  final RequestsService _requestsService = locator<RequestsService>();
  Request request;

  HomeModel() {
    _requestsService.request.listen(_onRequestChanged);
  }

  void fetchRequests(String uid) {
    _requestsService.fetchRequests(uid);
  }

  void _onRequestChanged(Request request) {
    this.request = request;

    setState(ViewState.DataFetched);
  }
}
