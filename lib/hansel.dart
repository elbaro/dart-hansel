class Forest {
  Map _map;
  int _id;

  Forest() {
    _map = Map();
    _id = 0;
  }
  // void add_crumb(String path) {}
  int add(List<String> path, [bool invalidateOld = false]) {
    var m = _map;
    int n = path.length;
    for (var p in path) {
      var m2 = m[p];
      if (m2 == null) {
        m2 = m[p] = {};
      }
      m = m2;
    }

    _id++;
    if (invalidateOld || !m.containsKey('_'))
      m['_'] = Set.from([_id]);
    else
      m['_'].add(_id);

    return _id;
  }

  bool eat(List<String> path, int crumb) {
    var m = _map;
    int n = path.length;
    for (var p in path) {
      m = m[p];
      if (m == null) return false;
    }
    if (m.containsKey('_')) return m['_'].remove(crumb);
    return false;
  }

  bool eat_up(List<String> path) {
    var m = _map;
    for (var p in path) {
      m = m[p];
      if (m == null) return false;
    }
    m.clear();
    return true;
  }

  debug() {
    print('----- START -----');
    _print('', _map);
    print('-------END-------');
    print('');
  }

  _print(String path, Map m) {
    m.forEach((k, v) {
      if (k == '_')
        for (var c in v) print('$path: $c');
      else if (path == '')
        _print('$k', v);
      else
        _print('$path.$k', v);
    });
  }
}

// void main() {
//   var f = Forest();
//   var c = f.add(['a', 'b', 'c']);
//   c = f.add(['a', 'b']);
//   f.debug();
//   f.eat_up(['a', 'b']);
//   f.debug();
//   print(c);
// }
