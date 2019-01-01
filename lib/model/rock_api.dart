import 'package:http/http.dart' show Client;
import 'dart:async';
import 'dart:convert';
import 'Contribution.dart';

class RockApi {
  final Client _client = Client();
  static const String _url = "https://utopian.rocks/api/posts?status={0}";

  Future<List<Contribution>> getContribution(
      {String pageName = "unreviewed"}) async {
    List<Contribution> res = [];
    var url = Uri.parse(_url.replaceFirst("{0}", pageName));
    print(url);
    await _client
        .get(url)
        .then((result) {
          return result.body;
        })
        .then(json.decode)
        .then((json) {
          return json.forEach((contribution) {
            Contribution con = Contribution.fromJson(contribution);
            if (con.status == pageName) {
              res.add(con);
            }
          });
        });
    return res;
  }
}
