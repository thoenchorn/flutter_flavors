/// List extensions for common operations
extension ListExtensions<T> on List<T> {
  /// Check if list is null or empty
  bool get isNullOrEmpty => isEmpty;

  /// Check if list is not null and not empty
  bool get isNotNullOrEmpty => isNotEmpty;

  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  /// Get element at index or null if out of bounds
  T? elementAtOrNull(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }

  /// Split list into chunks of specified size
  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Size must be positive');

    final chunks = <List<T>>[];
    for (int i = 0; i < length; i += size) {
      final end = (i + size < length) ? i + size : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  /// Remove duplicates while preserving order
  List<T> get unique {
    final seen = <T>{};
    return where((element) => seen.add(element)).toList();
  }

  /// Get random element from list
  T? get random {
    if (isEmpty) return null;
    final randomIndex = DateTime.now().millisecondsSinceEpoch % length;
    return this[randomIndex];
  }

  /// Count occurrences of element
  int count(T element) => where((e) => e == element).length;

  /// Check if list contains all elements from another list
  bool containsAll(List<T> elements) => elements.every(contains);

  /// Check if list contains any element from another list
  bool containsAny(List<T> elements) => elements.any(contains);

  /// Insert element at index if index is valid
  void insertSafe(int index, T element) {
    if (index >= 0 && index <= length) {
      insert(index, element);
    }
  }

  /// Remove element at index if index is valid
  T? removeAtSafe(int index) {
    return (index >= 0 && index < length) ? removeAt(index) : null;
  }
}

/// Iterable extensions
extension IterableExtensions<T> on Iterable<T> {
  /// Sum of numeric values
  num sum<E extends num>(E Function(T) getValue) {
    return fold<num>(0, (prev, element) => prev + getValue(element));
  }

  /// Average of numeric values
  double average<E extends num>(E Function(T) getValue) {
    if (isEmpty) return 0.0;
    return sum(getValue) / length;
  }

  /// Group elements by key
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keySelector(element);
      map.putIfAbsent(key, () => <T>[]).add(element);
    }
    return map;
  }

  /// Find min element by selector
  T? minBy<E extends Comparable<E>>(E Function(T) selector) {
    if (isEmpty) return null;

    T minElement = first;
    E minValue = selector(minElement);

    for (final element in skip(1)) {
      final value = selector(element);
      if (value.compareTo(minValue) < 0) {
        minElement = element;
        minValue = value;
      }
    }

    return minElement;
  }

  /// Find max element by selector
  T? maxBy<E extends Comparable<E>>(E Function(T) selector) {
    if (isEmpty) return null;

    T maxElement = first;
    E maxValue = selector(maxElement);

    for (final element in skip(1)) {
      final value = selector(element);
      if (value.compareTo(maxValue) > 0) {
        maxElement = element;
        maxValue = value;
      }
    }

    return maxElement;
  }
}
