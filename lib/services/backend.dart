const host = '172.20.10.3';
const port = '8080';

Uri generateUrl(String path, [Map<String, String> param]) {
  return Uri.http('$host:$port', path, param);
}
