import 'package:http/http.dart' as http;

abstract class Repository {
  final _baseUrl = "https://flutterpos-faf67-default-rtdb.firebaseio.com/";
  final String _resource;
  Repository(this._resource);

  Future<http.Response> list() {
    final uri = Uri.parse("$_baseUrl/$_resource.json");
    return http.get(uri);
  }

  Future<http.Response> insert(String data) {
    final uri = Uri.parse("$_baseUrl/$_resource.json");
    return http.post(uri, body: data);
  }

  Future<http.Response> show(String id) {
    final uri = Uri.parse("$_baseUrl/$_resource/$id.json");
    return http.get(uri);
  }

  Future<http.Response> update(String id, String data) {
    final uri = Uri.parse("$_baseUrl/$_resource/$id.json");
    return http.put(uri, body: data);
  }

  Future<http.Response> delete(String id) {
    final uri = Uri.parse("$_baseUrl/$_resource/$id.json");
    return http.delete(uri);
  }
}
